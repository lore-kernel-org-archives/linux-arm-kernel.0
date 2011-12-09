From: tony@atomide.com (Tony Lindgren)
Date: Fri, 9 Dec 2011 13:37:27 -0800
Subject: [GIT PULL] omap1 changes for v3.3 merge window
In-Reply-To: <20111209212804.GA31337@atomide.com>
References: <20111209212804.GA31337@atomide.com>
Message-ID: <20111209213727.GC31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [111209 12:56]:
> Hi And & Olof,
> 
> Please pull omap1 changes from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap omap1
> 
> These changes are necessary to always reprogram the core clock
> based on the SoC type so we can boot at the fastest supported rate.

Sorry forgot to mention that this has a dependency to the fixes that
you pulled in yesterday.
 
> Regards,
> 
> Tony
> 
> 
> The following changes since commit 6560ee07dc946e94f7cc2cd8e3b5a5f5ee7340c1:
>   Janusz Krzysztofik (1):
>         ARM: OMAP1: recalculate loops per jiffy after dpll1 reprogram
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap omap1
> 
> Janusz Krzysztofik (3):
>       ARM: OMAP1: Move dpll1 rates selection from config to runtime
>       ARM: OMAP1: Update dpll1 default rate reprogramming method
>       ARM: OMAP1: Always reprogram dpll1 rate at boot
> 
> Tony Lindgren (1):
>       ARM: OMAP1: Set the omap1623 sram size to 16K
> 
>  arch/arm/configs/omap1_defconfig              |    1 -
>  arch/arm/mach-omap1/Kconfig                   |   64 -------------------------
>  arch/arm/mach-omap1/clock.c                   |   14 ++---
>  arch/arm/mach-omap1/clock.h                   |    3 +
>  arch/arm/mach-omap1/clock_data.c              |   19 ++++----
>  arch/arm/mach-omap1/opp.h                     |    1 +
>  arch/arm/mach-omap1/opp_data.c                |   63 +++++++++++-------------
>  arch/arm/plat-omap/include/plat/clkdev_omap.h |    1 +
>  arch/arm/plat-omap/sram.c                     |    9 ++--
>  9 files changed, 55 insertions(+), 120 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
