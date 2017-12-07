From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Thu, 7 Dec 2017 10:54:25 +0530
Subject: [PATCH v2 1/4] dmaengine: zynqmp_dma: Fix kernel doc-format
In-Reply-To: <1512624268-13944-1-git-send-email-appanad@xilinx.com>
References: <1512624268-13944-1-git-send-email-appanad@xilinx.com>
Message-ID: <1512624268-13944-2-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the below kernel doc warnings
drivers/dma/xilinx/zynqmp_dma.c:552: info: Scanning doc for
zynqmp_dma_device_config
drivers/dma/xilinx/zynqmp_dma.c:558: warning: No description found for
return value of 'zynqmp_dma_device_config'
drivers/dma/xilinx/zynqmp_dma.c:649: info: Scanning doc for
zynqmp_dma_free_descriptors
drivers/dma/xilinx/zynqmp_dma.c:653: warning: No description found for
parameter 'chan'
drivers/dma/xilinx/zynqmp_dma.c:653: warning: Excess function parameter
'dchan' description in 'zynqmp_dma_free_descriptors'

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v2:
--> None.

 drivers/dma/xilinx/zynqmp_dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 4fa14bf..4376e4a 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -552,6 +552,8 @@ static void zynqmp_dma_config(struct zynqmp_dma_chan *chan)
  * zynqmp_dma_device_config - Zynqmp dma device configuration
  * @dchan: DMA channel
  * @config: DMA device config
+ *
+ * Return: 0 always
  */
 static int zynqmp_dma_device_config(struct dma_chan *dchan,
 				    struct dma_slave_config *config)
@@ -647,7 +649,7 @@ static void zynqmp_dma_issue_pending(struct dma_chan *dchan)
 
 /**
  * zynqmp_dma_free_descriptors - Free channel descriptors
- * @dchan: DMA channel pointer
+ * @chan: ZynqMP DMA channel pointer
  */
 static void zynqmp_dma_free_descriptors(struct zynqmp_dma_chan *chan)
 {
-- 
2.7.4
