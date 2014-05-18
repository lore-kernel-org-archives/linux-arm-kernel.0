From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 18 May 2014 23:42:58 +0300
Subject: [PATCH 1/2] dmaengine: s3c24xx-dma: Process whole SG chain
Message-ID: <1400445779-17365-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to redundant 'break' in a loop the driver processed only the first chunk.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/dma/s3c24xx-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index 4eddedb..2167608 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -961,7 +961,6 @@ static struct dma_async_tx_descriptor *s3c24xx_dma_prep_slave_sg(
 			dsg->src_addr = slave_addr;
 			dsg->dst_addr = sg_dma_address(sg);
 		}
-		break;
 	}
 
 	return vchan_tx_prep(&s3cchan->vc, &txd->vd, flags);
-- 
1.9.2
