From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 21 Jul 2010 23:59:52 +0200
Subject: [PATCH 2/5] mx25: Add flexcan devices
In-Reply-To: <1279749595-21596-1-git-send-email-mkl@pengutronix.de>
References: <1279749595-21596-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1279749595-21596-3-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/mach-mx25/devices.c |   95 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mx25/devices.h |    2 +
 2 files changed, 97 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index 3468eb1..ecff519 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -179,6 +179,101 @@ struct platform_device mxc_pwm_device3 = {
 	.resource = mxc_pwm_resources3,
 };
 
+static struct resource mxc_i2c_1_resources[] = {
+	{
+		.start	= 0x43f80000,
+		.end	= 0x43f83fff,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= 3,
+		.end	= 3,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device mxc_i2c_device0 = {
+	.name = "imx-i2c",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(mxc_i2c_1_resources),
+	.resource = mxc_i2c_1_resources,
+};
+
+static struct resource mxc_i2c_2_resources[] = {
+	{
+		.start	= 0x43f98000,
+		.end	= 0x43f9bfff,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= 4,
+		.end	= 4,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device mxc_i2c_device1 = {
+	.name = "imx-i2c",
+	.id = 1,
+	.num_resources = ARRAY_SIZE(mxc_i2c_2_resources),
+	.resource = mxc_i2c_2_resources,
+};
+
+static struct resource mxc_i2c_3_resources[] = {
+	{
+		.start	= 0x43f84000,
+		.end	= 0x43f87fff,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= 10,
+		.end	= 10,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device mxc_i2c_device2 = {
+	.name = "imx-i2c",
+	.id = 2,
+	.num_resources = ARRAY_SIZE(mxc_i2c_3_resources),
+	.resource = mxc_i2c_3_resources,
+};
+
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
index 4aceb68..66b72b1 100644
--- a/arch/arm/mach-mx25/devices.h
+++ b/arch/arm/mach-mx25/devices.h
@@ -14,3 +14,5 @@ extern struct platform_device mx25_kpp_device;
 extern struct platform_device imx_ssi_device0;
 extern struct platform_device imx_ssi_device1;
 extern struct platform_device mx25_csi_device;
+extern struct platform_device mxc_can_device0;
+extern struct platform_device mxc_can_device1;
-- 
1.7.1
