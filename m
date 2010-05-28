From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 28 May 2010 13:42:16 +0200
Subject: [PATCH 2/4] mx25: Add flexcan devices
In-Reply-To: <1275046938-8465-1-git-send-email-mkl@pengutronix.de>
References: <1275046938-8465-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1275046938-8465-3-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/mach-mx25/devices.c |   38 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mx25/devices.h |    2 ++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index 3a405fa..e8b320b 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -390,6 +390,44 @@ struct platform_device mxc_i2c_device2 = {
 	.resource = mxc_i2c_3_resources,
 };
 
+static struct resource mxc_can_1_resources[] = {
+	{
+		.start	= 0x43f88000,
+		.end	= 0x43f8bfff,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= 43,
+		.end	= 43,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device mxc_can_device0 = {
+	.name = "flexcan",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(mxc_can_1_resources),
+	.resource = mxc_can_1_resources,
+};
+
+static struct resource mxc_can_2_resources[] = {
+	{
+		.start	= 0x43f8c000,
+		.end	= 0x43f8ffff,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= 44,
+		.end	= 44,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device mxc_can_device1 = {
+	.name = "flexcan",
+	.id = 1,
+	.num_resources = ARRAY_SIZE(mxc_can_2_resources),
+	.resource = mxc_can_2_resources,
+};
+
 static struct mxc_gpio_port imx_gpio_ports[] = {
 	{
 		.chip.label = "gpio-0",
diff --git a/arch/arm/mach-mx25/devices.h b/arch/arm/mach-mx25/devices.h
index cee12c0..e3267d6 100644
--- a/arch/arm/mach-mx25/devices.h
+++ b/arch/arm/mach-mx25/devices.h
@@ -22,3 +22,5 @@ extern struct platform_device mxc_nand_device;
 extern struct platform_device mx25_rtc_device;
 extern struct platform_device mx25_fb_device;
 extern struct platform_device mxc_wdt;
+extern struct platform_device mxc_can_device0;
+extern struct platform_device mxc_can_device1;
-- 
1.7.1
