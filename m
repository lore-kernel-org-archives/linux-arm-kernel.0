From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 29 Jan 2010 15:30:53 -0700
Subject: [PATCH] mach-dove/common.c: remove unnecessary (void *) casts
Message-ID: <201001291530.53460.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The (void *) cast is not needed when setting dev.platform_data to the
address of the data. Remove the casts.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 806972a..5da2cf4 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -605,7 +605,7 @@ static struct platform_device dove_xor00_channel = {
 	.dev		= {
 		.dma_mask		= &dove_xor0_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(64),
-		.platform_data		= (void *)&dove_xor00_data,
+		.platform_data		= &dove_xor00_data,
 	},
 };
 
@@ -631,7 +631,7 @@ static struct platform_device dove_xor01_channel = {
 	.dev		= {
 		.dma_mask		= &dove_xor0_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(64),
-		.platform_data		= (void *)&dove_xor01_data,
+		.platform_data		= &dove_xor01_data,
 	},
 };
 
@@ -704,7 +704,7 @@ static struct platform_device dove_xor10_channel = {
 	.dev		= {
 		.dma_mask		= &dove_xor1_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(64),
-		.platform_data		= (void *)&dove_xor10_data,
+		.platform_data		= &dove_xor10_data,
 	},
 };
 
@@ -730,7 +730,7 @@ static struct platform_device dove_xor11_channel = {
 	.dev		= {
 		.dma_mask		= &dove_xor1_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(64),
-		.platform_data		= (void *)&dove_xor11_data,
+		.platform_data		= &dove_xor11_data,
 	},
 };
 
