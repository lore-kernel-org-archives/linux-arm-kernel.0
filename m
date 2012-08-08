From: zhangfei.gao@marvell.com (Zhangfei Gao)
Date: Wed,  8 Aug 2012 11:14:57 +0800
Subject: [PATCH v2 0/4]  dmaengine: add support mmp-pdma
Message-ID: <1344395701-30888-1-git-send-email-zhangfei.gao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v1->v2
Sync with Arnd and Haojoan, change compatible name to "marvell,pdma-1.0"
Used platfroms: pxa25x, pxa27x, pxa3xx, pxa93x, pxa168, pxa910, pxa688.
Use IP name rather than platform name

v0->v1
Update dt member and desc according to Arnd's suggestion
Use dma_slave_config.slave_id to transfer drcmr followed Vinod's suggestion

Patch 4 is upload as example
mtd: pxa3xx-nand: replace pxa_request_dma with dmaengine
We would like hold this patch currently
since pdma will grab irq and disable pxa_init_dma. 


mmp-pdma is added under dmaengine framework.
The final purpose is replacing arch/arm/plat-pxa/dma.c

Test on pxa910 with pxa3xx-nand and dmatest.ko

Zhangfei Gao (4):
  dmaengine: mmp-pdma support
  dmaengine: mmp_tdma: add dt support
  dmatest: add dmaengine_slave_config for DMA_MEMCPY
  mtd: pxa3xx-nand: replace pxa_request_dma with dmaengine

 Documentation/devicetree/bindings/dma/mmp-dma.txt |   75 ++
 drivers/dma/Kconfig                               |    7 +
 drivers/dma/Makefile                              |    1 +
 drivers/dma/dmatest.c                             |    4 +
 drivers/dma/mmp_pdma.c                            |  872 +++++++++++++++++++++
 drivers/dma/mmp_tdma.c                            |   51 +-
 drivers/mtd/nand/pxa3xx_nand.c                    |  113 ++--
 include/linux/platform_data/mmp_dma.h             |   19 +
 8 files changed, 1072 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/mmp-dma.txt
 create mode 100644 drivers/dma/mmp_pdma.c
 create mode 100644 include/linux/platform_data/mmp_dma.h
