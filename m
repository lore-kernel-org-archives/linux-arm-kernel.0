From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu,  2 Jun 2011 21:59:34 +0300
Subject: [PATCH v2 1/5] ep93xx: set DMA masks for the ep93xx_eth
Message-ID: <f20d8fe52f823e7e65423720c53f2935d3e08967.1307040443.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the driver is now passing platform device to the DMA mapping functions,
we should give it valid DMA masks.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Changes to previous version are:
	- moved this patch to be first
	- added Russell's acks

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
