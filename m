From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 13 Dec 2012 18:36:18 +0530
Subject: [PATCH] ARM: dts: add pinctrl nodes for Exynos5250 SoC
Message-ID: <1355403978-388-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl device nodes for Exynos5250 SoC.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
Few notes on this patch:
- Only pinctrl-0 and pinctrl-3 nodes have been added. Since pinctrl-1 is
  mostly used for camera interface, and since I do not have good
  understanding of this interface, I assumed the person with better
  understanding of camera interface can add the pinctrl-1 node. And
  pinctrl-2 node is used for C2C controller which I do not understand.
- The individual device nodes which are using the old style Samsung gpio
  bindings have not been converted over to pinctrl bindings yet. It might
  also be important to know if Linus's pinctrl grab in device core patch
  (http://comments.gmane.org/gmane.linux.kernel/1409263) gets accepted.
- This patch should not be merged for now which otherwise would break existing
  platforms which are using the old samsung gpio driver bindings. This patch
  is intended to get started with the migration to pinctrl framework.
  It is probably better to first prepare all the migration patches and
  merge them as a bunch.

 arch/arm/boot/dts/exynos5250-pinctrl.dtsi |  575 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi         |  268 +-------------
 2 files changed, 596 insertions(+), 247 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5250-pinctrl.dtsi

diff --git a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
new file mode 100644
index 0000000..24180fc
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
@@ -0,0 +1,575 @@
+/*
+ * Samsung's Exynos5250 SoC pin-mux and pin-config device tree source
+ *
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Samsung's Exynos5250 SoC pin-mux and pin-config optiosn are listed as device
+ * tree nodes are listed in this file.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/ {
+	pinctrl at 11400000 {
+		gpa0: gpa0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpa1: gpa1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpa2: gpa2 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpb0: gpb0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpb1: gpb1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpb2: gpb2 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpb3: gpb3 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpc0: gpc0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpc1: gpc1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpc2: gpc2 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpc3: gpc3 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpd0: gpd0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpd1: gpd1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpy0: gpy0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpy1: gpy1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpy2: gpy2 {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpy3: gpy3 {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpy4: gpy4 {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpy5: gpy5 {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpy6: gpy6 {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpc4: gpc4 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpx0: gpx0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			interrupt-parent = <&combiner>;
+			#interrupt-cells = <2>;
+			interrupts = <23 0>, <24 0>, <25 0>, <25 1>,
+				     <26 0>, <26 1>, <27 0>, <27 1>;
+		};
+
+		gpx1: gpx1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			interrupt-parent = <&combiner>;
+			#interrupt-cells = <2>;
+			interrupts = <28 0>, <28 1>, <29 0>, <29 1>,
+				     <30 0>, <30 1>, <31 0>, <31 1>;
+		};
+
+		gpx2: gpx2 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpx3: gpx3 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		uart0_data: uart0-data {
+			samsung,pins = "gpa0-0", "gpa0-1";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		uart0_fctl: uart0-fctl {
+			samsung,pins = "gpa0-2", "gpa0-3";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samaung,pin-drv = <0>;
+		};
+
+		i2c2_bus: i2c2-bus {
+			samsung,pins = "gpa0-6", "gpa0-7";
+			samsung,pin-function = <3>;
+			samsung,pin-pud = <3>;
+			samaung,pin-drv = <0>;
+		};
+
+		i2c2_hs_bus: i2c2-hs-bus {
+			samsung,pins = "gpa0-6", "gpa0-7";
+			samsung,pin-function = <4>;
+			samsung,pin-pud = <3>;
+			samaung,pin-drv = <0>;
+		};
+
+		uart2_data: uart2-data {
+			samsung,pins = "gpa1-0", "gpa1-1";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		uart2_fctl: uart2-fctl {
+			samsung,pins = "gpa1-2", "gpa1-3";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samaung,pin-drv = <0>;
+		};
+
+		i2c3_bus: i2c3-bus {
+			samsung,pins = "gpa1-2", "gpa1-3";
+			samsung,pin-function = <3>;
+			samsung,pin-pud = <3>;
+			samaung,pin-drv = <0>;
+		};
+
+		i2c3_hs_bus: i2c3-hs-bus {
+			samsung,pins = "gpa1-2", "gpa1-3";
+			samsung,pin-function = <4>;
+			samsung,pin-pud = <3>;
+			samaung,pin-drv = <0>;
+		};
+
+		uart3_data: uart3-data {
+			samsung,pins = "gpa1-4", "gpa1-4";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		spi0_bus: spi0-bus {
+			samsung,pins = "gpa2-0", "gpa2-2", "gpa2-3";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <0>;
+		};
+
+		i2c4_bus: i2c4-bus {
+			samsung,pins = "gpa2-0", "gpa2-1";
+			samsung,pin-function = <3>;
+			samsung,pin-pud = <3>;
+			samaung,pin-drv = <0>;
+		};
+
+		i2c5_bus: i2c5-bus {
+			samsung,pins = "gpa2-2", "gpa2-3";
+			samsung,pin-function = <3>;
+			samsung,pin-pud = <3>;
+			samaung,pin-drv = <0>;
+		};
+
+		spi1_bus: spi1-bus {
+			samsung,pins = "gpa2-4", "gpa2-6", "gpa2-7";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <0>;
+		};
+
+		i2s1_bus: i2s1-bus {
+			samsung,pins = "gpb0-0", "gpb0-1", "gpb0-2", "gpb0-3",
+					"gpb0-4";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		pcm1_bus: pcm1-bus {
+			samsung,pins = "gpb0-0", "gpb0-1", "gpb0-2", "gpb0-3",
+					"gpb0-4";
+			samsung,pin-function = <3>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		ac97_bus: ac97-bus {
+			samsung,pins = "gpb0-0", "gpb0-1", "gpb0-2", "gpb0-3",
+					"gpb0-4";
+			samsung,pin-function = <4>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		i2s2_bus: i2s2-bus {
+			samsung,pins = "gpb1-0", "gpb1-1", "gpb1-2", "gpb1-3",
+					"gpb1-4";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		pcm2_bus: pcm2-bus {
+			samsung,pins = "gpb1-0", "gpb1-1", "gpb1-2", "gpb1-3",
+					"gpb1-4";
+			samsung,pin-function = <3>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		spdif_bus: spdif-bus {
+			samsung,pins = "gpb1-0", "gpb1-1";
+			samsung,pin-function = <4>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		spi2_bus: spi2-bus {
+			samsung,pins = "gpb1-1", "gpb1-3", "gpb1-4";
+			samsung,pin-function = <5>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <0>;
+		};
+
+		i2c6_bus: i2c6-bus {
+			samsung,pins = "gpb1-3", "gpb1-4";
+			samsung,pin-function = <4>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <0>;
+		};
+
+		i2c7_bus: i2c7-bus {
+			samsung,pins = "gpb2-2", "gpb2-3";
+			samsung,pin-function = <3>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <0>;
+		};
+
+		i2c0_bus: i2c0-bus {
+			samsung,pins = "gpb3-0", "gpb3-1";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <0>;
+		};
+
+		i2c1_bus: i2c1-bus {
+			samsung,pins = "gpb3-2", "gpb3-3";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <0>;
+		};
+
+		i2c0_hs_bus: i2c0-hs-bus {
+			samsung,pins = "gpb3-0", "gpb3-1";
+			samsung,pin-function = <4>;
+			samsung,pin-pud = <3>;
+			samaung,pin-drv = <0>;
+		};
+
+		i2c1_hs_bus: i2c1-hs-bus {
+			samsung,pins = "gpb3-2", "gpb3-3";
+			samsung,pin-function = <4>;
+			samsung,pin-pud = <3>;
+			samaung,pin-drv = <0>;
+		};
+
+		sd0_clk: sd0-clk {
+			samsung,pins = "gpc0-0";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd0_cmd: sd0-cmd {
+			samsung,pins = "gpc0-1";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd0_cd: sd0-cd {
+			samsung,pins = "gpc0-2";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd0_bus1: sd0-bus-width1 {
+			samsung,pins = "gpc0-3";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd0_bus4: sd0-bus-width4 {
+			samsung,pins = "gpc0-3", "gpc0-4", "gpc0-5", "gpc0-6";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd0_bus8: sd0-bus-width8 {
+			samsung,pins = "gpc1-0", "gpc1-1", "gpc1-2", "gpc1-3";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd1_clk: sd1-clk {
+			samsung,pins = "gpc2-0";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd1_cmd: sd1-cmd {
+			samsung,pins = "gpc2-1";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd1_cd: sd1-cd {
+			samsung,pins = "gpc2-2";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd1_bus1: sd1-bus-width1 {
+			samsung,pins = "gpc2-3";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd1_bus4: sd1-bus-width4 {
+			samsung,pins = "gpc2-3", "gpc2-4", "gpc2-5", "gpc2-6";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd2_clk: sd2-clk {
+			samsung,pins = "gpc3-0";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd2_cmd: sd2-cmd {
+			samsung,pins = "gpc3-1";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd2_cd: sd2-cd {
+			samsung,pins = "gpc3-2";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd2_bus1: sd2-bus-width1 {
+			samsung,pins = "gpc3-3";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd2_bus4: sd2-bus-width4 {
+			samsung,pins = "gpc3-3", "gpc3-4", "gpc3-5", "gpc3-6";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd2_bus8: sd2-bus-width8 {
+			samsung,pins = "gpc4-3", "gpc4-4", "gpc4-5", "gpc4-6";
+			samsung,pin-function = <3>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd3_clk: sd3-clk {
+			samsung,pins = "gpc4-0";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd3_cmd: sd3-cmd {
+			samsung,pins = "gpc4-1";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd3_cd: sd3-cd {
+			samsung,pins = "gpc4-2";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd3_bus1: sd3-bus-width1 {
+			samsung,pins = "gpc4-3";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd3_bus4: sd3-bus-width4 {
+			samsung,pins = "gpc4-3", "gpc4-4", "gpc4-5", "gpc4-6";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		uart1_data: uart1-data {
+			samsung,pins = "gpd0-0", "gpd0-1";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		uart1_fctl: uart1-fctl {
+			samsung,pins = "gpd0-2", "gpd0-3";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samaung,pin-drv = <0>;
+		};
+	};
+
+	pinctrl_3: pinctrl at 03680000 {
+		gpz: gpz {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		i2s0_bus: i2s0-bus {
+			samsung,pins = "gpz-0", "gpz-1", "gpz-2", "gpz-3",
+					"gpz-4", "gpz-5", "gpz-6";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 581e57a..eb8d610 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -18,6 +18,7 @@
 */
 
 /include/ "skeleton.dtsi"
+/include/ "exynos5250-pinctrl.dtsi"
 
 / {
 	compatible = "samsung,exynos5250";
@@ -48,6 +49,8 @@
 		mshc1 = &dwmmc_1;
 		mshc2 = &dwmmc_2;
 		mshc3 = &dwmmc_3;
+		pinctrl0 = &pinctrl_0;
+		pinctrl3 = &pinctrl_3;
 	};
 
 	gic:interrupt-controller at 10481000 {
@@ -79,6 +82,24 @@
 		interrupts = <0 42 0>;
 	};
 
+	pinctrl_0: pinctrl at 11400000 {
+		compatible = "samsung,pinctrl-exynos5250";
+		reg = <0x11400000 0x1000>;
+		interrupts = <0 46 0>;
+
+		wakup_eint: wakeup-interrupt-controller {
+			compatible = "samsung,exynos4210-wakeup-eint";
+			interrupt-parent = <&gic>;
+			interrupts = <0 32 0>;
+		};
+	};
+
+	pinctrl_3: pinctrl at 03680000 {
+		compatible = "samsung,pinctrl-exynos5250";
+		reg = <0x0368000 0x1000>;
+		interrupts = <0 45 0>;
+	};
+
 	codec at 11000000 {
 		compatible = "samsung,mfc-v6";
 		reg = <0x11000000 0x10000>;
@@ -331,253 +352,6 @@
 		};
 	};
 
-	gpio-controllers {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		gpio-controller;
-		ranges;
-
-		gpa0: gpio-controller at 11400000 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400000 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpa1: gpio-controller at 11400020 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400020 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpa2: gpio-controller at 11400040 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400040 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpb0: gpio-controller at 11400060 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400060 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpb1: gpio-controller at 11400080 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400080 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpb2: gpio-controller at 114000A0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x114000A0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpb3: gpio-controller at 114000C0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x114000C0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpc0: gpio-controller at 114000E0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x114000E0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpc1: gpio-controller at 11400100 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400100 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpc2: gpio-controller at 11400120 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400120 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpc3: gpio-controller at 11400140 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400140 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpc4: gpio-controller at 114002E0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x114002E0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpd0: gpio-controller at 11400160 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400160 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpd1: gpio-controller at 11400180 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400180 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpy0: gpio-controller at 114001A0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x114001A0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpy1: gpio-controller at 114001C0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x114001C0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpy2: gpio-controller at 114001E0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x114001E0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpy3: gpio-controller at 11400200 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400200 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpy4: gpio-controller at 11400220 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400220 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpy5: gpio-controller at 11400240 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400240 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpy6: gpio-controller at 11400260 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400260 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpx0: gpio-controller at 11400C00 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400C00 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpx1: gpio-controller at 11400C20 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400C20 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpx2: gpio-controller at 11400C40 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400C40 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpx3: gpio-controller at 11400C60 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400C60 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpe0: gpio-controller at 13400000 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x13400000 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpe1: gpio-controller at 13400020 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x13400020 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpf0: gpio-controller at 13400040 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x13400040 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpf1: gpio-controller at 13400060 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x13400060 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpg0: gpio-controller at 13400080 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x13400080 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpg1: gpio-controller at 134000A0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x134000A0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpg2: gpio-controller at 134000C0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x134000C0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gph0: gpio-controller at 134000E0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x134000E0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gph1: gpio-controller at 13400100 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x13400100 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpv0: gpio-controller at 10D10000 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x10D10000 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpv1: gpio-controller at 10D10020 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x10D10020 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpv2: gpio-controller at 10D10040 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x10D10060 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpv3: gpio-controller at 10D10060 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x10D10080 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpv4: gpio-controller at 10D10080 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x10D100C0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpz: gpio-controller at 03860000 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x03860000 0x20>;
-			#gpio-cells = <4>;
-		};
-	};
-
 	gsc_0:  gsc at 0x13e00000 {
 		compatible = "samsung,exynos5-gsc";
 		reg = <0x13e00000 0x1000>;
-- 
1.6.6.rc2
