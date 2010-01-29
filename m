From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 29 Jan 2010 15:43:52 -0700
Subject: [PATCH] mach-kirkwood/common.c: remove unnecessary (void *) casts
Message-ID: <201001291543.52272.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The (void *) cast is not needed when setting dev.platform_data to the
address of the data. Remove the casts.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Lennert Buytenhek <buytenh@marvell.com>
Cc: Nicolas Pitre <nico@marvell.com>

---

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 242dd07..f759ca2 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -656,7 +656,7 @@ static struct platform_device kirkwood_xor00_channel = {
 	.dev		= {
 		.dma_mask		= &kirkwood_xor_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(64),
-		.platform_data		= (void *)&kirkwood_xor00_data,
+		.platform_data		= &kirkwood_xor00_data,
 	},
 };
 
@@ -682,7 +682,7 @@ static struct platform_device kirkwood_xor01_channel = {
 	.dev		= {
 		.dma_mask		= &kirkwood_xor_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(64),
-		.platform_data		= (void *)&kirkwood_xor01_data,
+		.platform_data		= &kirkwood_xor01_data,
 	},
 };
 
@@ -755,7 +755,7 @@ static struct platform_device kirkwood_xor10_channel = {
 	.dev		= {
 		.dma_mask		= &kirkwood_xor_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(64),
-		.platform_data		= (void *)&kirkwood_xor10_data,
+		.platform_data		= &kirkwood_xor10_data,
 	},
 };
 
@@ -781,7 +781,7 @@ static struct platform_device kirkwood_xor11_channel = {
 	.dev		= {
 		.dma_mask		= &kirkwood_xor_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(64),
-		.platform_data		= (void *)&kirkwood_xor11_data,
+		.platform_data		= &kirkwood_xor11_data,
 	},
 };
 
