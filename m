From: michael.williamson@criticallink.com (Michael Williamson)
Date: Tue, 22 Feb 2011 08:36:57 -0500
Subject: [PATCH v3 2/9] davinci: da8xx: clean up magic numbers in
	devices-da8xx.c
In-Reply-To: <1298381824-7723-1-git-send-email-michael.williamson@criticallink.com>
References: <1298381824-7723-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <1298381824-7723-3-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extract magic numbers from DMA resource initializers to #defines.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
Acked-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/devices-da8xx.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index beda8a4..119d46e 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -44,6 +44,11 @@
 #define DA8XX_EMAC_RAM_OFFSET		0x0000
 #define DA8XX_EMAC_CTRL_RAM_SIZE	SZ_8K
 
+#define DA8XX_DMA_MMCSD0_RX	EDMA_CTLR_CHAN(0, 16)
+#define DA8XX_DMA_MMCSD0_TX	EDMA_CTLR_CHAN(0, 17)
+#define DA850_DMA_MMCSD1_RX	EDMA_CTLR_CHAN(1, 28)
+#define DA850_DMA_MMCSD1_TX	EDMA_CTLR_CHAN(1, 29)
+
 void __iomem *da8xx_syscfg0_base;
 void __iomem *da8xx_syscfg1_base;
 
@@ -573,13 +578,13 @@ static struct resource da8xx_mmcsd0_resources[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	{		/* DMA RX */
-		.start	= EDMA_CTLR_CHAN(0, 16),
-		.end	= EDMA_CTLR_CHAN(0, 16),
+		.start	= DA8XX_DMA_MMCSD0_RX,
+		.end	= DA8XX_DMA_MMCSD0_RX,
 		.flags	= IORESOURCE_DMA,
 	},
 	{		/* DMA TX */
-		.start	= EDMA_CTLR_CHAN(0, 17),
-		.end	= EDMA_CTLR_CHAN(0, 17),
+		.start	= DA8XX_DMA_MMCSD0_TX,
+		.end	= DA8XX_DMA_MMCSD0_TX,
 		.flags	= IORESOURCE_DMA,
 	},
 };
@@ -610,13 +615,13 @@ static struct resource da850_mmcsd1_resources[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	{		/* DMA RX */
-		.start	= EDMA_CTLR_CHAN(1, 28),
-		.end	= EDMA_CTLR_CHAN(1, 28),
+		.start	= DA850_DMA_MMCSD1_RX,
+		.end	= DA850_DMA_MMCSD1_RX,
 		.flags	= IORESOURCE_DMA,
 	},
 	{		/* DMA TX */
-		.start	= EDMA_CTLR_CHAN(1, 29),
-		.end	= EDMA_CTLR_CHAN(1, 29),
+		.start	= DA850_DMA_MMCSD1_TX,
+		.end	= DA850_DMA_MMCSD1_TX,
 		.flags	= IORESOURCE_DMA,
 	},
 };
-- 
1.7.0.4
