From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sat, 11 May 2013 13:30:04 +0200
Subject: [RFC 0/4] ARM: S3C24XX: add dmaengine based dma-driver
Message-ID: <201305111330.05046.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series tries to provide a basic dmaengine driver for the s3c24xx
SoCs.

The driver currently has some limitations, in that it does not support the
earlier s3c24xx socs, that cannot use every channel, but have special
channel requirements for specific slave-targets.

Another limitation is, that it currently does not support scatter-gather
lists with more than element, due to me not understanding sg at first.
While it does not hinder the usability, as all applicable Samsung drivers
currently use only 1-element-lists, I plan to fix this in the next revision.

In any case, I would be thankful for pointers to the obvious mistakes I'll
probably have made, due to this being my first travel into dmaengine-land.


Heiko Stuebner (4):
  ARM: S3C24XX: number the dma clocks
  dma: add dmaengine driver for Samsung s3c24xx SoCs
  ARM: S3C24XX: add platform-devices for new dma driver for s3c2412 and s3c2443
  ARM: SAMSUNG: set s3c24xx_dma_filter for s3c64xx-spi0 device

 arch/arm/mach-s3c24xx/clock-s3c2412.c     |    8 +-
 arch/arm/mach-s3c24xx/common-s3c2443.c    |   12 +-
 arch/arm/mach-s3c24xx/common.c            |  103 +++
 arch/arm/mach-s3c24xx/common.h            |    3 +
 arch/arm/plat-samsung/devs.c              |    5 +-
 drivers/dma/Kconfig                       |   12 +-
 drivers/dma/Makefile                      |    1 +
 drivers/dma/s3c24xx-dma.c                 | 1129 +++++++++++++++++++++++++++++
 include/linux/platform_data/dma-s3c24xx.h |   54 ++
 9 files changed, 1315 insertions(+), 12 deletions(-)
 create mode 100644 drivers/dma/s3c24xx-dma.c
 create mode 100644 include/linux/platform_data/dma-s3c24xx.h

-- 
1.7.2.3
