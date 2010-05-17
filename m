From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Mon, 17 May 2010 20:14:52 +0200
Subject: [PATCH 1/2] MX3X: Add Keypad device definition for MX3X arch
Message-ID: <1274120092.3578.34.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---
This patch is against the today mxc-master HEAD

 arch/arm/mach-mx3/devices.c |   19 +++++++++++++++++++
 arch/arm/mach-mx3/devices.h |    1 +
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index 1ffed28..57b0541 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -607,6 +607,25 @@ struct platform_device imx_rtc_device0 = {
 	.resource       = imx_rtc_resources,
 };
 
+static struct resource imx_kpp_resources[] = {
+	{
+		.start	= MX3x_KPP_BASE_ADDR,
+		.end	= MX3x_KPP_BASE_ADDR + 0xf,
+		.flags	= IORESOURCE_MEM
+	}, {
+		.start	= MX3x_INT_KPP,
+		.end	= MX3x_INT_KPP,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device imx_kpp_device = {
+	.name = "imx-keypad",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(imx_kpp_resources),
+	.resource = imx_kpp_resources,
+};
+
 static int __init mx3_devices_init(void)
 {
 	if (cpu_is_mx31()) {
diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
index b1687ad..2c3c864 100644
--- a/arch/arm/mach-mx3/devices.h
+++ b/arch/arm/mach-mx3/devices.h
@@ -28,3 +28,4 @@ extern struct platform_device imx_ssi_device1;
 extern struct platform_device imx_ssi_device1;
 extern struct platform_device imx_wdt_device0;
 extern struct platform_device imx_rtc_device0;
+extern struct platform_device imx_kpp_device;
-- 
1.6.3.3
