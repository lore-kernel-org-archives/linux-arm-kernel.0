From: benoit.thebaudeau@advansee.com (=?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=)
Date: Wed, 4 Jul 2012 16:36:11 +0200 (CEST)
Subject: [PATCH 2 of 3] ARM: imx: enable support for mx35 rtc
Message-ID: <744510504.702918.1341412571534.JavaMail.root@advansee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX35 has an RTC compatible with the i.MX31's, so enable its support even
if it's not very useful because it's not battery backed.

Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>
---
 .../arch/arm/mach-imx/devices-imx35.h              |    4 ++++
 .../arch/arm/plat-mxc/devices/platform-mxc_rtc.c   |    5 +++++
 2 files changed, 9 insertions(+)

diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/devices-imx35.h linux-next-HEAD-f9637ba/arch/arm/mach-imx/devices-imx35.h
index e745bc8..c3e9f20 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/devices-imx35.h
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/devices-imx35.h
@@ -68,6 +68,10 @@ extern const struct imx_mxc_nand_data imx35_mxc_nand_data;
 #define imx35_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand(&imx35_mxc_nand_data, pdata)
 
+extern const struct imx_mxc_rtc_data imx35_mxc_rtc_data;
+#define imx35_add_mxc_rtc()	\
+	imx_add_mxc_rtc(&imx35_mxc_rtc_data)
+
 extern const struct imx_mxc_w1_data imx35_mxc_w1_data;
 #define imx35_add_mxc_w1()	\
 	imx_add_mxc_w1(&imx35_mxc_w1_data)
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/plat-mxc/devices/platform-mxc_rtc.c linux-next-HEAD-f9637ba/arch/arm/plat-mxc/devices/platform-mxc_rtc.c
index 16d0ec4..a5c9ad5 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/plat-mxc/devices/platform-mxc_rtc.c
+++ linux-next-HEAD-f9637ba/arch/arm/plat-mxc/devices/platform-mxc_rtc.c
@@ -20,6 +20,11 @@ const struct imx_mxc_rtc_data imx31_mxc_rtc_data __initconst =
 	imx_mxc_rtc_data_entry_single(MX31);
 #endif /* ifdef CONFIG_SOC_IMX31 */
 
+#ifdef CONFIG_SOC_IMX35
+const struct imx_mxc_rtc_data imx35_mxc_rtc_data __initconst =
+	imx_mxc_rtc_data_entry_single(MX35);
+#endif /* ifdef CONFIG_SOC_IMX35 */
+
 struct platform_device *__init imx_add_mxc_rtc(
 		const struct imx_mxc_rtc_data *data)
 {
