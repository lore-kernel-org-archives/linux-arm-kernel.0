From: zonque@gmail.com (Daniel Mack)
Date: Sat, 10 Aug 2013 18:52:21 +0200
Subject: [PATCH v2 07/11] dma: mmp_pdma: remove duplicate assignment
In-Reply-To: <1376153545-14361-1-git-send-email-zonque@gmail.com>
References: <1376153545-14361-1-git-send-email-zonque@gmail.com>
Message-ID: <1376153545-14361-8-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DMA_SLAVE is currently set twice.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/dma/mmp_pdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 493f59c..d7ccc90 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -882,7 +882,6 @@ static int mmp_pdma_probe(struct platform_device *op)
 
 	dma_cap_set(DMA_SLAVE, pdev->device.cap_mask);
 	dma_cap_set(DMA_MEMCPY, pdev->device.cap_mask);
-	dma_cap_set(DMA_SLAVE, pdev->device.cap_mask);
 	pdev->device.dev = &op->dev;
 	pdev->device.device_alloc_chan_resources = mmp_pdma_alloc_chan_resources;
 	pdev->device.device_free_chan_resources = mmp_pdma_free_chan_resources;
-- 
1.8.3.1
