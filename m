From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Oct 2011 10:11:19 +0100
Subject: [GIT PULL] i.MX6Q support
In-Reply-To: <CAGsJ_4z7AUQmfH47kmjBvGTtwoKWitOH6WWx5cRRmz51-+hYFQ@mail.gmail.com>
References: <20111020171158.GJ32007@S2100-06.ap.freescale.net>
	<20111020211834.GF21648@n2100.arm.linux.org.uk>
	<CAGsJ_4z7AUQmfH47kmjBvGTtwoKWitOH6WWx5cRRmz51-+hYFQ@mail.gmail.com>
Message-ID: <20111024091119.GB9893@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2011 at 09:15:38AM +0800, Barry Song wrote:
> 2011/10/21 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > On Fri, Oct 21, 2011 at 01:11:59AM +0800, Shawn Guo wrote:
> >> Please pull imx6q series. ?It's based on v3.1-rc10 with the following
> >> branches merged plus a number of cache-l2x0 patches currently sitting
> >> on rmk/for-next.
> >
> > Don't do that. ?If there's something you need, _ask_ me. ?The L2x0
> > patches got shuffled out into their own branch when the SMP and debug
> > patches got split out of the 'misc' branch.
> 
> does it mean i can rebase the prima2 l2 patch based on the rmk/l2
> branch with the two commits i need:
> ARM: 7090/1: CACHE-L2X0: filter start address can be 0 and is often 0;
> ARM: 7114/1: cache-l2x0: add resume entry for l2 in secure mode

The l2x0 branch contains these commits, so you can use that as a basis
for your work.  If you have other dependencies, you may have to merge
this with other branches.

Note - an issue which came up with the GIC PPI pull request - if
you're merging by commit ID, please go back and edit the commit
message using git commit --amend and make it _more_ informative.  This
is far from a useful commit message:

	Merge commit '32cffdd' into ppi-irq-core-for-rmk

What this is actually doing is merging Thomas' IRQ tree, but that message
gives no clue that's what happened.  On the other hand, a real pull gives
this kind of message:

	Merge branch 'ppi-irq-core-for-rmk' of git://github.com/mzyngier/arm-platforms into devel-stable

And this says exactly what tree is being merged from where - and such
a line explains why the other commits (which come from someone elses
tree) are there.
