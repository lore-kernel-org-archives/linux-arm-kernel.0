From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 21 Oct 2013 07:14:59 +0900
Subject: [GIT PULL 3/6] Samsung s3c64xx-common-clk for v3.13
Message-ID: <526455E3.9030204@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

   Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/s3c64xx-common-clk

for you to fetch changes up to 66fcbe6b7c2827866100837611c9838298a28486:

   ARM: S3C64XX: Remove old clock management code (2013-09-17 06:47:36 
+0900)

----------------------------------------------------------------
use common clock for s3c64xx
- remove old clock management code
- migrate clock handling to common clock framework

----------------------------------------------------------------
Tomasz Figa (5):
       ARM: SAMSUNG: Add soc_is_s3c6400/s3c6410 macros
       ARM: S3C64XX: Use clk_prepare_enable/clk_disable_unprepare in dma.c
       usb: ohci-s3c2410.c: Use clk_prepare_enable/clk_disable_unprepare
       ARM: S3C64XX: Migrate clock handling to Common Clock Framework
       ARM: S3C64XX: Remove old clock management code

  arch/arm/Kconfig                                |    2 +-
  arch/arm/mach-s3c64xx/Makefile                  |    2 +-
  arch/arm/mach-s3c64xx/clock.c                   | 1007 
-----------------------
  arch/arm/mach-s3c64xx/common.c                  |   21 +-
  arch/arm/mach-s3c64xx/common.h                  |   12 +-
  arch/arm/mach-s3c64xx/dma.c                     |    4 +-
  arch/arm/mach-s3c64xx/include/mach/regs-clock.h |  132 +--
  arch/arm/mach-s3c64xx/mach-anw6410.c            |    2 +-
  arch/arm/mach-s3c64xx/mach-crag6410.c           |    2 +-
  arch/arm/mach-s3c64xx/mach-hmt.c                |    2 +-
  arch/arm/mach-s3c64xx/mach-mini6410.c           |    2 +-
  arch/arm/mach-s3c64xx/mach-ncp.c                |    2 +-
  arch/arm/mach-s3c64xx/mach-smartq.c             |   11 +-
  arch/arm/mach-s3c64xx/mach-smdk6400.c           |    2 +-
  arch/arm/mach-s3c64xx/mach-smdk6410.c           |    2 +-
  arch/arm/mach-s3c64xx/pm.c                      |   21 -
  arch/arm/mach-s3c64xx/s3c6400.c                 |    6 -
  arch/arm/mach-s3c64xx/s3c6410.c                 |    7 -
  arch/arm/plat-samsung/include/plat/cpu.h        |    4 +
  drivers/clk/samsung/Makefile                    |    2 -
  drivers/usb/host/ohci-s3c2410.c                 |    8 +-
  21 files changed, 47 insertions(+), 1206 deletions(-)
  delete mode 100644 arch/arm/mach-s3c64xx/clock.c
