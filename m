From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 28 Feb 2010 16:14:49 +0000
Subject: [GIT PULL] pxa: patches for next merge window
In-Reply-To: <f17812d71002260105q54c26198jc9b61851c35ae8ef@mail.gmail.com>
References: <f17812d71002241849m6b37f601h7eef1a723b2d0335@mail.gmail.com>
	<20100225205113.GF3101@n2100.arm.linux.org.uk>
	<20100225212915.GA24043@n2100.arm.linux.org.uk>
	<f17812d71002260105q54c26198jc9b61851c35ae8ef@mail.gmail.com>
Message-ID: <20100228161449.GD16745@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2010 at 05:05:01PM +0800, Eric Miao wrote:
> Hi Russell,
> 
> This one actually has been merged into 'fix' and been there in -rc8
> already. Now we have to live with this duplicate commit, it's my fault.
> 
> > which follows:
> >
> > [ARM] pxa/raumfeld: add defconfig
> > [ARM] pxa/raumfeld: add platform support
> >
> > in your previous pull request? ?I can find these two in your latest with
> > different commit IDs, but not the pxa/ttc_dkb patch.
> >
> 
> I've sorted this out by merging your devel branch back, and rebased
> the remaining patches on top of it. Please try re-pull. A rough test
> here at my side shows a clean merge so far.

That isn't a fix - merging my devel branch just causes more problems
because it regularly gets rebuilt.

The 'devel' branch contains individual patches, and is regularly re-
generated from individual sub-branches.

The 'devel-stable' branch (internal) contains work pulled from other
people, and the 'stable' bit means that I once pulled, I don't wind
the tree back at any point.  This gets merged into 'devel' as the last
merge.

Your original set of commits were merged into 'devel-stable' and has
had other trees merged on top of those.

You've destroyed your original commits, so this calls into question my
entire 'devel-stable' branch.

I've still not decided what to do about this.  I'll ask Linus to merge
most of the 'devel' stuff without 'devel-stable' merged into mainline
to move stuff forward - this means _no_ _one's_ git work will be merged
through my tree, at least initially.

However, I'm putting 'devel-stable' on hold; I'll let the other ARM git
maintainers discuss this and work out what they're going to do about
this mess.  One solution is to destroy the 'devel-stable' branch in
its entirety, and get everyone to resend all their pull requests.
That's *not* nice.

I also won't be pulling any more git trees until this issue is resolved -
it would be stupid to pull more git trees on top of 'devel-stable' at
this point.
