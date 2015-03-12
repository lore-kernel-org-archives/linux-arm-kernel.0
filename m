From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 12 Mar 2015 10:06:26 +0200
Subject: [RESEND 2/7] ARM: davinci: devices-da8xx: Add interrupt resource to
 McASP structs
In-Reply-To: <1426147591-31764-1-git-send-email-peter.ujfalusi@ti.com>
References: <1426147591-31764-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1426147591-31764-3-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On da8xx McASP TX/RX interrupt requests are combined.
The interrupt can be used for error recovery.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/devices-da8xx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index f35174317770..e15e046c5438 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -475,6 +475,11 @@ static struct resource da830_mcasp1_resources[] = {
 		.end	= DAVINCI_DA830_DMA_MCASP1_AREVT,
 		.flags	= IORESOURCE_DMA,
 	},
+	{
+		.name	= "common",
+		.start	= IRQ_DA8XX_MCASPINT,
+		.flags	= IORESOURCE_IRQ,
+	},
 };
 
 static struct platform_device da830_mcasp1_device = {
@@ -505,6 +510,11 @@ static struct resource da850_mcasp_resources[] = {
 		.end	= DAVINCI_DA8XX_DMA_MCASP0_AREVT,
 		.flags	= IORESOURCE_DMA,
 	},
+	{
+		.name	= "common",
+		.start	= IRQ_DA8XX_MCASPINT,
+		.flags	= IORESOURCE_IRQ,
+	},
 };
 
 static struct platform_device da850_mcasp_device = {
-- 
2.3.0
