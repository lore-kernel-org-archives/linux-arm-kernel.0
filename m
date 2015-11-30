From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 30 Nov 2015 15:45:45 +0200
Subject: [RFC v02 15/15] ARM: davinci: dm365: Remove DMA resources for SPI
In-Reply-To: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1448891145-10766-16-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver is converted to not use the DMA resource.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/dm365.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 3dfcf7c9aa20..fe98e5f55634 100644
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
