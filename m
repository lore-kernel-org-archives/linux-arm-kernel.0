From: sjhuang@iluvatar.ai (Huang Shijie)
Date: Mon,  6 Aug 2018 16:52:23 +0800
Subject: [PATCH v2 1/9] dmaengine: dw-axi-dmac: use
 dmaenginem_async_device_register to simplify the code
In-Reply-To: <20180806085231.4597-1-sjhuang@iluvatar.ai>
References: <20180806085231.4597-1-sjhuang@iluvatar.ai>
Message-ID: <20180806085231.4597-2-sjhuang@iluvatar.ai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dmaenginem_async_device_register to simplify the code:
	remove dma_async_device_unregister.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index c4eb55e3011c..b2ac1d2c5b86 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -934,7 +934,7 @@ static int dw_probe(struct platform_device *pdev)
 
 	pm_runtime_put(chip->dev);
 
-	ret = dma_async_device_register(&dw->dma);
+	ret = dmaenginem_async_device_register(&dw->dma);
 	if (ret)
 		goto err_pm_disable;
 
@@ -977,8 +977,6 @@ static int dw_remove(struct platform_device *pdev)
 		tasklet_kill(&chan->vc.task);
 	}
 
-	dma_async_device_unregister(&dw->dma);
-
 	return 0;
 }
 
-- 
2.17.1
