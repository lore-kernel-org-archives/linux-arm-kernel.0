From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 1 Mar 2010 10:39:27 +0100
Subject: [GIT PULL] pxa: patches for next merge window
In-Reply-To: <20100228161449.GD16745@n2100.arm.linux.org.uk>
References: <f17812d71002241849m6b37f601h7eef1a723b2d0335@mail.gmail.com>
	<20100225205113.GF3101@n2100.arm.linux.org.uk>
	<20100225212915.GA24043@n2100.arm.linux.org.uk>
	<f17812d71002260105q54c26198jc9b61851c35ae8ef@mail.gmail.com>
	<20100228161449.GD16745@n2100.arm.linux.org.uk>
Message-ID: <20100301093927.GC29952@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

> > This one actually has been merged into 'fix' and been there in -rc8
> > already. Now we have to live with this duplicate commit, it's my fault.
> > 
> > > which follows:
> > >
> > > [ARM] pxa/raumfeld: add defconfig
> > > [ARM] pxa/raumfeld: add platform support
> > >
> > > in your previous pull request? ?I can find these two in your latest with
> > > different commit IDs, but not the pxa/ttc_dkb patch.
> > >
> > 
> > I've sorted this out by merging your devel branch back, and rebased
> > the remaining patches on top of it. Please try re-pull. A rough test
> > here at my side shows a clean merge so far.
> 
> That isn't a fix - merging my devel branch just causes more problems
> because it regularly gets rebuilt.
> 
> The 'devel' branch contains individual patches, and is regularly re-
> generated from individual sub-branches.
> 
> The 'devel-stable' branch (internal) contains work pulled from other
> people, and the 'stable' bit means that I once pulled, I don't wind
> the tree back at any point.  This gets merged into 'devel' as the last
> merge.
> 
> Your original set of commits were merged into 'devel-stable' and has
> had other trees merged on top of those.
> 
> You've destroyed your original commits, so this calls into question my
> entire 'devel-stable' branch.
> 
> I've still not decided what to do about this.  I'll ask Linus to merge
> most of the 'devel' stuff without 'devel-stable' merged into mainline
> to move stuff forward - this means _no_ _one's_ git work will be merged
> through my tree, at least initially.
> 
> However, I'm putting 'devel-stable' on hold; I'll let the other ARM git
> maintainers discuss this and work out what they're going to do about
> this mess.  One solution is to destroy the 'devel-stable' branch in
> its entirety, and get everyone to resend all their pull requests.
> That's *not* nice.
> 
> I also won't be pulling any more git trees until this issue is resolved -
> it would be stupid to pull more git trees on top of 'devel-stable' at
> this point.
In my eyes there are three different possibilities for the future:

 a) every tree requested for pulling has to keep constant.
 b) rmk treats the submaintainer trees as his topic branches that are
    regularly merged into devel.
 c) Linus pulls directly from submaintainers.

I think c) isn't nice (and AFAIK Linus would request a)).

I'd prefer a).  And if a submaintainer "doesn't behave" next time either
both trees are pulled making the arm tree as ugly as are the others
sometimes or the second pull request is declined if Russell notes it
early enough (maybe supported by some script work).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
