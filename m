From: b51503@freescale.com (Bai Ping)
Date: Tue, 15 Dec 2015 14:07:50 +0800
Subject: [PATCH v2 2/5] ARM: dts: imx: Add basic dts support for imx6qp-sabresd
In-Reply-To: <1450159673-27314-1-git-send-email-b51503@freescale.com>
References: <1450159673-27314-1-git-send-email-b51503@freescale.com>
Message-ID: <1450159673-27314-3-git-send-email-b51503@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds dts file for imx6qp-sabresd board.

Signed-off-by: Bai Ping <b51503@freescale.com>
---
 arch/arm/boot/dts/Makefile             |  1 +
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi |  1 +
 arch/arm/boot/dts/imx6qp-sabresd.dts   | 59 ++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6qp-sabresd.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 36d8133..dfba765 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -302,6 +302,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-sabreauto.dtb \
 	imx6dl-sabrelite.dtb \
 	imx6dl-sabresd.dtb \
+	imx6qp-sabresd.dtb \
 	imx6dl-tx6dl-comtft.dtb \
 	imx6dl-tx6u-801x.dtb \
 	imx6dl-tx6u-811x.dtb \
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index a6d445c..f65f57b 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -238,6 +238,7 @@
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
+				regulator-ramp-delay = <6250>;
 			};
 
 			sw3a_reg: sw3a {
diff --git a/arch/arm/boot/dts/imx6qp-sabresd.dts b/arch/arm/boot/dts/imx6qp-sabresd.dts
new file mode 100644
index 0000000..c3ab2b6
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qp-sabresd.dts
@@ -0,0 +1,59 @@
+/*
+ * Copyright (C) 2015 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "imx6q-sabresd.dts"
+#include "imx6qp.dtsi"
+
+/ {
+	model = "Freescale i.MX6 Quad Plus SABRE Smart Device Board";
+	compatible = "fsl,imx6qp-sabresd", "fsl,imx6qp";
+};
+
+&cpu0 {
+	arm-supply = <&sw2_reg>;
+};
+
+&iomuxc {
+	imx6qdl-sabresd {
+		pinctrl_usdhc2: usdhc2grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD2_CMD__SD2_CMD		0x17059
+				MX6QDL_PAD_SD2_CLK__SD2_CLK		0x10071
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x17059
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17059
+				MX6QDL_PAD_NANDF_D4__SD2_DATA4		0x17059
+				MX6QDL_PAD_NANDF_D5__SD2_DATA5		0x17059
+				MX6QDL_PAD_NANDF_D6__SD2_DATA6		0x17059
+				MX6QDL_PAD_NANDF_D7__SD2_DATA7		0x17059
+			>;
+		};
+
+		pinctrl_usdhc3: usdhc3grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_CMD__SD3_CMD		0x17059
+				MX6QDL_PAD_SD3_CLK__SD3_CLK		0x10071
+				MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x17059
+				MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
+				MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
+				MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
+				MX6QDL_PAD_SD3_DAT4__SD3_DATA4		0x17059
+				MX6QDL_PAD_SD3_DAT5__SD3_DATA5		0x17059
+				MX6QDL_PAD_SD3_DAT6__SD3_DATA6		0x17059
+				MX6QDL_PAD_SD3_DAT7__SD3_DATA7		0x17059
+			>;
+		};
+	};
+};
+
+&pcie {
+	power-on-gpio = <&gpio3 19 0>;
+	reset-gpio = <&gpio7 12 0>;
+	status = "okay";
+};
-- 
1.9.1
