From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 28 Sep 2016 13:35:29 +0300
Subject: [PATCH 3/4] ARM: davinci: dm355: Remove DMA resources for SPI
In-Reply-To: <20160928103530.15291-1-peter.ujfalusi@ti.com>
References: <20160928103530.15291-1-peter.ujfalusi@ti.com>
Message-ID: <20160928103530.15291-4-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver is converted to not use the DMA resource.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/dm355.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index d33322ddedab..bd50367f654e 100644
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
2.10.0
