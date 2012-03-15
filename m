From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 15 Mar 2012 18:17:18 +1100
Subject: Conflict between Versatile Express DT conversion and local
 timer updates
In-Reply-To: <4F605A3B.5030800@arm.com>
References: <20120312231016.GC10830@n2100.arm.linux.org.uk>
 <201203131155.16454.arnd@arndb.de> <4F5F52A2.3050005@arm.com>
 <201203131433.07214.arnd@arndb.de>
 <CAOesGMjo=JT3TKwne+m5XUpkBMQFKQLZrr1T60m+Wx7YgqMiOA@mail.gmail.com>
 <4F605A3B.5030800@arm.com>
Message-ID: <20120315181718.d80071db25428a7b5113ef9a@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Wed, 14 Mar 2012 08:43:39 +0000 Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> On 14/03/12 00:52, Olof Johansson wrote:
> > On Tue, Mar 13, 2012 at 7:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Tuesday 13 March 2012, Marc Zyngier wrote:
> >>> On 13/03/12 11:55, Arnd Bergmann wrote:
> >>>> On Tuesday 13 March 2012, Marc Zyngier wrote:
> >>>>> On 13/03/12 10:15, Russell King - ARM Linux wrote:
> >>
> >>>> d) create a new next/timer branch in arm-soc that has Pawel's
> >>>>    98ed4ceb "ARM: vexpress: Get rid of MMIO_P2V" (the first patch from
> >>>>    vexpress/dt, your patches and the ux500/timer series. Also put
> >>>>    98ed4ceb into the next/cleanup branch.
> >>>>
> >>>> Any of those will work for us, my preference would be on #4. I have
> >>>> created the next/timer branch in the arm-soc tree, so you can use
> >>>> that and either rebase your patches on top or merge your tree into
> >>>> it and fix up the merge conflicts.
> >>>
> >>> Thanks for doing that Arnd.
> >>>
> >>> I've thus created a new branch:
> >>> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
> >>> local_timers-for-arm-soc
> >>>
> >>> which contains the arm-soc next/timers branch as well as my local timers
> >>> series. I'd greatly appreciate if you could pull it for 3.4.
> >>>
> >>
> >> I've updated the next/timer branch with your changes now, but did not
> >> put it into the for-next branch because Olof is currently handling that.
> >>
> >> Olof, can you add it to for-next please? The timer branch should have
> >> no dependencies other than rmk/for-armsoc, so it can be fairly close to
> >> the start.
> > 
> > 
> > Thanks. I merged into for-next, but since there's already a history in
> > there and I didn't rebuild it, it's on top of everything else.
> > 
> > I got two trivial merge conflicts (and a few that git sorted out
> > automatically): one with the tegra makefile, the other with shmobile's
> > timer init.
> > 
> > Marc, please take a look at the next/timers merge in the arm-soc
> > for-next branch and let me know if they're OK. I'm pretty sure they
> > are though.
> 
> Had a brief look, and it seems alright to me.
> 
> Thanks Olof!

ok, it looks like Marc's series is now in both the arm and arm-soc trees
(and causing some conflicts due to other changes to the files involved
and some resolved conflicts).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120315/29cf3ba2/attachment.sig>
