From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 29 Jan 2010 16:13:38 -0700
Subject: [PATCH] plat-iop/adma.c: remove unnecessary (void *) casts
Message-ID: <201001291613.38904.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The (void *) cast is not needed when setting dev.platform_data to the
address of the data. Remove the casts.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/arch/arm/plat-iop/adma.c b/arch/arm/plat-iop/adma.c
index 1ff6a37..348fd3a 100644
--- a/arch/arm/plat-iop/adma.c
+++ b/arch/arm/plat-iop/adma.c
@@ -144,7 +144,7 @@ struct platform_device iop3xx_dma_0_channel = {
 	.dev = {
 		.dma_mask = &iop3xx_adma_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(64),
-		.platform_data = (void *) &iop3xx_dma_0_data,
+		.platform_data = &iop3xx_dma_0_data,
 	},
 };
 
@@ -156,7 +156,7 @@ struct platform_device iop3xx_dma_1_channel = {
 	.dev = {
 		.dma_mask = &iop3xx_adma_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(64),
-		.platform_data = (void *) &iop3xx_dma_1_data,
+		.platform_data = &iop3xx_dma_1_data,
 	},
 };
 
@@ -168,7 +168,7 @@ struct platform_device iop3xx_aau_channel = {
 	.dev = {
 		.dma_mask = &iop3xx_adma_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(64),
-		.platform_data = (void *) &iop3xx_aau_data,
+		.platform_data = &iop3xx_aau_data,
 	},
 };
 
