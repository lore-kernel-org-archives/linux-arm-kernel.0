From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue,  7 Jun 2016 18:38:35 +0100
Subject: [PATCH 2/8] dmaengine: fsl-edma: print error code in error messages.
In-Reply-To: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
References: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1465321121-22238-3-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is useful to print the error code as part of the error
message.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/dma/fsl-edma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index 7208fc9..cc06eea 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -963,14 +963,16 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 	ret = dma_async_device_register(&fsl_edma->dma_dev);
 	if (ret) {
-		dev_err(&pdev->dev, "Can't register Freescale eDMA engine.\n");
+		dev_err(&pdev->dev,
+			"Can't register Freescale eDMA engine. (%d)\n", ret);
 		fsl_disable_clocks(fsl_edma);
 		return ret;
 	}
 
 	ret = of_dma_controller_register(np, fsl_edma_xlate, fsl_edma);
 	if (ret) {
-		dev_err(&pdev->dev, "Can't register Freescale eDMA of_dma.\n");
+		dev_err(&pdev->dev,
+			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
 		dma_async_device_unregister(&fsl_edma->dma_dev);
 		fsl_disable_clocks(fsl_edma);
 		return ret;
-- 
1.9.1
