From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 17 May 2010 12:33:43 +0200
Subject: [PATCH V2 6/6] arm/mx51: add watchdog device
In-Reply-To: <20100517094925.GT31199@pengutronix.de>
References: <20100517094925.GT31199@pengutronix.de>
Message-ID: <1274092423-16644-2-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx5/devices.c |   15 +++++++++++++++
 arch/arm/mach-mx5/devices.h |    1 +
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
index 23850e6..7130449 100644
--- a/arch/arm/mach-mx5/devices.c
+++ b/arch/arm/mach-mx5/devices.c
@@ -153,6 +153,21 @@ struct platform_device mxc_usbh1_device = {
 	},
 };
 
+static struct resource mxc_wdt_resources[] = {
+	{
+		.start = MX51_WDOG_BASE_ADDR,
+		.end = MX51_WDOG_BASE_ADDR + SZ_16K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device mxc_wdt = {
+	.name = "imx2-wdt",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(mxc_wdt_resources),
+	.resource = mxc_wdt_resources,
+};
+
 static struct mxc_gpio_port mxc_gpio_ports[] = {
 	{
 		.chip.label = "gpio-0",
diff --git a/arch/arm/mach-mx5/devices.h b/arch/arm/mach-mx5/devices.h
index 0494d6b..c879ae7 100644
--- a/arch/arm/mach-mx5/devices.h
+++ b/arch/arm/mach-mx5/devices.h
@@ -5,3 +5,4 @@ extern struct platform_device mxc_fec_device;
 extern struct platform_device mxc_usbdr_host_device;
 extern struct platform_device mxc_usbh1_device;
 extern struct platform_device mxc_usbdr_udc_device;
+extern struct platform_device mxc_wdt;
-- 
1.7.0
