From: zhangfei.gao@marvell.com (Zhangfei Gao)
Date: Fri, 20 Jul 2012 13:46:01 +0800
Subject: [PATCH 0/3] dmaengine: add support mmp-pdma
Message-ID: <1342763164-19208-1-git-send-email-zhangfei.gao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mmp-pdma is added under dmaengine framework.
The final purpose is replacing arch/arm/plat-pxa/dma.c

Test on pxa910 with pxa3xx-nand and dmatest.ko

Zhangfei Gao (3):
  dmaengine: mmp-pdma support
  dmaengine: mmp_tdma: add dt support
  dmatest: add dmaengine_slave_config for DMA_MEMCPY

 Documentation/devicetree/bindings/dma/mmp-dma.txt |   56 ++
 drivers/dma/Kconfig                               |    7 +
 drivers/dma/Makefile                              |    1 +
 drivers/dma/dmatest.c                             |    4 +
 drivers/dma/mmp_pdma.c                            |  877 +++++++++++++++++++++
 drivers/dma/mmp_tdma.c                            |   51 +-
 include/linux/platform_data/mmp_dma.h             |   25 +
 7 files changed, 1001 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/mmp-dma.txt
 create mode 100644 drivers/dma/mmp_pdma.c
 create mode 100644 include/linux/platform_data/mmp_dma.h
