From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Thu, 7 Dec 2017 10:54:26 +0530
Subject: [PATCH v2 2/4] dmaengine: zynqmp_dma: Fix warning variable 'val' set
 but not used
In-Reply-To: <1512624268-13944-1-git-send-email-appanad@xilinx.com>
References: <1512624268-13944-1-git-send-email-appanad@xilinx.com>
Message-ID: <1512624268-13944-3-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the below warning

drivers/dma/xilinx/zynqmp_dma.c: In function 'zynqmp_dma_handle_ovfl_int':
drivers/dma/xilinx/zynqmp_dma.c:522:6: warning: variable 'val' set but not used [-Wunused-but-set-variable]

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v2:
--> None.

 drivers/dma/xilinx/zynqmp_dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 4376e4a..b9b5c0a 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -524,12 +524,10 @@ static void zynqmp_dma_start(struct zynqmp_dma_chan *chan)
  */
 static void zynqmp_dma_handle_ovfl_int(struct zynqmp_dma_chan *chan, u32 status)
 {
-	u32 val;
-
 	if (status & ZYNQMP_DMA_IRQ_DST_ACCT_ERR)
-		val = readl(chan->regs + ZYNQMP_DMA_IRQ_DST_ACCT);
+		readl(chan->regs + ZYNQMP_DMA_IRQ_DST_ACCT);
 	if (status & ZYNQMP_DMA_IRQ_SRC_ACCT_ERR)
-		val = readl(chan->regs + ZYNQMP_DMA_IRQ_SRC_ACCT);
+		readl(chan->regs + ZYNQMP_DMA_IRQ_SRC_ACCT);
 }
 
 static void zynqmp_dma_config(struct zynqmp_dma_chan *chan)
-- 
2.7.4
