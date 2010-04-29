From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 29 Apr 2010 10:03:22 +0200
Subject: [PATCH 6/6] arm/mx51: add watchdog device
In-Reply-To: <1272528202-24159-1-git-send-email-w.sang@pengutronix.de>
References: <1272528202-24159-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1272528202-24159-7-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx5/devices.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
index 5070ae1..a039f9e 100644
--- a/arch/arm/mach-mx5/devices.c
+++ b/arch/arm/mach-mx5/devices.c
@@ -92,6 +92,21 @@ struct platform_device mxc_fec_device = {
 	.resource = mxc_fec_resources,
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
-- 
1.7.0
