From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Thu, 7 Dec 2017 10:51:07 +0530
Subject: [PATCH v7 6/6] dmaengine: xilinx_dma: Differentiate probe based on
 the ip type
In-Reply-To: <1512624067-13554-1-git-send-email-appanad@xilinx.com>
References: <1512624067-13554-1-git-send-email-appanad@xilinx.com>
Message-ID: <1512624067-13554-7-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the probe banner info based on the ip probed.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v7:
--> New patch.

 drivers/dma/xilinx/xilinx_dma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index b09a8ef..52e2f18 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2680,7 +2680,12 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 		goto error;
 	}
 
-	dev_info(&pdev->dev, "Xilinx AXI VDMA Engine Driver Probed!!\n");
+	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA)
+		dev_info(&pdev->dev, "Xilinx AXI DMA Engine Driver Probed!!\n");
+	else if (xdev->dma_config->dmatype == XDMA_TYPE_CDMA)
+		dev_info(&pdev->dev, "Xilinx AXI CDMA Engine Driver Probed!!\n");
+	else
+		dev_info(&pdev->dev, "Xilinx AXI VDMA Engine Driver Probed!!\n");
 
 	return 0;
 
-- 
2.7.4
