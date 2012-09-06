From: tony@atomide.com (Tony Lindgren)
Date: Thu, 06 Sep 2012 11:58:24 -0700
Subject: [PATCH 2/5] arm/dts: Add pinctrl driver entries for omap2/3/4
In-Reply-To: <20120906185615.1172.23588.stgit@muffinssi.local>
References: <20120906185615.1172.23588.stgit@muffinssi.local>
Message-ID: <20120906185824.1172.95748.stgit@muffinssi.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl driver entries for omap2+. These all use
the generic pinctrl-single driver for the padconf
registers.

Note that as 2420 and 2430 have different padmux
registers, we now need to include omap2420.dtsi from
omap2420-h4.dts.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: devicetree-discuss at lists.ozlabs.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap2420-h4.dts |    2 +-
 arch/arm/boot/dts/omap2420.dtsi   |   22 ++++++++++++++++++++++
 arch/arm/boot/dts/omap2430.dtsi   |   22 ++++++++++++++++++++++
 arch/arm/boot/dts/omap3.dtsi      |   18 ++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi      |   17 +++++++++++++++++
 5 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/omap2420.dtsi
 create mode 100644 arch/arm/boot/dts/omap2430.dtsi

diff --git a/arch/arm/boot/dts/omap2420-h4.dts b/arch/arm/boot/dts/omap2420-h4.dts
index 25b50b7..77b84e1 100644
--- a/arch/arm/boot/dts/omap2420-h4.dts
+++ b/arch/arm/boot/dts/omap2420-h4.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
 
-/include/ "omap2.dtsi"
+/include/ "omap2420.dtsi"
 
 / {
 	model = "TI OMAP2420 H4 board";
diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
new file mode 100644
index 0000000..8097d13
--- /dev/null
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/include/ "omap2.dtsi"
+
+/ {
+	ocp {
+		omap2420_pmx: pinmux at 48000030 {
+			compatible = "ti,omap2420-padconf", "pinctrl-single";
+			reg = <0x48000030 0x0113>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-single,register-width = <8>;
+			pinctrl-single,function-mask = <0x3f>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
new file mode 100644
index 0000000..d27b6f5
--- /dev/null
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/include/ "omap2.dtsi"
+
+/ {
+	ocp {
+		omap2430_pmx: pinmux at 49002030 {
+			compatible = "ti,omap2430-padconf", "pinctrl-single";
+			reg = <0x49002030 0x0154>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-single,register-width = <8>;
+			pinctrl-single,function-mask = <0x3f>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 9965ed6..c3334bf 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -68,6 +68,24 @@
 			reg = <0x48200000 0x1000>;
 		};
 
+		omap3_pmx_core: pinmux at 48002030 {
+			compatible = "ti,omap3-padconf", "pinctrl-single";
+			reg = <0x48002030 0x05cc>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-single,register-width = <16>;
+			pinctrl-single,function-mask = <0x7fff>;
+		};
+
+		omap3_pmx_wkup: pinmux at 0x48002a58 {
+			compatible = "ti,omap3-padconf", "pinctrl-single";
+			reg = <0x48002a58 0x5c>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-single,register-width = <16>;
+			pinctrl-single,function-mask = <0x7fff>;
+		};
+
 		gpio1: gpio at 48310000 {
 			compatible = "ti,omap3-gpio";
 			ti,hwmods = "gpio1";
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 04cbbcb..4aaab12 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -104,6 +104,23 @@
 			      <0x48240100 0x0100>;
 		};
 
+		omap4_pmx_core: pinmux at 4a100040 {
+			compatible = "ti,omap4-padconf", "pinctrl-single";
+			reg = <0x4a100040 0x0196>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-single,register-width = <16>;
+			pinctrl-single,function-mask = <0x7fff>;
+		};
+		omap4_pmx_wkup: pinmux at 4a31e040 {
+			compatible = "ti,omap4-padconf", "pinctrl-single";
+			reg = <0x4a31e040 0x0038>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-single,register-width = <16>;
+			pinctrl-single,function-mask = <0x7fff>;
+		};
+
 		gpio1: gpio at 4a310000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio1";
