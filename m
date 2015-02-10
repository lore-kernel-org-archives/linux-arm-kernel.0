From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 10 Feb 2015 15:58:41 +0200
Subject: [PATCH 5/7] ARM: davinci: dm646x: Clean up the McASP DMA resources
In-Reply-To: <1423576723-24375-1-git-send-email-peter.ujfalusi@ti.com>
References: <1423576723-24375-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1423576723-24375-6-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add names to the DMA resources and remove the RX DMA dummy part for McASP1.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/dm646x.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 6c3bbea7d77d..d2a2619aee81 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -610,19 +610,21 @@ static struct resource dm646x_mcasp0_resources[] = {
 		.end 	= DAVINCI_DM646X_MCASP0_REG_BASE + (SZ_1K << 1) - 1,
 		.flags 	= IORESOURCE_MEM,
 	},
-	/* first TX, then RX */
 	{
+		.name	= "tx",
 		.start	= DAVINCI_DM646X_DMA_MCASP0_AXEVT0,
 		.end	= DAVINCI_DM646X_DMA_MCASP0_AXEVT0,
 		.flags	= IORESOURCE_DMA,
 	},
 	{
+		.name	= "rx",
 		.start	= DAVINCI_DM646X_DMA_MCASP0_AREVT0,
 		.end	= DAVINCI_DM646X_DMA_MCASP0_AREVT0,
 		.flags	= IORESOURCE_DMA,
 	},
 };
 
+/* DIT mode only, rx is not supported */
 static struct resource dm646x_mcasp1_resources[] = {
 	{
 		.name	= "mpu",
@@ -630,18 +632,12 @@ static struct resource dm646x_mcasp1_resources[] = {
 		.end	= DAVINCI_DM646X_MCASP1_REG_BASE + (SZ_1K << 1) - 1,
 		.flags	= IORESOURCE_MEM,
 	},
-	/* DIT mode, only TX event */
 	{
+		.name	= "tx",
 		.start	= DAVINCI_DM646X_DMA_MCASP1_AXEVT1,
 		.end	= DAVINCI_DM646X_DMA_MCASP1_AXEVT1,
 		.flags	= IORESOURCE_DMA,
 	},
-	/* DIT mode, dummy entry */
-	{
-		.start	= -1,
-		.end	= -1,
-		.flags	= IORESOURCE_DMA,
-	},
 };
 
 static struct platform_device dm646x_mcasp0_device = {
-- 
2.3.0
