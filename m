From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Sep 2011 21:39:33 +0900
Subject: [PATCH 0/5] S5P64X0 PM Support
In-Reply-To: <1313144787-30666-1-git-send-email-a.kesavan@samsung.com>
References: <1313144787-30666-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <005901cc785b$8401f6a0$8c05e3e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Abhilash Kesavan wrote:
> 
> The patchset adds Power Mangement support for S5P64X0. The first
> four patches lay the groundwork for adding PM support, while the
> final patch adds the SoC specific PM code.
> Tested using external interrupts as wake-up sources on SMDK6440
> and SMDK6450.
> 
> Abhilash Kesavan (5):
>   ARM: S5P: Make the common S5P PM code conditionally compile
>   ARM: SAMSUNG: Make the sleep code common for S3C64XX and newer SoCs
>   ARM: S5P64X0: Add pm save/restore functions for GPIO banks
>   ARM: S5P64X0: Fix incorrect serial clock name
>   ARM: S5P64X0: Add Power Management support
> 
>  arch/arm/Kconfig                                |    2 +-
>  arch/arm/mach-exynos4/Kconfig                   |    2 +
>  arch/arm/mach-exynos4/Makefile                  |    2 +-
>  arch/arm/mach-exynos4/sleep.S                   |   54 ------
>  arch/arm/mach-s3c64xx/Kconfig                   |    1 +
>  arch/arm/mach-s3c64xx/Makefile                  |    1 -
>  arch/arm/mach-s3c64xx/sleep.S                   |   72 --------
>  arch/arm/mach-s5p64x0/Kconfig                   |    4 +
>  arch/arm/mach-s5p64x0/Makefile                  |    1 +
>  arch/arm/mach-s5p64x0/clock-s5p6440.c           |    2 +-
>  arch/arm/mach-s5p64x0/clock-s5p6450.c           |    2 +-
>  arch/arm/mach-s5p64x0/gpiolib.c                 |    1 +
>  arch/arm/mach-s5p64x0/include/mach/map.h        |    1 +
>  arch/arm/mach-s5p64x0/include/mach/pm-core.h    |  117 +++++++++++++
>  arch/arm/mach-s5p64x0/include/mach/regs-clock.h |   33 ++++
>  arch/arm/mach-s5p64x0/include/mach/regs-gpio.h  |   19 ++
>  arch/arm/mach-s5p64x0/init.c                    |    2 +-
>  arch/arm/mach-s5p64x0/irq-eint.c                |    2 +
>  arch/arm/mach-s5p64x0/irq-pm.c                  |   92 ++++++++++
>  arch/arm/mach-s5p64x0/pm.c                      |  204
> +++++++++++++++++++++++
>  arch/arm/mach-s5pv210/Kconfig                   |    2 +
>  arch/arm/mach-s5pv210/Makefile                  |    2 +-
>  arch/arm/mach-s5pv210/sleep.S                   |   52 ------
>  arch/arm/plat-s5p/Kconfig                       |    6 +
>  arch/arm/plat-s5p/Makefile                      |    3 +-
>  arch/arm/plat-samsung/Kconfig                   |    7 +
>  arch/arm/plat-samsung/Makefile                  |    1 +
>  arch/arm/plat-samsung/sleep.S                   |   80 +++++++++
>  drivers/gpio/gpio-plat-samsung.c                |    4 +-
>  29 files changed, 583 insertions(+), 188 deletions(-)
>  delete mode 100644 arch/arm/mach-exynos4/sleep.S
>  delete mode 100644 arch/arm/mach-s3c64xx/sleep.S
>  create mode 100644 arch/arm/mach-s5p64x0/include/mach/pm-core.h
>  create mode 100644 arch/arm/mach-s5p64x0/irq-pm.c
>  create mode 100644 arch/arm/mach-s5p64x0/pm.c
>  delete mode 100644 arch/arm/mach-s5pv210/sleep.S
>  create mode 100644 arch/arm/plat-samsung/sleep.S
> 
> --
> 1.7.4.1

Hi Abhilash,

As I know, you need to rebase this series based on latest for-next.

Please re-submit this series...and I agree with Russell's suggestion on
patch 2/5.
But it's enough to use s3c64xx_smdk_leds_resume() firstly not common smdk
now.

Of course, we need to do it later ;)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
