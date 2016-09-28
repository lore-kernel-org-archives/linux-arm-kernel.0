From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 28 Sep 2016 13:35:27 +0300
Subject: [PATCH 1/4] ARM: davinci: devices-da8xx: Remove DMA resources for MMC
 and SPI
In-Reply-To: <20160928103530.15291-1-peter.ujfalusi@ti.com>
References: <20160928103530.15291-1-peter.ujfalusi@ti.com>
Message-ID: <20160928103530.15291-2-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The drivers are now converted to not use the DMA resource.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/devices-da8xx.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index add3771d38f6..dbdfe02b4174 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -57,15 +57,6 @@
 #define DA8XX_EMAC_RAM_OFFSET		0x0000
 #define DA8XX_EMAC_CTRL_RAM_SIZE	SZ_8K
 
-#define DA8XX_DMA_SPI0_RX	EDMA_CTLR_CHAN(0, 14)
-#define DA8XX_DMA_SPI0_TX	EDMA_CTLR_CHAN(0, 15)
-#define DA8XX_DMA_MMCSD0_RX	EDMA_CTLR_CHAN(0, 16)
-#define DA8XX_DMA_MMCSD0_TX	EDMA_CTLR_CHAN(0, 17)
-#define DA8XX_DMA_SPI1_RX	EDMA_CTLR_CHAN(0, 18)
-#define DA8XX_DMA_SPI1_TX	EDMA_CTLR_CHAN(0, 19)
-#define DA850_DMA_MMCSD1_RX	EDMA_CTLR_CHAN(1, 28)
-#define DA850_DMA_MMCSD1_TX	EDMA_CTLR_CHAN(1, 29)
-
 void __iomem *da8xx_syscfg0_base;
 void __iomem *da8xx_syscfg1_base;
 
@@ -964,16 +955,6 @@ static struct resource da8xx_spi0_resources[] = {
 		.end	= IRQ_DA8XX_SPINT0,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		.start	= DA8XX_DMA_SPI0_RX,
-		.end	= DA8XX_DMA_SPI0_RX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= DA8XX_DMA_SPI0_TX,
-		.end	= DA8XX_DMA_SPI0_TX,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 static struct resource da8xx_spi1_resources[] = {
@@ -987,16 +968,6 @@ static struct resource da8xx_spi1_resources[] = {
 		.end	= IRQ_DA8XX_SPINT1,
 		.flags	= IORESOURCE_IRQ,
 	},
-	[2] = {
-		.start	= DA8XX_DMA_SPI1_RX,
-		.end	= DA8XX_DMA_SPI1_RX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= DA8XX_DMA_SPI1_TX,
-		.end	= DA8XX_DMA_SPI1_TX,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 static struct davinci_spi_platform_data da8xx_spi_pdata[] = {
-- 
2.10.0
