From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 31 Mar 2011 19:30:45 +0200
Subject: [PATCH V2 2/3] arm: lpc32xx: add rtc-device
In-Reply-To: <1301592646-26356-1-git-send-email-w.sang@pengutronix.de>
References: <1301592646-26356-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1301592646-26356-2-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/arm/mach-lpc32xx/common.c |   21 +++++++++++++++++++++
 arch/arm/mach-lpc32xx/common.h |    1 +
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
index 6880b47..205b2db 100644
--- a/arch/arm/mach-lpc32xx/common.c
+++ b/arch/arm/mach-lpc32xx/common.c
@@ -116,6 +116,27 @@ struct platform_device lpc32xx_tsc_device = {
 	.resource = lpc32xx_tsc_resources,
 };
 
+/* RTC */
+
+static struct resource lpc32xx_rtc_resources[] = {
+	{
+		.start = LPC32XX_RTC_BASE,
+		.end = LPC32XX_RTC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},{
+		.start = IRQ_LPC32XX_RTC,
+		.end = IRQ_LPC32XX_RTC,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device lpc32xx_rtc_device = {
+	.name =  "rtc-lpc32xx",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(lpc32xx_rtc_resources),
+	.resource = lpc32xx_rtc_resources,
+};
+
 /*
  * Returns the unique ID for the device
  */
diff --git a/arch/arm/mach-lpc32xx/common.h b/arch/arm/mach-lpc32xx/common.h
index e81243c..5583f52 100644
--- a/arch/arm/mach-lpc32xx/common.h
+++ b/arch/arm/mach-lpc32xx/common.h
@@ -29,6 +29,7 @@ extern struct platform_device lpc32xx_i2c0_device;
 extern struct platform_device lpc32xx_i2c1_device;
 extern struct platform_device lpc32xx_i2c2_device;
 extern struct platform_device lpc32xx_tsc_device;
+extern struct platform_device lpc32xx_rtc_device;
 
 /*
  * Other arch specific structures and functions
-- 
1.7.2.5
