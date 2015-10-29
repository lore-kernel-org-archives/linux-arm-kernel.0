From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Thu, 29 Oct 2015 19:16:45 -0400
Subject: [PATCH 4/6] ARM: dts: imx: Add support for Advantech/GE B450v3
In-Reply-To: <1446160607-16053-1-git-send-email-akshay.bhat@timesys.com>
References: <1446160607-16053-1-git-send-email-akshay.bhat@timesys.com>
Message-ID: <1446160607-16053-5-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Advantech/GE B450v3 board.

Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---
 arch/arm/boot/dts/Makefile         |  1 +
 arch/arm/boot/dts/imx6q-b450v3.dts | 75 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-b450v3.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7d3e495..267b2be 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -308,6 +308,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-wandboard-revb1.dtb \
 	imx6q-apf6dev.dtb \
 	imx6q-arm2.dtb \
+	imx6q-b450v3.dtb \
 	imx6q-cm-fx6.dtb \
 	imx6q-cubox-i.dtb \
 	imx6q-dfi-fs700-m60.dtb \
diff --git a/arch/arm/boot/dts/imx6q-b450v3.dts b/arch/arm/boot/dts/imx6q-b450v3.dts
new file mode 100644
index 0000000..d63d9e1
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-b450v3.dts
@@ -0,0 +1,75 @@
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
+	model = "Advantech MX6Q B450V3 QSeven Board";
+	compatible = "adv,imx6q-b450v3", "adv,imx6q-ba16", "fsl,imx6q";
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
+	status = "okay";
+
+	lvds0: lvds-channel at 0 {
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <24>;
+		status = "okay";
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: G121X1-L03 {
+				clock-frequency = <65000000>;
+				hactive = <1024>;
+				vactive = <768>;
+				hback-porch = <320>;
+				hfront-porch = <0>;
+				vback-porch = <0>;
+				vfront-porch = <38>;
+				hsync-len = <1>;
+				vsync-len = <1>;
+			};
+		};
+	};
+
+	lvds1: lvds-channel at 1 {
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <24>;
+		status = "okay";
+
+		display-timings {
+			native-mode = <&timing1>;
+			timing1: G121X1-L03 {
+				clock-frequency = <65000000>;
+				hactive = <1024>;
+				vactive = <768>;
+				hback-porch = <320>;
+				hfront-porch = <0>;
+				vback-porch = <0>;
+				vfront-porch = <38>;
+				hsync-len = <1>;
+				vsync-len = <1>;
+			};
+		};
+	};
+
+};
-- 
2.6.2
