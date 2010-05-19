From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Wed, 19 May 2010 11:33:43 +0200
Subject: [PATCH 1/2 v2] MX3X: Add Keypad device definition for MX3X arch
In-Reply-To: <1274261512.3123.6.camel@realization>
References: <1274261512.3123.6.camel@realization>
Message-ID: <1274261623.3123.8.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch adds also the pin definition helpers in iomux-mx3.h

Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---

This patch is built against the today mxc-master branch

 arch/arm/mach-mx3/devices.c                |   19 +++++++++++++++++++
 arch/arm/mach-mx3/devices.h                |    1 +
 arch/arm/plat-mxc/include/mach/iomux-mx3.h |   17 +++++++++++++++++
 3 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index 81a1dba..db7acd6 100644
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
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx3.h b/arch/arm/plat-mxc/include/mach/iomux-mx3.h
index e51465d..cbaed29 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx3.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx3.h
@@ -719,6 +719,23 @@ enum iomux_pins {
 #define MX31_PIN_SRXD5__SRXD5		IOMUX_MODE(MX31_PIN_SRXD5, IOMUX_CONFIG_FUNC)
 #define MX31_PIN_SCK5__SCK5		IOMUX_MODE(MX31_PIN_SCK5, IOMUX_CONFIG_FUNC)
 #define MX31_PIN_SFS5__SFS5		IOMUX_MODE(MX31_PIN_SFS5, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_KEY_ROW0_KEY_ROW0	IOMUX_MODE(MX31_PIN_KEY_ROW0, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_KEY_ROW1_KEY_ROW1	IOMUX_MODE(MX31_PIN_KEY_ROW1, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_KEY_ROW2_KEY_ROW2	IOMUX_MODE(MX31_PIN_KEY_ROW2, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_KEY_ROW3_KEY_ROW3	IOMUX_MODE(MX31_PIN_KEY_ROW3, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_KEY_ROW4_KEY_ROW4	IOMUX_MODE(MX31_PIN_KEY_ROW4, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_KEY_ROW5_KEY_ROW5	IOMUX_MODE(MX31_PIN_KEY_ROW5, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_KEY_ROW6_KEY_ROW6	IOMUX_MODE(MX31_PIN_KEY_ROW6, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_KEY_ROW7_KEY_ROW7	IOMUX_MODE(MX31_PIN_KEY_ROW7, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_KEY_COL0_KEY_COL0	IOMUX_MODE(MX31_PIN_KEY_COL0, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_KEY_COL1_KEY_COL1	IOMUX_MODE(MX31_PIN_KEY_COL1, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_KEY_COL2_KEY_COL2	IOMUX_MODE(MX31_PIN_KEY_COL2, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_KEY_COL3_KEY_COL3	IOMUX_MODE(MX31_PIN_KEY_COL3, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_KEY_COL4_KEY_COL4	IOMUX_MODE(MX31_PIN_KEY_COL4, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_KEY_COL5_KEY_COL5	IOMUX_MODE(MX31_PIN_KEY_COL5, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_KEY_COL6_KEY_COL6	IOMUX_MODE(MX31_PIN_KEY_COL6, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_KEY_COL7_KEY_COL7	IOMUX_MODE(MX31_PIN_KEY_COL7, IOMUX_CONFIG_FUNC)
+
 
 /*
  * XXX: The SS0, SS1, SS2, SS3 lines of spi3 are multiplexed with cspi2_ss0,
-- 
1.6.3.3
