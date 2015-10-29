From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Thu, 29 Oct 2015 19:16:47 -0400
Subject: [PATCH 6/6] ARM: dts: imx: Add support for Advantech/GE B850v3
In-Reply-To: <1446160607-16053-1-git-send-email-akshay.bhat@timesys.com>
References: <1446160607-16053-1-git-send-email-akshay.bhat@timesys.com>
Message-ID: <1446160607-16053-7-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Advantech/GE B850v3 board.

Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---
 arch/arm/boot/dts/Makefile         |   1 +
 arch/arm/boot/dts/imx6q-b850v3.dts | 122 +++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-b850v3.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 3588160..becb377 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -310,6 +310,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-arm2.dtb \
 	imx6q-b450v3.dtb \
 	imx6q-b650v3.dtb \
+	imx6q-b850v3.dtb \
 	imx6q-cm-fx6.dtb \
 	imx6q-cubox-i.dtb \
 	imx6q-dfi-fs700-m60.dtb \
diff --git a/arch/arm/boot/dts/imx6q-b850v3.dts b/arch/arm/boot/dts/imx6q-b850v3.dts
new file mode 100644
index 0000000..be6c0da
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-b850v3.dts
@@ -0,0 +1,122 @@
+/*
+ * Copyright 2015 Timesys Corporation.
+ * Copyright 2015 GE Healthcare.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+
+#include "imx6q-bx50v3.dtsi"
+
+/ {
+	model = "Advantech MX6Q B850V3 QSeven Board";
+	compatible = "adv,imx6q-b850v3", "adv,imx6q-ba16", "fsl,imx6q";
+
+	chosen {
+		stdout-path = &uart3;
+	};
+};
+
+&ldb {
+	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
+			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
+	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
+				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
+	fsl,dual-channel;
+	status = "okay";
+
+	lvds0: lvds-channel at 0 {
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <24>;
+		status = "okay";
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: stdp4028 {
+				clock-frequency = <137143857>;
+				hactive = <1920>;
+				vactive = <1080>;
+				hback-porch = <100>;
+				hfront-porch = <40>;
+				vback-porch = <30>;
+				vfront-porch = <3>;
+				hsync-len = <10>;
+				vsync-len = <2>;
+			};
+		};
+	};
+};
+
+&i2c2 {
+	pca9547_ddc: mux at 70 {
+		compatible = "nxp,pca9547";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mux_i2c11: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0>;
+		};
+
+		mux_i2c12: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x1>;
+		};
+
+		mux_i2c13: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2>;
+		};
+
+		mux_i2c14: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x3>;
+		};
+
+		mux_i2c15: i2c at 4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x4>;
+		};
+
+		mux_i2c16: i2c at 5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x5>;
+		};
+
+		mux_i2c17: i2c at 6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x6>;
+		};
+
+		mux_i2c18: i2c at 7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x7>;
+		};
+	};
+};
+
+&hdmi {
+	ddc-i2c-bus = <&mux_i2c11>;
+};
+
+&mux_i2c3 {
+	ads7830_2: ads7830 at 4a {
+		compatible = "ti,ads7830";
+		reg = <0x4a>;
+	};
+};
-- 
2.6.2
