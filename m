From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 17 Oct 2017 11:17:53 +0200
Subject: [PATCHv3 02/12] ARM: dts: imx6-tx6: remove obsolete eeti,egalax_ts
In-Reply-To: <1508231883-12067-1-git-send-email-LW@KARO-electronics.de>
References: <1508230414-8090-1-git-send-email-LW@KARO-electronics.de>
 <1508231883-12067-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1508231883-12067-3-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The display, that incorporates this touchpanel is obsolete and won't
be supported any more.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6dl-tx6u-811x.dts     | 23 +----------------------
 arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts | 22 +---------------------
 arch/arm/boot/dts/imx6q-tx6q-1110.dts      | 21 ---------------------
 arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts  | 22 +---------------------
 4 files changed, 3 insertions(+), 85 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-tx6u-811x.dts b/arch/arm/boot/dts/imx6dl-tx6u-811x.dts
index 5e0c6bb..f0f759a 100644
--- a/arch/arm/boot/dts/imx6dl-tx6u-811x.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6u-811x.dts
@@ -1,5 +1,5 @@
 /*
- * Copyright 2014-2016 Lothar Wa?mann <LW@KARO-electronics.de>
+ * Copyright 2014-2017 Lothar Wa?mann <LW@KARO-electronics.de>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -98,19 +98,6 @@
 	};
 };
 
-&i2c3 {
-	polytouch2: eeti at 04 {
-		compatible = "eeti,egalax_ts";
-		reg = <0x04>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_eeti>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <22 0>;
-		wakeup-gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
-		wakeup-source;
-	};
-};
-
 &kpp {
 	status = "disabled"; /* pad conflict with backlight1 PWM */
 };
@@ -168,11 +155,3 @@
 &pwm1 {
 	status = "okay";
 };
-
-&iomuxc {
-	pinctrl_eeti: eetigrp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_D22__GPIO3_IO22 0x1b0b1 /* Interrupt */
-		>;
-	};
-};
diff --git a/arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts b/arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts
index b9a783f..c817324 100644
--- a/arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts
@@ -1,5 +1,5 @@
 /*
- * Copyright 2016 Lothar Wa?mann <LW@KARO-electronics.de>
+ * Copyright 2016-2017 Lothar Wa?mann <LW@KARO-electronics.de>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -106,18 +106,6 @@
 	xceiver-supply = <&reg_3v3>;
 };
 
-&i2c3 {
-	polytouch1: eeti at 04 {
-		compatible = "eeti,egalax_ts";
-		reg = <0x04>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_eeti>;
-		interrupts-extended = <&gpio3 22 IRQ_TYPE_EDGE_FALLING>;
-		wakeup-gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
-		wakeup-source;
-	};
-};
-
 &kpp {
 	status = "disabled"; /* pads partially clash with backlight1 PWM */
 };
@@ -245,11 +233,3 @@
 &pwm1 {
 	status = "okay";
 };
-
-&iomuxc {
-	pinctrl_eeti: eetigrp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_D22__GPIO3_IO22 0x1b0b1 /* Interrupt */
-		>;
-	};
-};
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1110.dts b/arch/arm/boot/dts/imx6q-tx6q-1110.dts
index 0f5e638..900557d 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1110.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1110.dts
@@ -98,19 +98,6 @@
 	};
 };
 
-&i2c3 {
-	polytouch1: eeti at 04 {
-		compatible = "eeti,egalax_ts";
-		reg = <0x04>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_eeti>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <22 0>;
-		wakeup-gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
-		wakeup-source;
-	};
-};
-
 &kpp {
 	status = "disabled"; /* pad conflict with backlight1 PWM */
 };
@@ -172,11 +159,3 @@
 &sata {
 	status = "okay";
 };
-
-&iomuxc {
-	pinctrl_eeti: eetigrp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_D22__GPIO3_IO22 0x1b0b1 /* Interrupt */
-		>;
-	};
-};
diff --git a/arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts b/arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts
index d78b129..6b42c44 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts
@@ -1,5 +1,5 @@
 /*
- * Copyright 2016 Lothar Wa?mann <LW@KARO-electronics.de>
+ * Copyright 2016-2017 Lothar Wa?mann <LW@KARO-electronics.de>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -107,18 +107,6 @@
 	xceiver-supply = <&reg_3v3>;
 };
 
-&i2c3 {
-	polytouch1: eeti at 04 {
-		compatible = "eeti,egalax_ts";
-		reg = <0x04>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_eeti>;
-		interrupts-extended = <&gpio3 22 IRQ_TYPE_EDGE_FALLING>;
-		wakeup-gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
-		wakeup-source;
-	};
-};
-
 &ipu2 {
 	status = "disabled";
 };
@@ -254,11 +242,3 @@
 &sata {
 	status = "okay";
 };
-
-&iomuxc {
-	pinctrl_eeti: eetigrp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_D22__GPIO3_IO22 0x1b0b1 /* Interrupt */
-		>;
-	};
-};
-- 
2.1.4
