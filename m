From: tjakobi@math.uni-bielefeld.de (Tobias Jakobi)
Date: Mon, 03 Aug 2015 22:55:00 +0200
Subject: [PATCH v3 0/5] cpufreq: use generic cpufreq drivers for
 Exynos4x12 platform
In-Reply-To: <1438368557-2352-1-git-send-email-b.zolnierkie@samsung.com>
References: <1438368557-2352-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <55BFD524.6080102@math.uni-bielefeld.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patch series removes the use of Exynos4x12 specific support
> from cpufreq-exynos driver and enables the use of cpufreq-dt driver
> for this platform.
> 
> This patch series has been tested on Exynos4412 based Odroid-U3 and
> Trats2 boards.
I've tested this series on my Odroid-X2 (also Exynos4412) with
powersave, performance and ondemand governor. Scaling works like
expected, so no issues to report!

Tested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>


With best wishes,
Tobias


> 
> Depends on:
> - next-20150730 branch of linux-next kernel tree
> - "[PATCH V3 00/16] OPP: Add code to support operating-points-v2 bindings"
>   (http://www.spinics.net/lists/arm-kernel/msg435408.html)
> 
> Changes since v2
> (http://thread.gmane.org/gmane.linux.kernel.samsung-soc/46653):
> - rebased on top of next-20150730 branch of linux-next kernel tree
> - ported over V3 of opp-v2 bindings support patch series
> - put cpu0 nodes in alphabetical order in dts files
> - added Reviewed-by tags from Javier and Krzysztof
> - added Acked-by tag from Sylwester
> 
> Changes since v1
> (http://thread.gmane.org/gmane.linux.kernel.samsung-soc/44361):
> - rebased on top of next-20150629 branch of linux-next kernel tree
> - rebased on top of Exynos5250 cpufreq-dt support patch series
> - fixed if-statement in exynos4_clk_init() (noticed by Tobias Jakobi)
> - ported over opp-v2 bindings (requested by Viresh Kumar)
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> 
> Bartlomiej Zolnierkiewicz (5):
>   clk: samsung: exynos4x12: add cpu clock configuration data and
>     instantiate cpu clock
>   ARM: dts: Exynos4x12: add CPU OPP and regulator supply property
>   ARM: Exynos: switch to using generic cpufreq driver for Exynos4x12
>   cpufreq: exynos: remove Exynos4x12 specific cpufreq driver support
>   cpufreq: remove no longer needed CPU_FREQ_BOOST_SW config option
> 
>  arch/arm/boot/dts/exynos4212.dtsi               |  81 ++++++++
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi |   4 +
>  arch/arm/boot/dts/exynos4412-origen.dts         |   4 +
>  arch/arm/boot/dts/exynos4412-trats2.dts         |   4 +
>  arch/arm/boot/dts/exynos4412.dtsi               |  83 +++++++++
>  arch/arm/mach-exynos/exynos.c                   |   2 +
>  drivers/clk/samsung/clk-exynos4.c               |  50 +++++
>  drivers/cpufreq/Kconfig                         |   5 +-
>  drivers/cpufreq/Kconfig.arm                     |  38 ----
>  drivers/cpufreq/Makefile                        |   2 -
>  drivers/cpufreq/exynos-cpufreq.c                | 236 ------------------------
>  drivers/cpufreq/exynos-cpufreq.h                |  72 --------
>  drivers/cpufreq/exynos4x12-cpufreq.c            | 236 ------------------------
>  drivers/cpufreq/freq_table.c                    |   2 -
>  14 files changed, 229 insertions(+), 590 deletions(-)
>  delete mode 100644 drivers/cpufreq/exynos-cpufreq.c
>  delete mode 100644 drivers/cpufreq/exynos-cpufreq.h
>  delete mode 100644 drivers/cpufreq/exynos4x12-cpufreq.c
> 
