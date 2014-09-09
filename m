From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 9 Sep 2014 16:17:23 +0100
Subject: [PATCH 0/3] move arm dual timer into drivers/clocksource
In-Reply-To: <1406865536-23984-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1406865536-23984-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20140909151723.GA3494@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kefeng,

Superficially this series looks as if it could be useful (enabling sp804
support for arm64), but there are several problems:

* The commit messages are terse at best.
* The cover letter provides no rationale.
* Patch 2 doesn't appear to apply to current mainline (v3.17-rc4)

I was unable to find a later posting. Do you intend to continue with
this series?

Mark.

On Fri, Aug 01, 2014 at 04:58:53AM +0100, Kefeng Wang wrote:
> Kefeng Wang (3):
>   ARM: remove unnecessary include arm_timer.h and timer-sp.h
>   clocksource: move arm dual timer into drivers/clocksource
>   clocksouce: sp804: use pr_fmt for logging
> 
>  arch/arm/Kconfig                          |   5 -
>  arch/arm/common/Makefile                  |   1 -
>  arch/arm/common/timer-sp.c                | 304 -----------------------------
>  arch/arm/include/asm/hardware/arm_timer.h |  35 ----
>  arch/arm/include/asm/hardware/timer-sp.h  |  23 ---
>  arch/arm/mach-integrator/integrator_ap.c  |   2 +-
>  arch/arm/mach-nspire/nspire.c             |   2 -
>  arch/arm/mach-realview/core.c             |   5 +-
>  arch/arm/mach-versatile/core.c            |   5 +-
>  arch/arm/mach-vexpress/ct-ca9x4.c         |   3 -
>  arch/arm/mach-vexpress/v2m.c              |   5 +-
>  drivers/clocksource/Kconfig               |   7 +
>  drivers/clocksource/Makefile              |   1 +
>  drivers/clocksource/timer-sp.c            | 307 ++++++++++++++++++++++++++++++
>  include/clocksource/arm_timer.h           |  35 ++++
>  include/clocksource/timer-sp.h            |  23 +++
>  16 files changed, 383 insertions(+), 380 deletions(-)
>  delete mode 100644 arch/arm/common/timer-sp.c
>  delete mode 100644 arch/arm/include/asm/hardware/arm_timer.h
>  delete mode 100644 arch/arm/include/asm/hardware/timer-sp.h
>  create mode 100644 drivers/clocksource/timer-sp.c
>  create mode 100644 include/clocksource/arm_timer.h
>  create mode 100644 include/clocksource/timer-sp.h
> 
> -- 
> 1.7.12.4
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
