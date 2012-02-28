From: hzhuang1@marvell.com (Haojian Zhuang)
Date: Tue, 28 Feb 2012 00:41:57 -0800
Subject: [PATCH 00/13] Enable DMA engine for mmp2 and mmp3
In-Reply-To: <1330414065-2949-1-git-send-email-zhaoy@marvell.com>
References: <Y>,<1330414065-2949-1-git-send-email-zhaoy@marvell.com>
Message-ID: <25B60CDC2F704E4E9D88FFD52780CB4C060A87D776@SC-VEXCH1.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhao,

Which code base are you using? Now it's kernel v3.3-rc5.

Thanks
Haojian
________________________________________
From: zhaoy [zhaoy at marvell.com]
Sent: Tuesday, February 28, 2012 3:27 PM
To: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; nicolas.pitre at linaro.org; linux at arm.linux.org.uk; Haojian Zhuang; Chao Xie; Leo Yan
Cc: Zhao Ye
Subject: [PATCH 00/13] Enable DMA engine for mmp2 and mmp3

These patch is for marvell mmp2 and mmp3 platform to enable
dmaengine, use dmaengine to manage the audio dma, video dma
and peripheral device dma together.

zhaoy (13):
  DMA:define second level irq definition
  dmaengine:open dmac and tdma support
  dmaengine: mmp: add two-channel dma driver
  dmaengine:mmp add peripheral dma driver
  mmp2:register dma devices for mmp2 platform
  mmp3:register dma devices for mmp3 platform
  DMA:mmp:remove redundant dma drivers
  DMAC:tty serial pxa use generic dma engine APIs
  DMA:remove unnecessary dma configurations
  dmaengine:audio:mmp audio use generic dma engine APIs
  DMA:update defconfig for mmp3
  mdma:dmaengine:update mdma for tdma
  DMA:update defconfig for mmp2

 arch/arm/configs/mmp2_defconfig           |   23 +-
 arch/arm/configs/mmp3_defconfig           |   21 +-
 arch/arm/mach-mmp/Makefile                |    4 +-
 arch/arm/mach-mmp/include/mach/irqs.h     |   18 +-
 arch/arm/mach-mmp/include/mach/mmp_dma.h  |   89 ++-
 arch/arm/mach-mmp/include/mach/regs-icu.h |   12 +-
 arch/arm/mach-mmp/irq-mmp2.c              |    4 +
 arch/arm/mach-mmp/irq-mmp3.c              |    3 +
 arch/arm/mach-mmp/mmp2.c                  |  122 ++-
 arch/arm/mach-mmp/mmp3.c                  |   78 ++-
 arch/arm/plat-pxa/include/plat/dma.h      |   33 +-
 drivers/char/mmp2_mdma.c                  |  273 ++----
 drivers/dma/Kconfig                       |   19 +
 drivers/dma/Makefile                      |    2 +
 drivers/dma/mmp_tdma.c                    |  858 +++++++++++++++
 drivers/dma/pxa_dmac.c                    | 1077 ++++++++++++++++++
 drivers/tty/serial/Kconfig                |   12 +-
 drivers/tty/serial/Makefile               |    1 +
 drivers/tty/serial/mmp_pxa.c              | 1698 +++++++++++++++++++++++++++++
 sound/soc/pxa/mmp-pcm.c                   |  232 ++--
 sound/soc/pxa/mmp-pcm.h                   |    4 +-
 sound/soc/pxa/mmp2-squ.c                  |  192 ++--
 sound/soc/pxa/mmp2-squ.h                  |    8 +-
 sound/soc/pxa/mmp2-sspa.c                 |   28 +-
 24 files changed, 4361 insertions(+), 450 deletions(-)
 create mode 100644 drivers/dma/mmp_tdma.c
 create mode 100644 drivers/dma/pxa_dmac.c
 create mode 100644 drivers/tty/serial/mmp_pxa.c
