From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 11 Oct 2017 13:50:33 +0200
Subject: [PATCH 10/12] ARM: dts: imx6-tx6: add a .dtsi file for the MB7
 baseboard
In-Reply-To: <1507722635-30801-1-git-send-email-LW@KARO-electronics.de>
References: <1507722635-30801-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1507722635-30801-11-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the MB7 specific settings to a separate .dtsi file to facilitate
supporting more module variants with this baseboard.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts |  9 +--
 arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts  | 42 +------------
 arch/arm/boot/dts/imx6qdl-tx6-mb7.dtsi     | 99 ++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6qdl-tx6-mb7.dtsi

diff --git a/arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts b/arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts
index e43ff12..21eaec9 100644
--- a/arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts
@@ -43,6 +43,7 @@
 #include "imx6dl.dtsi"
 #include "imx6qdl-tx6.dtsi"
 #include "imx6qdl-tx6-lvds.dtsi"
+#include "imx6qdl-tx6-mb7.dtsi"
 
 / {
 	model = "Ka-Ro electronics TX6U-81xx Module on MB7 baseboard";
@@ -58,11 +59,3 @@
 	pwms = <&pwm1 0 500000 PWM_POLARITY_INVERTED>;
 	turn-on-delay-ms = <35>;
 };
-
-&can1 {
-	status = "disabled";
-};
-
-&can2 {
-	xceiver-supply = <&reg_3v3>;
-};
diff --git a/arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts b/arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts
index 9648c21..387edf2 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts
@@ -40,47 +40,9 @@
  */
 
 /dts-v1/;
-#include "imx6q.dtsi"
-#include "imx6qdl-tx6.dtsi"
-#include "imx6qdl-tx6-lvds.dtsi"
+#include "imx6q-tx6q-1110.dts"
+#include "imx6qdl-tx6-mb7.dtsi"
 
 / {
 	model = "Ka-Ro electronics TX6Q-1110/-1130 Module on MB7 baseboard";
-	compatible = "karo,imx6q-tx6q", "fsl,imx6q";
-};
-
-&backlight0 {
-	pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
-	turn-on-delay-ms = <35>;
-	power-supply = <&reg_lcd1_pwr>;
-};
-
-&backlight1 {
-	pwms = <&pwm1 0 500000 PWM_POLARITY_INVERTED>;
-	turn-on-delay-ms = <35>;
-	power-supply = <&reg_lcd1_pwr>;
-};
-
-&can1 {
-	status = "disabled";
-};
-
-&can2 {
-	xceiver-supply = <&reg_3v3>;
-};
-
-&ipu2 {
-	status = "disabled";
-};
-
-&lvds0_panel {
-	compatible = "edt,et057090dhu";
-};
-
-&lvds1_panel {
-	compatible = "edt,et057090dhu";
-};
-
-&sata {
-	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-tx6-mb7.dtsi b/arch/arm/boot/dts/imx6qdl-tx6-mb7.dtsi
new file mode 100644
index 0000000..4c4e2e1
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-tx6-mb7.dtsi
@@ -0,0 +1,99 @@
+/*
+ * Copyright 2017 Lothar Wa?mann <LW@KARO-electronics.de>
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
+/ {
+	backlight0 {
+		pwms = <&pwm1 0 500000 PWM_POLARITY_INVERTED>;
+		turn-on-delay-ms = <35>;
+		power-supply = <&reg_lcd1_pwr>;
+	};
+
+	backlight1 {
+		pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
+		turn-on-delay-ms = <35>;
+		power-supply = <&reg_lcd1_pwr>;
+	};
+
+	lcd-panel {
+		compatible = "edt,et057090dhu";
+		bus-format-override = "rgb24";
+		pixelclk-active = <0>;
+	};
+
+	lvds0-panel {
+		compatible = "edt,etml1010g0dka";
+		bus-format-override = "spwg-18";
+		pixelclk-active = <0>;
+	};
+
+	lvds1-panel {
+		compatible = "edt,etml1010g0dka";
+		bus-format-override = "spwg-18";
+		pixelclk-active = <0>;
+	};
+};
+
+&can1 {
+	status = "disabled";
+};
+
+&can2 {
+	xceiver-supply = <&reg_3v3>;
+};
+
+&ds1339 {
+	/*
+	 * The backup voltage of the module internal RTC is not wired
+	 * by default on the MB7, so disable that RTC chip.
+	 */
+	status = "disabled";
+};
+
+&i2c3 {
+	rtc: mcp7940x at 6f {
+		compatible = "microchip,mcp7940x";
+		reg = <0x6f>;
+	};
+};
+
+&reg_lcd0_pwr {
+	status = "disabled";
+};
-- 
2.1.4
