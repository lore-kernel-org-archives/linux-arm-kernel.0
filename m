From: zhangfei.gao@marvell.com (Zhangfei Gao)
Date: Thu, 16 Aug 2012 10:23:24 +0800
Subject: [PATCH v4 0/2] dmaengine: add support mmp-pdma
Message-ID: <1345083806-24588-1-git-send-email-zhangfei.gao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v3-v4
Set DMA_MEM_TO_MEM as default setting for memcpy, Suggested by Russell.
"By default, any channel being asked to do memcpy
should deal with the channel configuration itself and not require it
to be set"

v2->v3 
Use "#dma-channels", instead of "dma-channels", suggested by Arnd

v1->v2
Sync with Arnd and Haojoan, change compatible name to "marvell,pdma-1.0"
Used platfroms: pxa25x, pxa27x, pxa3xx, pxa93x, pxa168, pxa910, pxa688.
Use IP name rather than platform name

Also change "marvell,mmp-adma" to "marvell,adma-1.0"

v0->v1
Update dt member and desc according to Arnd's suggestion
Use dma_slave_config.slave_id to transfer drcmr followed Vinod's suggestion

mmp-pdma is added under dmaengine framework.
The final purpose is replacing arch/arm/plat-pxa/dma.c

Test on pxa910 with pxa3xx-nand and dmatest.ko

Zhangfei Gao (2):
  dmaengine: mmp-pdma support
  dmaengine: mmp_tdma: add dt support

 Documentation/devicetree/bindings/dma/mmp-dma.txt |   75 ++
 drivers/dma/Kconfig                               |    7 +
 drivers/dma/Makefile                              |    1 +
 drivers/dma/mmp_pdma.c                            |  876 +++++++++++++++++++++
 drivers/dma/mmp_tdma.c                            |   51 +-
 include/linux/platform_data/mmp_dma.h             |   19 +
 6 files changed, 1009 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/mmp-dma.txt
 create mode 100644 drivers/dma/mmp_pdma.c
 create mode 100644 include/linux/platform_data/mmp_dma.h
