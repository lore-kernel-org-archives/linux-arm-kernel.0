From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 03 Jun 2013 12:50:12 -0700
Subject: [PATCHv2 3/6] sched_clock: Make ARM's sched_clock generic for
 all architectures
In-Reply-To: <20130603071235.GO11798@tarshish>
References: <1370155183-31421-1-git-send-email-sboyd@codeaurora.org>
 <1370155183-31421-4-git-send-email-sboyd@codeaurora.org>
 <20130603071235.GO11798@tarshish>
Message-ID: <51ACF374.5040606@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/13 00:12, Baruch Siach wrote:
> Hi Stephen,
>
> On Sat, Jun 01, 2013 at 11:39:40PM -0700, Stephen Boyd wrote:
>> Nothing about the sched_clock implementation in the ARM port is
>> specific to the architecture. Generalize the code so that other
>> architectures can use it by selecting GENERIC_SCHED_CLOCK.
>>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>  arch/arm/Kconfig                                      | 1 +
>>  arch/arm/common/timer-sp.c                            | 2 +-
>>  arch/arm/kernel/Makefile                              | 2 +-
>>  arch/arm/kernel/arch_timer.c                          | 2 +-
>>  arch/arm/kernel/time.c                                | 4 +---
>>  arch/arm/mach-davinci/time.c                          | 2 +-
>>  arch/arm/mach-imx/time.c                              | 2 +-
>>  arch/arm/mach-integrator/integrator_ap.c              | 2 +-
>>  arch/arm/mach-ixp4xx/common.c                         | 2 +-
>>  arch/arm/mach-mmp/time.c                              | 2 +-
>>  arch/arm/mach-msm/timer.c                             | 2 +-
>>  arch/arm/mach-omap1/time.c                            | 2 +-
>>  arch/arm/mach-omap2/timer.c                           | 2 +-
>>  arch/arm/mach-pxa/time.c                              | 2 +-
>>  arch/arm/mach-sa1100/time.c                           | 2 +-
>>  arch/arm/mach-u300/timer.c                            | 2 +-
>>  arch/arm/plat-iop/time.c                              | 2 +-
>>  arch/arm/plat-omap/counter_32k.c                      | 2 +-
>>  arch/arm/plat-orion/time.c                            | 2 +-
>>  arch/arm/plat-samsung/samsung-time.c                  | 2 +-
>>  arch/arm/plat-versatile/sched-clock.c                 | 2 +-
>>  drivers/clocksource/bcm2835_timer.c                   | 2 +-
>>  drivers/clocksource/clksrc-dbx500-prcmu.c             | 3 +--
>>  drivers/clocksource/dw_apb_timer_of.c                 | 2 +-
>>  drivers/clocksource/mxs_timer.c                       | 2 +-
>>  drivers/clocksource/nomadik-mtu.c                     | 2 +-
>>  drivers/clocksource/samsung_pwm_timer.c               | 2 +-
>>  drivers/clocksource/tegra20_timer.c                   | 2 +-
>>  drivers/clocksource/time-armada-370-xp.c              | 2 +-
>>  drivers/clocksource/timer-marco.c                     | 2 +-
>>  drivers/clocksource/timer-prima2.c                    | 2 +-
>>  {arch/arm/include/asm => include/linux}/sched_clock.h | 9 +++++++--
> Shouldn't we just merge this header into the existing linux/sched.h?

I don't know. John/Thomas, any thoughts? One benefit with it this way is
that we don't have to recompile all the timer drivers if we change
sched.h for other reasons.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
