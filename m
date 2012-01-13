From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Jan 2012 10:43:59 +0000
Subject: [PATCH 00/20] arch_idle() cleanup and mach/system.h removal
In-Reply-To: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
Message-ID: <20120113104358.GR1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 04:47:29AM -0500, Nicolas Pitre wrote:
> This is the logical continuation of the arch_reset() work that Russell did
> and therefore this must be applied on top of Russell's "reset" branch.
> 
> Most arch_idle() implementations are simply a call to cpu_do_idle() and
> can be eliminated in favor of a common call.  However, some platforms
> require special idle handling and the arm_pm_idle hook is made available
> for those cases.

Right, it's time for a decision.  I was going to send the remainder of
what's in my tree today.

However, that decision has been made for me with the latest conflict
debacle between my tree and Linus' tree due to Samsung stuff, the timing
of the merge window, the timing of linux-next, and the number of merges
between what I was planning to push today and Linus' tree.

Essentially:
1. on Monday a patch was submitted to fix some of the fallout in Exynos
   for the restart cleanups.  I applied this last night, and pushed it
   out.  This morning, sfr reported that he had to drop that change
   because it was already fixed.  I've had to back this change out.

2. There is not going to be another -next tree until after the weekend,
   so my new tree will not have had -next exposure.

3. The merge window is due to close Wednesday.

4. There are conflicts in these files:

	arch/arm/mach-at91/at91sam9260.c
	arch/arm/mach-at91/at91sam9261.c
	arch/arm/mach-at91/at91sam9263.c
	arch/arm/mach-at91/at91sam9rl.c
	arch/arm/mach-exynos/common.c
	arch/arm/mach-mx5/mm.c
	arch/arm/mach-omap2/pm34xx.c
	arch/arm/mach-s5pc100/common.c
	arch/arm/mach-s5pv210/common.c

5. I don't think this idle stuff was in the -next tree Linus pulled when
   he opened the merge window.  (This is the big one which says no to it.)

So, sending a pull request for the idle stuff in the last two days of
the merge window, for a change which is quite big, which conflicts,
which wasn't in -next before the merge window is just asking for trouble,
and I'm not going to do it.
