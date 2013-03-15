#!/usr/bin/env perl

use strict;
use warnings;

use Furl;

my $f = Furl->new;

my $res = $f->get('http://lingr.com/room/perl_jp');
die $res->status_line unless $res->is_success;

my ($messages) = $res->content =~ m!<span class="count">(\d+) messages</span>!;
my ($online)   = $res->content =~ m!<span class="chatter">(\d+) chatters</span>!;
my ($members)  = $res->content =~ m!<h3>Members \((\d+)\)</h3>!;

$f->post('http://test.gfaas.com/api/lingr_perl_jp/stats/total_messages', [], [
    number => $messages,
]);

$f->post('http://test.gfaas.com/api/lingr_perl_jp/stats/online_users', [], [
    number => $online,
]);

$f->post('http://test.gfaas.com/api/lingr_perl_jp/stats/members', [], [
    number => $members,
]);
