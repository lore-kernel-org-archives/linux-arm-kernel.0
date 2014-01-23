From: egtvedt@samfundet.no (Hans-Christian Egtvedt)
Date: Thu, 23 Jan 2014 08:40:01 +0100
Subject: [PATCH 2/2] clocksource: Make clocksource register functions void
In-Reply-To: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>
References: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>
Message-ID: <20140123074001.GA3080@samfundet.no>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Around Thu 23 Jan 2014 15:12:46 +0800 or thereabout, Yijing Wang wrote:
> Currently, clocksource_register() and __clocksource_register_scale()
> functions always return 0, it's pointless, make functions void.
> And remove the dead code that check the clocksource_register_hz()
> return value.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

For the avr32 related change

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  arch/arm/mach-davinci/time.c                    |    5 ++---
>  arch/arm/mach-msm/timer.c                       |    4 +---
>  arch/arm/mach-omap2/timer.c                     |    8 +++-----
>  arch/avr32/kernel/time.c                        |    4 +---
>  arch/blackfin/kernel/time-ts.c                  |    6 ++----
>  arch/microblaze/kernel/timer.c                  |    3 +--
>  arch/mips/jz4740/time.c                         |    6 +-----
>  arch/mips/loongson/common/cs5536/cs5536_mfgpt.c |    3 ++-
>  arch/openrisc/kernel/time.c                     |    3 +--
>  arch/powerpc/kernel/time.c                      |    6 +-----
>  arch/um/kernel/time.c                           |    6 +-----
>  arch/x86/platform/uv/uv_time.c                  |   14 ++++++--------
>  drivers/clocksource/acpi_pm.c                   |    3 ++-
>  drivers/clocksource/cadence_ttc_timer.c         |    6 +-----
>  drivers/clocksource/exynos_mct.c                |    4 +---
>  drivers/clocksource/i8253.c                     |    3 ++-
>  drivers/clocksource/mmio.c                      |    3 ++-
>  drivers/clocksource/samsung_pwm_timer.c         |    5 +----
>  drivers/clocksource/scx200_hrt.c                |    3 ++-
>  drivers/clocksource/tcb_clksrc.c                |    8 +-------
>  drivers/clocksource/timer-marco.c               |    2 +-
>  drivers/clocksource/timer-prima2.c              |    2 +-
>  drivers/clocksource/vt8500_timer.c              |    4 +---
>  include/linux/clocksource.h                     |    8 ++++----
>  kernel/time/clocksource.c                       |    6 ++----
>  kernel/time/jiffies.c                           |    3 ++-
>  26 files changed, 45 insertions(+), 83 deletions(-)

<snipp diffs>

-- 
HcE
