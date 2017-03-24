From: jagan@openedev.com (Jagan Teki)
Date: Fri, 24 Mar 2017 21:48:38 +0530
Subject: [PATCH v2 03/15] ARM: dts: imx6ul-isiot: Add imx6ul-isiot-common.dtsi
In-Reply-To: <1490372330-5611-1-git-send-email-jagan@openedev.com>
References: <1490372330-5611-1-git-send-email-jagan@openedev.com>
Message-ID: <1490372330-5611-4-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

lcdif nodes are differ wrt specific LCD connected on Is.IoT MX6UL
module, so create separate file 'imx6ul-isiot-common.dtsi' for common
lcdif node structure and include the same on respective dts.

More common nodes will add in future patches.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- none

 arch/arm/boot/dts/imx6ul-isiot-common.dtsi | 107 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6ul-isiot-emmc.dts    |   1 +
 arch/arm/boot/dts/imx6ul-isiot-nand.dts    |   1 +
 3 files changed, 109 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-isiot-common.dtsi

diff --git a/arch/arm/boot/dts/imx6ul-isiot-common.dtsi b/arch/arm/boot/dts/imx6ul-isiot-common.dtsi
new file mode 100644
index 0000000..9660e20
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-isiot-common.dtsi
@@ -0,0 +1,107 @@
+/*
+ * Copyright (C) 2016 Amarula Solutions B.V.
+ * Copyright (C) 2016 Engicam S.r.l.
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
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdif_dat
+		     &pinctrl_lcdif_ctrl>;
+	display = <&display0>;
+	status = "okay";
+
+	display0: display {
+		bits-per-pixel = <16>;
+		bus-width = <18>;
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: timing0 {
+				clock-frequency = <28000000>;
+				hactive = <800>;
+				vactive = <480>;
+				hfront-porch = <30>;
+				hback-porch = <30>;
+				hsync-len = <64>;
+				vback-porch = <5>;
+				vfront-porch = <5>;
+				vsync-len = <20>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl_lcdif_ctrl: lcdifctrlgrp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_CLK__LCDIF_CLK	    0x79
+			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE  0x79
+			MX6UL_PAD_LCD_HSYNC__LCDIF_HSYNC    0x79
+			MX6UL_PAD_LCD_VSYNC__LCDIF_VSYNC    0x79
+		>;
+	};
+
+	pinctrl_lcdif_dat: lcdifdatgrp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA00__LCDIF_DATA00  0x79
+			MX6UL_PAD_LCD_DATA01__LCDIF_DATA01  0x79
+			MX6UL_PAD_LCD_DATA02__LCDIF_DATA02  0x79
+			MX6UL_PAD_LCD_DATA03__LCDIF_DATA03  0x79
+			MX6UL_PAD_LCD_DATA04__LCDIF_DATA04  0x79
+			MX6UL_PAD_LCD_DATA05__LCDIF_DATA05  0x79
+			MX6UL_PAD_LCD_DATA06__LCDIF_DATA06  0x79
+			MX6UL_PAD_LCD_DATA07__LCDIF_DATA07  0x79
+			MX6UL_PAD_LCD_DATA08__LCDIF_DATA08  0x79
+			MX6UL_PAD_LCD_DATA09__LCDIF_DATA09  0x79
+			MX6UL_PAD_LCD_DATA10__LCDIF_DATA10  0x79
+			MX6UL_PAD_LCD_DATA11__LCDIF_DATA11  0x79
+			MX6UL_PAD_LCD_DATA12__LCDIF_DATA12  0x79
+			MX6UL_PAD_LCD_DATA13__LCDIF_DATA13  0x79
+			MX6UL_PAD_LCD_DATA14__LCDIF_DATA14  0x79
+			MX6UL_PAD_LCD_DATA15__LCDIF_DATA15  0x79
+			MX6UL_PAD_LCD_DATA16__LCDIF_DATA16  0x79
+			MX6UL_PAD_LCD_DATA17__LCDIF_DATA17  0x79
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6ul-isiot-emmc.dts b/arch/arm/boot/dts/imx6ul-isiot-emmc.dts
index f5b4228..73a1d0f 100644
--- a/arch/arm/boot/dts/imx6ul-isiot-emmc.dts
+++ b/arch/arm/boot/dts/imx6ul-isiot-emmc.dts
@@ -43,6 +43,7 @@
 /dts-v1/;
 
 #include "imx6ul-isiot.dtsi"
+#include "imx6ul-isiot-common.dtsi"
 
 / {
 	model = "Engicam Is.IoT MX6UL eMMC Starter kit";
diff --git a/arch/arm/boot/dts/imx6ul-isiot-nand.dts b/arch/arm/boot/dts/imx6ul-isiot-nand.dts
index de15e1c..da29a86 100644
--- a/arch/arm/boot/dts/imx6ul-isiot-nand.dts
+++ b/arch/arm/boot/dts/imx6ul-isiot-nand.dts
@@ -43,6 +43,7 @@
 /dts-v1/;
 
 #include "imx6ul-isiot.dtsi"
+#include "imx6ul-isiot-common.dtsi"
 
 / {
 	model = "Engicam Is.IoT MX6UL NAND Starter kit";
-- 
1.9.1
