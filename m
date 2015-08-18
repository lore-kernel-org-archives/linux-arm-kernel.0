From: olof@lixom.net (Olof Johansson)
Date: Tue, 18 Aug 2015 23:49:30 +0200
Subject: [GIT PULL] at91: defconfig for 4.3 #2
In-Reply-To: <20150814092237.3551c03e@canb.auug.org.au>
References: <20150807162754.GA20169@piout.net>
 <20150813100938.GN30160@localhost>
 <20150813112118.GA22269@piout.net>
 <20150813122643.GA23581@localhost>
 <20150814092237.3551c03e@canb.auug.org.au>
Message-ID: <CAOesGMhwAYUAMLyT6TH38-0VmZNLEpcd_=Tq=EF1KJ=eywBmUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Fri, Aug 14, 2015 at 1:22 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Olof,
>
> On Thu, 13 Aug 2015 14:26:43 +0200 Olof Johansson <olof@lixom.net> wrote:
>>
>> On Thu, Aug 13, 2015 at 01:21:18PM +0200, Alexandre Belloni wrote:
>> > On 13/08/2015 at 12:09:38 +0200, Olof Johansson wrote :
>> > > On Fri, Aug 07, 2015 at 06:27:54PM +0200, Alexandre Belloni wrote:
>> > > >
>> > > > A little defconfig update. That will probably be all for this cycle.
>> > > >
>> > > > Thanks, bye,
>> > > >
>> > > >
>> > > > The following changes since commit eff7f41572a645bf14a96a6f844be4f1c88cd9dd:
>> > > >
>> > > >   ARM: at91: at91_dt_defconfig: enable ISI and ov2640 support (2015-07-30 14:17:31 +0200)
>> > > >
>> > > > are available in the git repository at:
>> > > >
>> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-defconfig2
>> > > >
>> > > > for you to fetch changes up to ea7bf603fd494391acc1f42acbfc34260b965c44:
>> > > >
>> > > >   ARM: at91/defconfig: at91_dt: remove ARM_AT91_ETHER (2015-08-07 12:07:50 +0200)
>> > >
>> > > Nicolas had sent me one patch which you've also included here but it's not in
>> > > the pull request ("enable ISI and ov2640 support"). That caused a conflict
>> > > here, so to avoid having the patch in the tree twice I instead also directly
>> > > applied your patches from this branch instead of merging.
>> > >
>> > > Sorry about that, it started due to Nicolas sending the discrete patch to us.
>> > > So it seems like we'll apply at91 defconfig updates directly this release, in
>> > > case there are any more. No big deal I hope. :)
>> >
>> > That's not a big deal and there will most probably be all for that cycle
>> > anyway.
>> >
>> > However, I'm wondering how I should have done. From the PR, if you get
>> > eff7f41572a645bf14a96a6f844be4f1c88cd9dd..tags/at91-ab-defconfig2, it
>> > correctly excludes "enable ISI and ov2640 support" so I was thinking it
>> > was fine.
>> > Be cause the first patch was taken as a patch, should I have prepared a
>> > branch without it?
>>
>> Yeah, you could have applied the other two if there were no conflicts. If there
>> were conflicts then it gets complicated, and the best answer would probably
>> have been to continue applying directly as patches.
>>
>> This is the drawback of us sometimes applying patches directly -- when we do,
>> we no longer put them on a branch of their own that you can use as base. We
>> used to once upon a time but it is quite a bit of overhead for us and the
>> upside was pretty limited.
>
> The only thing now is that since the at91 tree is in linux-next as well
> as the arm-soc tree, those patches appear twice there and there is a
> conflict (easy to fix, but a pain).  The solution here is to update the
> at91 tree to be somewhere in the arm-soc tree (probably just reset to
> the point where the two trees match in patches but not commits).  This
> has the downside that the at91 tree will be rebased which will affect
> any development work that is based on that.
>
> If there was just one patch in common, it maybe have been better to
> just merge the at91 tree and fix the conflict in the merge.

Yeah, this is a somewhat frustrating situation for us. I wonder if we
should essentially tag the downstream ARM platform trees in -next such
that if they conflict with arm-soc, you can drop them for a day if
needed.

It's really useful for us to be able to occasionally adjust a pull
request instead of always merging them exactly as they're presented to
us. It saves a roundtrip to the maintainer for trivial stuff, we can
take care of it and not have to look at it again. We often do send it
back to the maintainers to respin, but in this particular case it
seemed appropriate to just deal with it locally for us.

The downstream users vs rebasing git trees is of course another
aspect. Here I'm mostly relying on subplatform maintainers to know
well how many people actually develop on top of their trees. I think
for most platforms it's a fairly limited use. Interesting enough, I
can't remember last time someone told me they couldn't respin a pull
request to fix something up due to downstream developers (not that we
have _all_ that many of those requests).

The other way to handle this would be to only apply patches directly
and not do merges. Most other high-volume maintainers have exactly
this workflow. We've been able to avoid reverting to that, thankfully
(since we can delegate most of the reviews and patch applications this
way).


-Olof
