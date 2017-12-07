From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Thu, 7 Dec 2017 10:51:01 +0530
Subject: [PATCH v7 0/6] dmaengine: xilinx_dma: Bug fixes
Message-ID: <1512624067-13554-1-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes below bugs in DMA and VDMA IP's
---> Added channel idle checks in the driver before submitting the buffer descriptor to h/w.
---> Fixes bug in Multi frame sotres handling in VDMA
---> Fixes issues w.r.to multi frame descriptors submit with AXI DMA S2MM(recv) Side.
---> Fixed kernel doc warnings in the driver.
---> Fixed checkpatch errors in the driver.

Kedareswara rao Appana (6):
  dmaengine: xilinx_dma: Check for channel idle state before submitting
    dma descriptor
  dmaeninge: xilinx_dma: Fix bug in multiple frame stores scenario in
    vdma
  dmaengine: xilinx_dma: Fix race condition in the driver for multiple
    descriptor scenario
  dmaengine: xilinx_dma: Fix kernel doc warnings
  dmaengine: xilinx_dma: fix style issues from checkpatch
  dmaengine: xilinx_dma: Differentiate probe based on the ip type

 drivers/dma/xilinx/xilinx_dma.c | 283 ++++++++++++++++++++++------------------
 1 file changed, 157 insertions(+), 126 deletions(-)

-- 
2.7.4
