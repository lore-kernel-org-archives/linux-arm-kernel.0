From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Fri, 10 Jun 2016 14:42:30 +0530
Subject: [PATCH 0/4] dmaengine: vdma: AXI DMAS Enhancments
Message-ID: <1465549954-30220-1-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series does the following thing.
---> Add support for AXI DMA Multi-channel DMA mode.
---> Delete AXI DMA binding doc.
---> Rename the driver and update config options.

This patch series is created on top of the patch series
"dmaengine: Add Xilinx zynqmp dma engine driver support".

Kedareswara rao Appana (4):
  Documentation: DT: vdma: Update binding doc for multi-channel dma
    mode
  dmaengine: vdma: Add support for mulit-channel dma mode
  Documentation: DT: dma: Delete binding doc for AXI DMA
  dmaengine: dma: Rename driver and config

 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |   92 ++++++--
 .../devicetree/bindings/dma/xilinx/xilinx_vdma.txt |  107 ---------
 drivers/dma/Kconfig                                |   13 +-
 drivers/dma/xilinx/Makefile                        |    2 +-
 drivers/dma/xilinx/{xilinx_vdma.c => xilinx_dma.c} |  242 ++++++++++++++++++--
 include/linux/dma/xilinx_dma.h                     |   18 ++
 6 files changed, 316 insertions(+), 158 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
 rename drivers/dma/xilinx/{xilinx_vdma.c => xilinx_dma.c} (91%)
