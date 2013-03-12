From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Mar 2013 18:11:50 +0000
Subject: [PATCH v2 01/14] clocksource: move sp timer driver
In-Reply-To: <1363108124-17484-2-git-send-email-haojian.zhuang@linaro.org>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
 <1363108124-17484-2-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <201303121811.50968.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

The patch looks good in principle, but I have two comments:

On Tuesday 12 March 2013, Haojian Zhuang wrote:
> Move ARM SP804 timer driver from arch/arm directory into
> drivers/clocksource directory.

The patch description should always explain why we do it, not
what is being done in here. Something like "all clocksource
drivers should get moved there, and this is needed for integrating
into the clocksource_of infrastructure.
'
>  arch/arm/Kconfig                          |    5 -
>  arch/arm/common/Makefile                  |    1 -
>  arch/arm/common/timer-sp.c                |  191 -----------------------------
>  arch/arm/include/asm/hardware/arm_timer.h |   35 ------
>  arch/arm/include/asm/hardware/timer-sp.h  |   15 ---
>  arch/arm/mach-highbank/highbank.c         |    4 +-
>  arch/arm/mach-integrator/integrator_ap.c  |    2 +-
>  arch/arm/mach-integrator/integrator_cp.c  |    4 +-
>  arch/arm/mach-realview/core.c             |    4 +-
>  arch/arm/mach-versatile/core.c            |    4 +-
>  arch/arm/mach-vexpress/ct-ca9x4.c         |    5 +-
>  arch/arm/mach-vexpress/v2m.c              |    4 +-
>  drivers/clocksource/Kconfig               |    5 +
>  drivers/clocksource/Makefile              |    1 +
>  drivers/clocksource/timer-sp.c            |  191 +++++++++++++++++++++++++++++
>  include/clocksource/arm_timer.h           |   35 ++++++
>  include/clocksource/timer-sp.h            |   19 +++

Please use 'git format-patch -M' to generate the patches. I just
realized I forgot it myself in the spear series.

I have now set 'git config diff.renames true' and would recommend to
everybody to do the same.

	Arnd
