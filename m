From: sjhuang@iluvatar.ai (Huang Shijie)
Date: Mon,  6 Aug 2018 16:52:30 +0800
Subject: [PATCH v2 8/9] dmaengine: mxs-dma: use
 dmaenginem_async_device_register to simplify the code
In-Reply-To: <20180806085231.4597-1-sjhuang@iluvatar.ai>
References: <20180806085231.4597-1-sjhuang@iluvatar.ai>
Message-ID: <20180806085231.4597-9-sjhuang@iluvatar.ai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dmaenginem_async_device_register to simplify the code:
	remove dma_async_device_unregister.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/mxs-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index ae5182ff0128..35193b31a9e0 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -847,7 +847,7 @@ static int __init mxs_dma_probe(struct platform_device *pdev)
 	mxs_dma->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	mxs_dma->dma_device.device_issue_pending = mxs_dma_enable_chan;
 
-	ret = dma_async_device_register(&mxs_dma->dma_device);
+	ret = dmaenginem_async_device_register(&mxs_dma->dma_device);
 	if (ret) {
 		dev_err(mxs_dma->dma_device.dev, "unable to register\n");
 		return ret;
@@ -857,7 +857,6 @@ static int __init mxs_dma_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(mxs_dma->dma_device.dev,
 			"failed to register controller\n");
-		dma_async_device_unregister(&mxs_dma->dma_device);
 	}
 
 	dev_info(mxs_dma->dma_device.dev, "initialized\n");
-- 
2.17.1
