From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 28 Sep 2012 16:28:46 +0200
Subject: [RFC PATCH 15/16] ARM: dts: exynos4210: Add platform-specific
 descriptions for pin controllers
In-Reply-To: <1348842527-22460-1-git-send-email-t.figa@samsung.com>
References: <1348842527-22460-1-git-send-email-t.figa@samsung.com>
Message-ID: <1348842527-22460-16-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch "pinctrl: samsung: Parse pin banks from DT" introduced
platform-specific data parsing from DT.

This patch adds all necessary nodes and properties to exynos4210 device
tree sources.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/exynos4210-pinctrl-banks.dtsi | 459 ++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi       |   2 +
 arch/arm/boot/dts/exynos4210.dtsi               |  25 +-
 3 files changed, 474 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4210-pinctrl-banks.dtsi

diff --git a/arch/arm/boot/dts/exynos4210-pinctrl-banks.dtsi b/arch/arm/boot/dts/exynos4210-pinctrl-banks.dtsi
new file mode 100644
index 0000000..457d28a
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4210-pinctrl-banks.dtsi
@@ -0,0 +1,459 @@
+/*
+ * Samsung's Exynos4210 SoC pinctrl banks device tree source
+ *
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Samsung's Exynos4210 SoC pin banks are listed as device tree nodes
+ * in this file.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/ {
+	pinctrl-bank-types {
+		bank_off: bank-off {
+			samsung,reg-names = "func", "dat", "pud",
+						"drv", "conpdn", "pudpdn";
+			samsung,reg-params = <0x00 4>, <0x04 1>, <0x08 2>,
+						<0x0C 2>, <0x10 2>, <0x14 2>;
+		};
+
+		bank_alive: bank-alive {
+			samsung,reg-names = "func", "dat", "pud",
+						"drv";
+			samsung,reg-params = <0x00 4>, <0x04 1>, <0x08 2>,
+						<0x0C 2>;
+		};
+	};
+
+	pinctrl at 11400000 {
+		gpa0: gpa0 {
+			gpio-controller;
+			samsung,pctl-offset = <0x000>;
+			samsung,pin-count = <8>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x00>;
+			#interrupt-cells = <2>;
+		};
+
+		gpa1: gpa1 {
+			gpio-controller;
+			samsung,pctl-offset = <0x020>;
+			samsung,pin-count = <6>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x04>;
+			#interrupt-cells = <2>;
+		};
+
+		gpb: gpb {
+			gpio-controller;
+			samsung,pctl-offset = <0x040>;
+			samsung,pin-count = <8>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x08>;
+			#interrupt-cells = <2>;
+		};
+
+		gpc0: gpc0 {
+			gpio-controller;
+			samsung,pctl-offset = <0x060>;
+			samsung,pin-count = <5>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x0C>;
+			#interrupt-cells = <2>;
+		};
+
+		gpc1: gpc1 {
+			gpio-controller;
+			samsung,pctl-offset = <0x080>;
+			samsung,pin-count = <5>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x10>;
+			#interrupt-cells = <2>;
+		};
+
+		gpd0: gpd0 {
+			gpio-controller;
+			samsung,pctl-offset = <0x0A0>;
+			samsung,pin-count = <4>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x14>;
+			#interrupt-cells = <2>;
+		};
+
+		gpd1: gpd1 {
+			gpio-controller;
+			samsung,pctl-offset = <0x0C0>;
+			samsung,pin-count = <4>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x18>;
+			#interrupt-cells = <2>;
+		};
+
+		gpe0: gpe0 {
+			gpio-controller;
+			samsung,pctl-offset = <0x0E0>;
+			samsung,pin-count = <4>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x1C>;
+			#interrupt-cells = <2>;
+		};
+
+		gpe1: gpe1 {
+			gpio-controller;
+			samsung,pctl-offset = <0x100>;
+			samsung,pin-count = <4>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x20>;
+			#interrupt-cells = <2>;
+		};
+
+		gpe2: gpe2 {
+			gpio-controller;
+			samsung,pctl-offset = <0x120>;
+			samsung,pin-count = <4>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x24>;
+			#interrupt-cells = <2>;
+		};
+
+		gpe3: gpe3 {
+			gpio-controller;
+			samsung,pctl-offset = <0x140>;
+			samsung,pin-count = <4>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x28>;
+			#interrupt-cells = <2>;
+		};
+
+		gpe4: gpe4 {
+			gpio-controller;
+			samsung,pctl-offset = <0x160>;
+			samsung,pin-count = <4>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x2C>;
+			#interrupt-cells = <2>;
+		};
+
+		gpf0: gpf0 {
+			gpio-controller;
+			samsung,pctl-offset = <0x180>;
+			samsung,pin-count = <8>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x30>;
+			#interrupt-cells = <2>;
+		};
+
+		gpf1: gpf1 {
+			gpio-controller;
+			samsung,pctl-offset = <0x1A0>;
+			samsung,pin-count = <8>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x34>;
+			#interrupt-cells = <2>;
+		};
+
+		gpf2: gpf2 {
+			gpio-controller;
+			samsung,pctl-offset = <0x1C0>;
+			samsung,pin-count = <8>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x38>;
+			#interrupt-cells = <2>;
+		};
+
+		gpf3: gpf3 {
+			gpio-controller;
+			samsung,pctl-offset = <0x1E0>;
+			samsung,pin-count = <6>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x3C>;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pinctrl at 11000000 {
+		gpj0: gpj0 {
+			gpio-controller;
+			samsung,pctl-offset = <0x000>;
+			samsung,pin-count = <8>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x00>;
+			#interrupt-cells = <2>;
+		};
+
+		gpj1: gpj1 {
+			gpio-controller;
+			samsung,pctl-offset = <0x020>;
+			samsung,pin-count = <5>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x04>;
+			#interrupt-cells = <2>;
+		};
+
+		gpk0: gpk0 {
+			gpio-controller;
+			samsung,pctl-offset = <0x040>;
+			samsung,pin-count = <7>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x08>;
+			#interrupt-cells = <2>;
+		};
+
+		gpk1: gpk1 {
+			gpio-controller;
+			samsung,pctl-offset = <0x060>;
+			samsung,pin-count = <7>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x0C>;
+			#interrupt-cells = <2>;
+		};
+
+		gpk2: gpk2 {
+			gpio-controller;
+			samsung,pctl-offset = <0x080>;
+			samsung,pin-count = <7>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x10>;
+			#interrupt-cells = <2>;
+		};
+
+		gpk3: gpk3 {
+			gpio-controller;
+			samsung,pctl-offset = <0x0A0>;
+			samsung,pin-count = <7>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x14>;
+			#interrupt-cells = <2>;
+		};
+
+		gpl0: gpl0 {
+			gpio-controller;
+			samsung,pctl-offset = <0x0C0>;
+			samsung,pin-count = <7>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x18>;
+			#interrupt-cells = <2>;
+		};
+
+		gpl1: gpl1 {
+			gpio-controller;
+			samsung,pctl-offset = <0x0E0>;
+			samsung,pin-count = <2>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x1C>;
+			#interrupt-cells = <2>;
+		};
+
+		gpl2: gpl2 {
+			gpio-controller;
+			samsung,pctl-offset = <0x100>;
+			samsung,pin-count = <8>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x20>;
+			#interrupt-cells = <2>;
+		};
+
+		gpy0: gpy0 {
+			gpio-controller;
+			samsung,pctl-offset = <0x120>;
+			samsung,pin-count = <6>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+		};
+
+		gpy1: gpy1 {
+			gpio-controller;
+			samsung,pctl-offset = <0x140>;
+			samsung,pin-count = <4>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+		};
+
+		gpy2: gpy2 {
+			gpio-controller;
+			samsung,pctl-offset = <0x160>;
+			samsung,pin-count = <6>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+		};
+
+		gpy3: gpy3 {
+			gpio-controller;
+			samsung,pctl-offset = <0x180>;
+			samsung,pin-count = <8>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+		};
+
+		gpy4: gpy4 {
+			gpio-controller;
+			samsung,pctl-offset = <0x1A0>;
+			samsung,pin-count = <8>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+		};
+
+		gpy5: gpy5 {
+			gpio-controller;
+			samsung,pctl-offset = <0x1C0>;
+			samsung,pin-count = <8>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+		};
+
+		gpy6: gpy6 {
+			gpio-controller;
+			samsung,pctl-offset = <0x1E0>;
+			samsung,pin-count = <8>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+		};
+
+		gpx0: gpx0 {
+			gpio-controller;
+			samsung,pctl-offset = <0xC00>;
+			samsung,pin-count = <8>;
+			samsung,bank-type = <&bank_alive>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,wkup-eint;
+			interrupt-parent = <&gic>;
+			interrupts = <0 16 0>, <0 17 0>, <0 18 0>, <0 19 0>,
+				     <0 20 0>, <0 21 0>, <0 22 0>, <0 23 0>;
+			samsung,eint-offset = <0x00>;
+			#interrupt-cells = <2>;
+		};
+
+		gpx1: gpx1 {
+			gpio-controller;
+			samsung,pctl-offset = <0xC20>;
+			samsung,pin-count = <8>;
+			samsung,bank-type = <&bank_alive>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,wkup-eint;
+			interrupt-parent = <&gic>;
+			interrupts = <0 24 0>, <0 25 0>, <0 26 0>, <0 27 0>,
+				     <0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>;
+			samsung,eint-offset = <0x04>;
+			#interrupt-cells = <2>;
+		};
+
+		gpx2: gpx2 {
+			gpio-controller;
+			samsung,pctl-offset = <0xC40>;
+			samsung,pin-count = <8>;
+			samsung,bank-type = <&bank_alive>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,wkup-eint;
+			samsung,eint-offset = <0x08>;
+			#interrupt-cells = <2>;
+		};
+
+		gpx3: gpx3 {
+			gpio-controller;
+			samsung,pctl-offset = <0xC60>;
+			samsung,pin-count = <8>;
+			samsung,bank-type = <&bank_alive>;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			samsung,wkup-eint;
+			samsung,eint-offset = <0x0C>;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pinctrl at 03860000 {
+		gpz: gpz {
+			gpio-controller;
+			samsung,pctl-offset = <0x000>;
+			samsung,pin-count = <7>;
+			samsung,bank-type = <&bank_off>;
+			#gpio-cells = <2>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
index b12cf27..94846d5 100644
--- a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
@@ -14,6 +14,8 @@
  * published by the Free Software Foundation.
 */
 
+/include/ "exynos4210-pinctrl-banks.dtsi"
+
 / {
 	pinctrl at 11400000 {
 		uart0_data: uart0-data {
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index ecbc707..f2f6ef5 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -58,27 +58,28 @@
 		compatible = "samsung,pinctrl-exynos4210";
 		reg = <0x11400000 0x1000>;
 		interrupts = <0 47 0>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
+		samsung,geint-con = <0x700>;
+		samsung,geint-mask = <0x900>;
+		samsung,geint-pend = <0xA00>;
+		samsung,svc = <0xB08>;
 	};
 
 	pinctrl_1: pinctrl at 11000000 {
 		compatible = "samsung,pinctrl-exynos4210";
 		reg = <0x11000000 0x1000>;
 		interrupts = <0 46 0>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
+		samsung,geint-con = <0x700>;
+		samsung,geint-mask = <0x900>;
+		samsung,geint-pend = <0xA00>;
+		samsung,svc = <0xB08>;
 
-		wakup_eint: wakeup-interrupt-controller {
+		wakeup-interrupt-controller {
 			compatible = "samsung,exynos4210-wakeup-eint";
 			interrupt-parent = <&gic>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			interrupts = <0 16 0>, <0 17 0>, <0 18 0>, <0 19 0>,
-					<0 20 0>, <0 21 0>, <0 22 0>, <0 23 0>,
-					<0 24 0>, <0 25 0>, <0 26 0>, <0 27 0>,
-					<0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>,
-					<0 32 0>;
+			interrupts = <0 32 0>;
+			samsung,weint-con = <0xE00>;
+			samsung,weint-mask = <0xF00>;
+			samsung,weint-pend = <0xF40>;
 		};
 	};
 
-- 
1.7.12
