From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Thu, 3 Mar 2016 23:02:42 +0530
Subject: [PATCH] dmaengine: xilinx_vdma: Remove unnecessary variable
 initializations
Message-ID: <1457026362-14994-1-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the unnecessary variable initializations
in the driver.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
 drivers/dma/xilinx/xilinx_vdma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_vdma.c b/drivers/dma/xilinx/xilinx_vdma.c
index bc2ca45..0ee0321 100644
--- a/drivers/dma/xilinx/xilinx_vdma.c
+++ b/drivers/dma/xilinx/xilinx_vdma.c
@@ -554,7 +554,7 @@ static bool xilinx_vdma_is_idle(struct xilinx_vdma_chan *chan)
  */
 static void xilinx_vdma_halt(struct xilinx_vdma_chan *chan)
 {
-	int err = 0;
+	int err;
 	u32 val;
 
 	vdma_ctrl_clr(chan, XILINX_VDMA_REG_DMACR, XILINX_VDMA_DMACR_RUNSTOP);
@@ -579,7 +579,7 @@ static void xilinx_vdma_halt(struct xilinx_vdma_chan *chan)
  */
 static void xilinx_vdma_start(struct xilinx_vdma_chan *chan)
 {
-	int err = 0;
+	int err;
 	u32 val;
 
 	vdma_ctrl_set(chan, XILINX_VDMA_REG_DMACR, XILINX_VDMA_DMACR_RUNSTOP);
@@ -756,7 +756,7 @@ static void xilinx_vdma_complete_descriptor(struct xilinx_vdma_chan *chan)
  */
 static int xilinx_vdma_reset(struct xilinx_vdma_chan *chan)
 {
-	int err = 0;
+	int err;
 	u32 tmp;
 
 	vdma_ctrl_set(chan, XILINX_VDMA_REG_DMACR, XILINX_VDMA_DMACR_RESET);
-- 
2.1.2
