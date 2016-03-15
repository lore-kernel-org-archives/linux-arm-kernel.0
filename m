From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Tue, 15 Mar 2016 22:53:06 +0530
Subject: [PATCH 1/7] dmaengine: xilinx_vdma: Fix checkpatch.pl warnings
In-Reply-To: <1458062592-27981-1-git-send-email-appanad@xilinx.com>
References: <1458062592-27981-1-git-send-email-appanad@xilinx.com>
Message-ID: <1458062592-27981-2-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the below checkpatch.pl warnings.

WARNING: void function return statements are not generally useful
+	return;
+}

WARNING: void function return statements are not generally useful
+	return;
+}

WARNING: Missing a blank line after declarations
+		u32 errors = status & XILINX_VDMA_DMASR_ALL_ERR_MASK;
+		vdma_ctrl_write(chan, XILINX_VDMA_REG_DMASR,

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
 drivers/dma/xilinx/xilinx_vdma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_vdma.c b/drivers/dma/xilinx/xilinx_vdma.c
index 0ee0321..7ab6793 100644
--- a/drivers/dma/xilinx/xilinx_vdma.c
+++ b/drivers/dma/xilinx/xilinx_vdma.c
@@ -569,8 +569,6 @@ static void xilinx_vdma_halt(struct xilinx_vdma_chan *chan)
 			chan, vdma_ctrl_read(chan, XILINX_VDMA_REG_DMASR));
 		chan->err = true;
 	}
-
-	return;
 }
 
 /**
@@ -595,8 +593,6 @@ static void xilinx_vdma_start(struct xilinx_vdma_chan *chan)
 
 		chan->err = true;
 	}
-
-	return;
 }
 
 /**
@@ -829,6 +825,7 @@ static irqreturn_t xilinx_vdma_irq_handler(int irq, void *data)
 		 * make sure not to write to other error bits to 1.
 		 */
 		u32 errors = status & XILINX_VDMA_DMASR_ALL_ERR_MASK;
+
 		vdma_ctrl_write(chan, XILINX_VDMA_REG_DMASR,
 				errors & XILINX_VDMA_DMASR_ERR_RECOVER_MASK);
 
-- 
2.1.2
