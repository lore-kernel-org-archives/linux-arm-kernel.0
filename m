From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Wed, 23 Dec 2015 17:00:15 -0500
Subject: [PATCH v6 6/7] ARM: dts: imx: Add support for Advantech/GE B650v3
In-Reply-To: <1450908016-17384-1-git-send-email-akshay.bhat@timesys.com>
References: <1450908016-17384-1-git-send-email-akshay.bhat@timesys.com>
Message-ID: <1450908016-17384-7-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Advantech/GE B650v3 board.

Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---
 arch/arm/boot/dts/Makefile         |   1 +
 arch/arm/boot/dts/imx6q-b650v3.dts | 114 +++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-b650v3.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0e029fc..684a504 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -318,6 +318,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-apf6dev.dtb \
 	imx6q-arm2.dtb \
 	imx6q-b450v3.dtb \
+	imx6q-b650v3.dtb \
 	imx6q-cm-fx6.dtb \
 	imx6q-cubox-i.dtb \
 	imx6q-dfi-fs700-m60.dtb \
diff --git a/arch/arm/boot/dts/imx6q-b650v3.dts b/arch/arm/boot/dts/imx6q-b650v3.dts
new file mode 100644
index 0000000..0e6b775
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-b650v3.dts
@@ -0,0 +1,114 @@
+/*
+ * Copyright 2015 Timesys Corporation.
+ * Copyright 2015 General Electric Company
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License
+ *     version 2 as published by the Free Software Foundation.
+ *
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+
+#include "imx6q-bx50v3.dtsi"
+
+/ {
+	model = "General Electric B650v3";
+	compatible = "ge,imx6q-b650v3", "advantech,imx6q-ba16", "fsl,imx6q";
+
+	chosen {
+		stdout-path = &uart3;
+	};
+
+	panel_lvds0 {
+		compatible = "innolux,g121x1-l03";
+		backlight = <&backlight_lvds>;
+		power-supply = <&reg_lvds>;
+
+		port {
+			panel_in_lvds0: endpoint {
+				remote-endpoint = <&lvds0_out>;
+			};
+		};
+	};
+
+	panel_lvds1 {
+		compatible = "innolux,g121x1-l03";
+		backlight = <&backlight_lvds>;
+		power-supply = <&reg_lvds>;
+
+		port {
+			panel_in_lvds1: endpoint {
+				remote-endpoint = <&lvds1_out>;
+			};
+		};
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
+		port at 4 {
+			reg = <4>;
+
+			lvds0_out: endpoint {
+				remote-endpoint = <&panel_in_lvds0>;
+			};
+		};
+	};
+
+	lvds1: lvds-channel at 1 {
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <24>;
+		status = "okay";
+
+		port at 4 {
+			reg = <4>;
+
+			lvds1_out: endpoint {
+				remote-endpoint = <&panel_in_lvds1>;
+			};
+		};
+	};
+};
-- 
2.6.3
