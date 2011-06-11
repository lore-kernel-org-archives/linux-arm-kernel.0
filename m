From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sat, 11 Jun 2011 21:39:54 +0300
Subject: [PATCH v3 1/5] ep93xx: set DMA masks for the ep93xx_eth
Message-ID: <a908e30a30247a07b2352002742f291d1df0eb18.1307816881.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the driver uses the DMA API, we should pass it valid DMA masks.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Tested-by: Petr Stetiar <ynezz@true.cz>
---
 arch/arm/mach-ep93xx/core.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 8207954..1d4b65f 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -402,11 +402,15 @@ static struct resource ep93xx_eth_resource[] = {
 	}
 };
 
+static u64 ep93xx_eth_dma_mask = DMA_BIT_MASK(32);
+
 static struct platform_device ep93xx_eth_device = {
 	.name		= "ep93xx-eth",
 	.id		= -1,
 	.dev		= {
-		.platform_data	= &ep93xx_eth_data,
+		.platform_data		= &ep93xx_eth_data,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.dma_mask		= &ep93xx_eth_dma_mask,
 	},
 	.num_resources	= ARRAY_SIZE(ep93xx_eth_resource),
 	.resource	= ep93xx_eth_resource,
-- 
1.7.4.4
