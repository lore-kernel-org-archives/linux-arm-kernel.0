From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 21 Oct 2013 07:15:25 +0900
Subject: [GIT PULL 5/6] Samsung s3c24xx-dma for v3.13
Message-ID: <526455FD.3070702@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:

   Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/s3c24xx-dma

for you to fetch changes up to 1fecf8958eb7f90791f2c7e99afac393b64fa976:

   ARM: S3C24XX: add dma pdata for s3c2410, s3c2440 and s3c2442 
(2013-10-21 05:32:48 +0900)

----------------------------------------------------------------
add dmaengine based s3c24xx dma driver

----------------------------------------------------------------
Heiko Stuebner (7):
       ARM: S3C24XX: number the dma clocks
       dmaengine: add driver for Samsung s3c24xx SoCs
       ARM: S3C24XX: add platform-devices for new dma driver for s3c2412 
and s3c2443
       ARM: SAMSUNG: set s3c24xx_dma_filter for s3c64xx-spi0 device
       ARM: S3C24XX: Fix possible dma selection warning
       dmaengine: s3c24xx-dma: add support for the s3c2410 type of 
controller
       ARM: S3C24XX: add dma pdata for s3c2410, s3c2440 and s3c2442

  arch/arm/mach-s3c24xx/Kconfig             |    3 +-
  arch/arm/mach-s3c24xx/clock-s3c2412.c     |    8 +-
  arch/arm/mach-s3c24xx/common-s3c2443.c    |   12 +-
  arch/arm/mach-s3c24xx/common.c            |  206 +++++
  arch/arm/mach-s3c24xx/common.h            |    5 +
  arch/arm/mach-s3c24xx/mach-jive.c         |    1 +
  arch/arm/mach-s3c24xx/mach-smdk2413.c     |    1 +
  arch/arm/mach-s3c24xx/mach-smdk2416.c     |    1 +
  arch/arm/mach-s3c24xx/mach-smdk2443.c     |    1 +
  arch/arm/mach-s3c24xx/mach-vstms.c        |    1 +
  arch/arm/plat-samsung/devs.c              |    5 +-
  drivers/dma/Kconfig                       |   12 +
  drivers/dma/Makefile                      |    1 +
  drivers/dma/s3c24xx-dma.c                 | 1350 
+++++++++++++++++++++++++++++
  include/linux/platform_data/dma-s3c24xx.h |   46 +
  sound/soc/samsung/Kconfig                 |    2 +-
  16 files changed, 1642 insertions(+), 13 deletions(-)
  create mode 100644 drivers/dma/s3c24xx-dma.c
  create mode 100644 include/linux/platform_data/dma-s3c24xx.h
