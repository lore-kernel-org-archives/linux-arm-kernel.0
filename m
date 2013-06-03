From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 3 Jun 2013 11:52:51 +0300
Subject: [PATCHv2 0/6] Make ARM's sched_clock generic + 64 bit friendly
In-Reply-To: <1370155183-31421-1-git-send-email-sboyd@codeaurora.org>
References: <1370155183-31421-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130603085251.GQ11798@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Sat, Jun 01, 2013 at 11:39:37PM -0700, Stephen Boyd wrote:
> This is mostly a resend of a patch series I sent a little over a month
> ago. I've reordered the patches so that John can pick up the first three
> and get a generic sched_clock layer without having to take the 64 bit
> patches. The last three patches add 64 bit support and move the architected
> timers on ARM64 and ARM to use it.

You can have my

Build-tested-by: Baruch Siach <baruch@tkos.co.il>

for xtensa target, with the dw_apb_timer driver (no real hardware yet).

Thanks for pushing this series.

baruch

> Stephen Boyd (6):
>   ARM: sched_clock: Remove unused needs_suspend member
>   ARM: sched_clock: Return suspended count earlier
>   sched_clock: Make ARM's sched_clock generic for all architectures
>   sched_clock: Add support for >32 bit sched_clock
>   ARM: arch_timer: Move to setup_sched_clock_64()
>   arm64: Move to generic sched_clock infrastructure
> 
>  arch/arm/Kconfig                                   |   1 +
>  arch/arm/common/timer-sp.c                         |   2 +-
>  arch/arm/kernel/Makefile                           |   2 +-
>  arch/arm/kernel/arch_timer.c                       |  16 +--
>  arch/arm/kernel/time.c                             |   4 +-
>  arch/arm/mach-davinci/time.c                       |   2 +-
>  arch/arm/mach-imx/time.c                           |   2 +-
>  arch/arm/mach-integrator/integrator_ap.c           |   2 +-
>  arch/arm/mach-ixp4xx/common.c                      |   2 +-
>  arch/arm/mach-mmp/time.c                           |   2 +-
>  arch/arm/mach-msm/timer.c                          |   2 +-
>  arch/arm/mach-omap1/time.c                         |   2 +-
>  arch/arm/mach-omap2/timer.c                        |   2 +-
>  arch/arm/mach-pxa/time.c                           |   2 +-
>  arch/arm/mach-sa1100/time.c                        |   2 +-
>  arch/arm/mach-u300/timer.c                         |   2 +-
>  arch/arm/plat-iop/time.c                           |   2 +-
>  arch/arm/plat-omap/counter_32k.c                   |   2 +-
>  arch/arm/plat-orion/time.c                         |   2 +-
>  arch/arm/plat-samsung/samsung-time.c               |   2 +-
>  arch/arm/plat-versatile/sched-clock.c              |   2 +-
>  arch/arm64/Kconfig                                 |   1 +
>  arch/arm64/kernel/time.c                           |  11 +-
>  drivers/clocksource/bcm2835_timer.c                |   2 +-
>  drivers/clocksource/clksrc-dbx500-prcmu.c          |   3 +-
>  drivers/clocksource/dw_apb_timer_of.c              |   2 +-
>  drivers/clocksource/mxs_timer.c                    |   2 +-
>  drivers/clocksource/nomadik-mtu.c                  |   2 +-
>  drivers/clocksource/samsung_pwm_timer.c            |   2 +-
>  drivers/clocksource/tegra20_timer.c                |   2 +-
>  drivers/clocksource/time-armada-370-xp.c           |   2 +-
>  drivers/clocksource/timer-marco.c                  |   2 +-
>  drivers/clocksource/timer-prima2.c                 |   2 +-
>  .../include/asm => include/linux}/sched_clock.h    |  14 ++-
>  init/Kconfig                                       |   3 +
>  init/main.c                                        |   2 +
>  kernel/time/Makefile                               |   1 +
>  {arch/arm/kernel => kernel/time}/sched_clock.c     | 114 +++++++++++++++------
>  38 files changed, 132 insertions(+), 92 deletions(-)
>  rename {arch/arm/include/asm => include/linux}/sched_clock.h (62%)
>  rename {arch/arm/kernel => kernel/time}/sched_clock.c (74%)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
