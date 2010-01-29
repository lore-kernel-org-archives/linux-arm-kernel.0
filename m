From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 29 Jan 2010 15:56:58 -0700
Subject: [PATCH] mach-orion5x/common.c: remove unnecessary (void *) casts
Message-ID: <201001291556.59176.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The (void *) cast is not needed when setting dev.platform_data to the
address of the data. Remove the casts.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Lennert Buytenhek <buytenh@marvell.com>
Cc: Nicolas Pitre <nico@marvell.com>

---

diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index f87fa12..8dc2c76 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -488,7 +488,7 @@ static struct platform_device orion5x_xor0_channel = {
 	.dev		= {
 		.dma_mask		= &orion5x_xor_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(64),
-		.platform_data		= (void *)&orion5x_xor0_data,
+		.platform_data		= &orion5x_xor0_data,
 	},
 };
 
@@ -514,7 +514,7 @@ static struct platform_device orion5x_xor1_channel = {
 	.dev		= {
 		.dma_mask		= &orion5x_xor_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(64),
-		.platform_data		= (void *)&orion5x_xor1_data,
+		.platform_data		= &orion5x_xor1_data,
 	},
 };
 
