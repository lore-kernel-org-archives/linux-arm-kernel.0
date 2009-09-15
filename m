From: jassi.brar@samsung.com (Jassi)
Date: Tue, 15 Sep 2009 19:01:19 +0900
Subject: [PATCH 2/7] S3C64xx DMA: 'size' argument of dma_pool_create
Message-ID: <1253008879-7523-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide actual minimum(struct pl080s_lli) size of block
to dma_pool_create call, instead of hardcoded 32 bytes.

Signed-Off-by: Jassi <jassi.brar@samsung.com>
---
 arch/arm/plat-s3c64xx/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/dma.c b/arch/arm/plat-s3c64xx/dma.c
index 67aa93d..b26d2a2 100644
--- a/arch/arm/plat-s3c64xx/dma.c
+++ b/arch/arm/plat-s3c64xx/dma.c
@@ -697,7 +697,7 @@ static int __init s3c64xx_dma_init(void)
 
 	printk(KERN_INFO "%s: Registering DMA channels\n", __func__);
 
-	dma_pool = dma_pool_create("DMA-LLI", NULL, 32, 16, 0);
+	dma_pool = dma_pool_create("DMA-LLI", NULL, sizeof(struct pl080s_lli), 16, 0);
 	if (!dma_pool) {
 		printk(KERN_ERR "%s: failed to create pool\n", __func__);
 		return -ENOMEM;
-- 
1.6.2.5
