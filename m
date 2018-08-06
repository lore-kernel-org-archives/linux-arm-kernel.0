From: sjhuang@iluvatar.ai (Huang Shijie)
Date: Mon,  6 Aug 2018 16:52:29 +0800
Subject: [PATCH v2 7/9] dmaengine: pxa_dma: use
 dmaenginem_async_device_register to simplify the code
In-Reply-To: <20180806085231.4597-1-sjhuang@iluvatar.ai>
References: <20180806085231.4597-1-sjhuang@iluvatar.ai>
Message-ID: <20180806085231.4597-8-sjhuang@iluvatar.ai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dmaenginem_async_device_register to simplify the code:
	remove dma_async_device_unregister.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/pxa_dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index b31c28b67ad3..21001ea078fb 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -1285,7 +1285,6 @@ static int pxad_remove(struct platform_device *op)
 
 	pxad_cleanup_debugfs(pdev);
 	pxad_free_channels(&pdev->slave);
-	dma_async_device_unregister(&pdev->slave);
 	return 0;
 }
 
@@ -1396,7 +1395,7 @@ static int pxad_init_dmadev(struct platform_device *op,
 		init_waitqueue_head(&c->wq_state);
 	}
 
-	return dma_async_device_register(&pdev->slave);
+	return dmaenginem_async_device_register(&pdev->slave);
 }
 
 static int pxad_probe(struct platform_device *op)
-- 
2.17.1
