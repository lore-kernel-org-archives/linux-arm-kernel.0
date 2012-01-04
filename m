From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Jan 2012 09:50:10 +0000
Subject: linux-next: interesting merges in the arm-soc tree
In-Reply-To: <01bc01ccca7b$f6483fe0$e2d8bfa0$%kim@samsung.com>
References: <20120104104758.26b0ca5268d10fbf7b95903a@canb.auug.org.au>
 <01bc01ccca7b$f6483fe0$e2d8bfa0$%kim@samsung.com>
Message-ID: <201201040950.10835.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 January 2012, Kukjin Kim wrote:
> > few conflicts (but that is not excuse) and there may be dependencies in a
> > driver on the v4l-dvb tree (but maybe that means that that driver should
> > be merged via the v4l-dvb tree - it looks like the "at91/drivers" is
> > based on the v4l-dvb tree, so probably doesn't depend on anything else on
> > the arm-soc tree).
> > 
> > If nothing else, are you sure that neither of those merged trees will
> > rebase?  You have also just inherited any bugs in those two trees.
> 
> I know, Vinod knows I merged his tree for above situation so he will not
> rebase that and Arnd will send that after merging of slave-dma into mainline
> during merge window. 

Right. The same is true for the other branch (depends/v4l) in next/drivers2.
The next/drivers2 branch will get submitted when all three of its dependencies
are merged.

Stephen, we have introduced a file arch/arm/arm-soc-for-next-contents.txt
to help us track those dependencies, and maybe it can also help you
understand our merge plans when you see potential problems like this.

Right now, there are 13 next/* branches that we plan to submit to Linus
in order. All of those are merged into the for-next branch that you pull,
and the contents.txt file tells you about the dependencies between those
branches and to external branches.

My understanding about the at91 changes from Nicolas Ferre is that they
depend on both the v4l and previous arm-soc changesets, so it was decided
to merge those through arm-soc after the v4l branch.

	Arnd
