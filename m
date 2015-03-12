From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 12 Mar 2015 10:06:31 +0200
Subject: [RESEND 7/7] ARM: davinci: dm646x: Add interrupt resource for McASPs
In-Reply-To: <1426147591-31764-1-git-send-email-peter.ujfalusi@ti.com>
References: <1426147591-31764-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1426147591-31764-8-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The interrupt can be used for error recovery.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/dm646x.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index d2a2619aee81..c86e0d503b68 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -622,6 +622,16 @@ static struct resource dm646x_mcasp0_resources[] = {
 		.end	= DAVINCI_DM646X_DMA_MCASP0_AREVT0,
 		.flags	= IORESOURCE_DMA,
 	},
+	{
+		.name	= "tx",
+		.start	= IRQ_DM646X_MCASP0TXINT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.name	= "rx",
+		.start	= IRQ_DM646X_MCASP0RXINT,
+		.flags	= IORESOURCE_IRQ,
+	},
 };
 
 /* DIT mode only, rx is not supported */
@@ -638,6 +648,11 @@ static struct resource dm646x_mcasp1_resources[] = {
 		.end	= DAVINCI_DM646X_DMA_MCASP1_AXEVT1,
 		.flags	= IORESOURCE_DMA,
 	},
+	{
+		.name	= "tx",
+		.start	= IRQ_DM646X_MCASP1TXINT,
+		.flags	= IORESOURCE_IRQ,
+	},
 };
 
 static struct platform_device dm646x_mcasp0_device = {
-- 
2.3.0
