From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 2 Dec 2015 15:59:24 +0200
Subject: [RFC v03 14/15] ARM: davinci: dm355: Remove DMA resources for SPI
In-Reply-To: <1449064765-27427-1-git-send-email-peter.ujfalusi@ti.com>
References: <1449064765-27427-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1449064765-27427-15-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver is converted to not use the DMA resource.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/dm355.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index ee7656fa0c52..bed8f49eb60c 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -397,14 +397,6 @@ static struct resource dm355_spi0_resources[] = {
 		.start = IRQ_DM355_SPINT0_0,
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
 
 static struct davinci_spi_platform_data dm355_spi0_pdata = {
-- 
2.6.3
