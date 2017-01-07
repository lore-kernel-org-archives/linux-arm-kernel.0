From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Sat, 7 Jan 2017 12:15:27 +0530
Subject: [PATCH v5 0/3] dmaengine: xilinx_dma: Bug fixes
Message-ID: <1483771530-8545-1-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes below bugs in DMA and VDMA IP's
---> Do not start VDMA until frame buffer is processed by the h/w Fix 
---> bug in Multi frame sotres handling in VDMA Fix issues w.r.to multi 
---> frame descriptors submit with AXI DMA S2MM(recv) Side.

Kedareswara rao Appana (3):
  dmaengine: xilinx_dma: Check for channel idle state before submitting
    dma descriptor
  dmaeninge: xilinx_dma: Fix bug in multiple frame stores scenario in
    vdma
  dmaengine: xilinx_dma: Fix race condition in the driver for multiple
    descriptor scenario

 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |   2 +
 drivers/dma/xilinx/xilinx_dma.c                    | 265 ++++++++++++---------
 2 files changed, 156 insertions(+), 111 deletions(-)

-- 
2.1.2
