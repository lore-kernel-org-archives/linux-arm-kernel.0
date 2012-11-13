From: horms@verge.net.au (Simon Horman)
Date: Tue, 13 Nov 2012 11:58:01 +0900
Subject: [GIT PULL v3] Renesas ARM-based SoC boards for v3.8 #2
In-Reply-To: <201211122111.03440.arnd@arndb.de>
References: <1352446306-19945-1-git-send-email-horms@verge.net.au>
 <201211122111.03440.arnd@arndb.de>
Message-ID: <20121113025801.GD9537@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 09:11:03PM +0000, Arnd Bergmann wrote:
> On Friday 09 November 2012, Simon Horman wrote:
> > Hi Olof, Hi Arnd,
> > 
> > please consider the following board enhancements for 3.8.
> > 
> > * This pull request is based on a merge of
> >   a) The renesas/boards branch of the arm-soc tree
> >   b) The soc branch of the renesas tree,
> >      which I have sent a separate pull requst for
> > 
> > * "sh: clkfwk: add sh_clk_fsidiv_register()" is a driver patch
> >   which is a dependency of
> >   - ARM: shmobile: sh7372: use sh_clk_fsidiv_register() for FSI-DIV clocks
> >   - ARM: shmobile: r8a7740: add FSI-DVI clocks
> >   I have spoken to the driver maintainer, Paul Mundt, and he has indicated
> >   that he thinks it is best to merge all in one go and acked the patch for
> >   inclusion in this pull-request.
> > 
> > * The following patches
> >   - ARM: shmobile: use FSI driver's audio clock on ap4evb
> >   - ARM: shmobile: use FSI driver's audio clock on mackerel
> >   - ARM: shmobile: use FSI driver's audio clock on armadillo800eva
> >   Have a compile-time dependency on the following patch which is present in
> >   the for-next branch of Mark Brown's sound tree on kernel.org
> >   - ASoC: fsi: add master clock control functions
> >     (ab6f6d85210c4d0265cf48e9958c04e08595055a)
> 
> Hi Simon,
> 
> I've pulled this into a new next/boards2 branch because of the new dependency,
> but I'm not entirely happy with the way that the dependency came in through
> your tree.
> 
> It's generally ok to have external dependencies where they can't be avoided,
> but please remember these rules:
> 
> * When you send a branch that has an external dependency, actually base your
>   branch on top of the other one, so that it can be independently verified.
>   If you have a dependency and send your patches without that one included,
>   it's clear that your code can't be tested in the version you are sending,
>   and it breaks any attempt to test just the arm-soc tree or your branch
>   rather than the entire for-next tree.
> 
> * Make sure that the branch you depend on will not get rebased before it
>   gets submitted to the mainline kernel.
> 
> * Always let the person that owns the dependency know that the changes in
>   their tree are also included elsewhere and that things go bad if those
>   changes get rebased after all, or won't make it into the merge window
>   for some reason.
> 
> I have taken Mark on Cc to let him know about the dependency now, and I've
> merged ab6f6d85210c4d0265cf48e9958c04e08595055a (which has only shmobile
> specific ASoC patches) into the next/boards2 branch before merging your
> branch. This is still not perfect because it breaks bisection, but it's
> the best I could do aside from forcing you do do another round-trip.

Thanks and sorry about that. I'll be more careful next time.
