From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 26 Sep 2013 11:42:51 +0200
Subject: [PATCH v2] ARM: new platform for Energy Micro's EFM32 Cortex-M3
 SoCs
In-Reply-To: <201309172245.25367.arnd@arndb.de>
References: <1379447884-14025-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <201309172245.25367.arnd@arndb.de>
Message-ID: <20130926094251.GK16106@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 10:45:25PM +0200, Arnd Bergmann wrote:
> On Tuesday 17 September 2013, Uwe Kleine-K?nig wrote:
> >  arch/arm/Kconfig                               |  16 +++-
> >  arch/arm/Kconfig.debug                         |  16 ++++
> >  arch/arm/Makefile                              |   1 +
> >  arch/arm/configs/efm32_defconfig               | 104 +++++++++++++++++++++++++
> >  arch/arm/mach-efm32/Makefile                   |   1 +
> >  arch/arm/mach-efm32/Makefile.boot              |   2 +
> >  arch/arm/mach-efm32/cmu.h                      |  15 ++++
> >  arch/arm/mach-efm32/common.c                   |  19 +++++
> >  arch/arm/mach-efm32/common.h                   |   1 +
> >  arch/arm/mach-efm32/dtmachine.c                |  31 ++++++++
> >  arch/arm/mach-efm32/include/mach/debug-macro.S |  48 ++++++++++++
> >  arch/arm/mach-efm32/include/mach/entry-macro.S |   5 ++
> >  arch/arm/mach-efm32/include/mach/io.h          |   6 ++
> >  arch/arm/mach-efm32/include/mach/irqs.h        |   6 ++
> >  arch/arm/mach-efm32/include/mach/timex.h       |   7 ++
> 
> You should be able to add NOMMU platforms in combination with CONFIG_MULTIPLATFORM
> now, which gets rid of most of these files.
I made that work now and can prepare a patch. I had to drop "depends on
!ARCH_MULTIPLATFORM" from XIP_KERNEL. That's because my machine only
works with XIP_KERNEL as it only has 4 MiB of RAM.

Also note that for !MMU you need to specify the base address and size of
your RAM (DRAM_BASE, DRAM_SIZE) and flash (FLASH_MEM_BASE, FLASH_SIZE).
So the resulting image is hardly runnable on different machines. (I
don't know off-hand why these are needed though, maybe this can be
discussed away.)

So ARCH_MULTIPLATFORM is only good as it allows to simplify a few
things, but the result isn't really multi-platform.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
