From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 2 Dec 2015 15:59:25 +0200
Subject: [RFC v03 15/15] ARM: davinci: dm365: Remove DMA resources for SPI
In-Reply-To: <1449064765-27427-1-git-send-email-peter.ujfalusi@ti.com>
References: <1449064765-27427-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1449064765-27427-16-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver is converted to not use the DMA resource.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/dm365.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index e794bff7d589..664ee6bbef22 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -660,14 +660,6 @@ static struct resource dm365_spi0_resources[] = {
 		.start = IRQ_DM365_SPIINT0_0,
 		.flags = IORESOURCE_IRQ,
 	},
-	{
-		.start = 17,
-		.flags = IORESOURCE_DMA,
-	},
-	{
-		.start = 16,
-		.flags = IORESOURCE_DMA,
-	},
 };
 
 static struct platform_device dm365_spi0_device = {
-- 
2.6.3
