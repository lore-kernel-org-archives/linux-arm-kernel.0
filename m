From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 18 Apr 2013 15:21:38 +0200
Subject: [PATCH RESEND v5 2/2] DMA: imx-dma: imxdma->dev used uninitialized
In-Reply-To: <1366291298-30004-1-git-send-email-mpa@pengutronix.de>
References: <1366291298-30004-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1366291298-30004-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imxdma->dev is used for dev_warn before it was set.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/dma/imx-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 8849d03..0d42d0a 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -1067,6 +1067,7 @@ static int __init imxdma_probe(struct platform_device *pdev)
 	if (!imxdma)
 		return -ENOMEM;
 
+	imxdma->dev = &pdev->dev;
 	imxdma->devtype = pdev->id_entry->driver_data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1171,7 +1172,6 @@ static int __init imxdma_probe(struct platform_device *pdev)
 			      &imxdma->dma_device.channels);
 	}
 
-	imxdma->dev = &pdev->dev;
 	imxdma->dma_device.dev = &pdev->dev;
 
 	imxdma->dma_device.device_alloc_chan_resources = imxdma_alloc_chan_resources;
-- 
1.8.1.5
