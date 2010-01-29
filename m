From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 29 Jan 2010 15:39:01 -0700
Subject: [PATCH] mach-iop13xx/setup.c: remove unnecessary (void *) casts
Message-ID: <201001291539.01965.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The (void *) cast is not needed when setting dev.platform_data to the
address of the data. Remove the casts.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/arch/arm/mach-iop13xx/setup.c b/arch/arm/mach-iop13xx/setup.c
index 5c147fb..56d047c 100644
--- a/arch/arm/mach-iop13xx/setup.c
+++ b/arch/arm/mach-iop13xx/setup.c
@@ -332,7 +332,7 @@ static struct platform_device iop13xx_adma_0_channel = {
 	.dev = {
 		.dma_mask = &iop13xx_adma_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(64),
-		.platform_data = (void *) &iop13xx_adma_0_data,
+		.platform_data = &iop13xx_adma_0_data,
 	},
 };
 
@@ -344,7 +344,7 @@ static struct platform_device iop13xx_adma_1_channel = {
 	.dev = {
 		.dma_mask = &iop13xx_adma_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(64),
-		.platform_data = (void *) &iop13xx_adma_1_data,
+		.platform_data = &iop13xx_adma_1_data,
 	},
 };
 
@@ -356,7 +356,7 @@ static struct platform_device iop13xx_adma_2_channel = {
 	.dev = {
 		.dma_mask = &iop13xx_adma_dmamask,
 		.coherent_dma_mask = DMA_BIT_MASK(64),
-		.platform_data = (void *) &iop13xx_adma_2_data,
+		.platform_data = &iop13xx_adma_2_data,
 	},
 };
 
