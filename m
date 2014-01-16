From: sthokal@xilinx.com (Srikanth Thokala)
Date: Thu, 16 Jan 2014 23:23:22 +0530
Subject: [PATCH] Add Xilinx AXI Video DMA Engine driver
Message-ID: <1389894803-4147-1-git-send-email-sthokal@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the driver for Xilinx AXI Video Direct Memory Access Engine.
It is a soft IP core, which provides high-bandwidth direct memory
access between memory and AXI4-Stream video type target peripherals 
including peripherals which support AXI4-Stream Video Protocol. The
core provides efficient two dimensional DMA operations with independent
asynchronous read and write channel operation.

For more information on the IP, please refer to
http://www.xilinx.com/support/documentation/ip_documentation/axi_vdma/v6_1/pg020_axi_vdma.pdf

This patch also provides a test client, which assumes read and write channels
of the core are configured in a back-to-back connection.  It transfers 
data on the write channel, read and verify the data on the read channel. 

Use cases:
++++++++++
1. Xilinx Video Targeted Reference design
   http://www.wiki.xilinx.com/Zynq+Base+TRD+14.5
2. Common Display Framework
   http://events.linuxfoundation.org/sites/events/files/slides/20131024-elce.pdf

Regards,
Srikanth

Srikanth Thokala (1):
  dma: Add Xilinx AXI Video Direct Memory Access Engine driver support

 .../devicetree/bindings/dma/xilinx/xilinx_vdma.txt |   71 +
 .../bindings/dma/xilinx/xilinx_vdma_test.txt       |   39 +
 drivers/dma/Kconfig                                |   23 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/xilinx/Makefile                        |    2 +
 drivers/dma/xilinx/xilinx_vdma.c                   | 1497 ++++++++++++++++++++
 drivers/dma/xilinx/xilinx_vdma_test.c              |  629 ++++++++
 7 files changed, 2262 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma_test.txt
 create mode 100644 drivers/dma/xilinx/Makefile
 create mode 100644 drivers/dma/xilinx/xilinx_vdma.c
 create mode 100644 drivers/dma/xilinx/xilinx_vdma_test.c

-- 
1.7.9.5
