From: tony@atomide.com (Tony Lindgren)
Date: Fri, 14 Sep 2012 10:55:33 -0700
Subject: [GIT PULL 5/7] omap sparse irq and local hardware.h cleanup
 for v3.7 merge window
In-Reply-To: <E1TCLkq-0006f8-Qp@merlin.infradead.org>
References: <pull-1347590052-683636> <E1TCLkq-0006f8-Qp@merlin.infradead.org>
Message-ID: <20120914175533.GG4521@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120914 08:28]:
> The following changes since commit a1e01703bacbadd22eb4aaca0bbba59bcba7d3b3:
> 
>   Merge tags 'omap-devel-gpmc-fixed-for-v3.7' and 'cleanup-omap-tags-for-v3.7' into cleanup-sparseirq (2012-09-12 18:05:19 -0700)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-cleanup-sparseirq-for-v3.7
> 
> for you to fetch changes up to 68cb700c59fae6cd539c9dc1e9f2584f671935a0:
> 
>   ARM: OMAP1: Move SoC specific headers from plat to mach for omap1 (2012-09-12 18:06:31 -0700)
> 
> ----------------------------------------------------------------
> This branch contains changes needed to make omap2+
> work properly with sparse IRQ. It also removes
> dependencies to mach/hardware.h. These help moving
> things towards ARM single zImage support.
> 
> This branch is based on a commit in tty-next
> branch with omap-devel-gpmc-fixed-for-v3.7 and
> cleanup-omap-tags-for-v3.7 merged in to keep things
> compiling and sort out some merge conflicts.

This will need some manual merging with what's in
testing/platform-data, so please let me know if
you need help with that. But basically it's mostly:

remove #include <plat/board.h> for both mach-omap1 & mach-omap2
remove #include <mach/hardware.h> for mach-omap2
remove #include <mach/irqs.h> for mach-omap2

Regards,

Tony
