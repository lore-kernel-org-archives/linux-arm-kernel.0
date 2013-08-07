From: zonque@gmail.com (Daniel Mack)
Date: Wed,  7 Aug 2013 12:19:25 +0200
Subject: [PATCH 07/12] dma: mmp_pdma: print the number of channels at probe
 time
In-Reply-To: <1375870770-14263-1-git-send-email-zonque@gmail.com>
References: <1375870770-14263-1-git-send-email-zonque@gmail.com>
Message-ID: <1375870770-14263-8-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That helps check the provided runtime information.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/dma/mmp_pdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index d60217a..2d48f31 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -887,7 +887,7 @@ static int mmp_pdma_probe(struct platform_device *op)
 		}
 	}
 
-	dev_info(pdev->device.dev, "initialized\n");
+	dev_info(pdev->device.dev, "initialized %d channels\n", dma_channels);
 	return 0;
 }
 
-- 
1.8.3.1
