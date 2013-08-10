From: zonque@gmail.com (Daniel Mack)
Date: Sat, 10 Aug 2013 18:52:20 +0200
Subject: [PATCH v2 06/11] dma: mmp_pdma: print the number of channels at probe
 time
In-Reply-To: <1376153545-14361-1-git-send-email-zonque@gmail.com>
References: <1376153545-14361-1-git-send-email-zonque@gmail.com>
Message-ID: <1376153545-14361-7-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That helps check the provided runtime information.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/dma/mmp_pdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 0ec5c21..493f59c 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -914,7 +914,7 @@ static int mmp_pdma_probe(struct platform_device *op)
 		}
 	}
 
-	dev_info(pdev->device.dev, "initialized\n");
+	dev_info(pdev->device.dev, "initialized %d channels\n", dma_channels);
 	return 0;
 }
 
-- 
1.8.3.1
