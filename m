From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 20 Sep 2012 10:53:17 +0200
Subject: [RFC 6/6] ARM: dts: exynos4210: Add platform-specific descriptions for
 pin controllers
In-Reply-To: <1348131197-25506-1-git-send-email-t.figa@samsung.com>
References: <1348131197-25506-1-git-send-email-t.figa@samsung.com>
Message-ID: <1348131197-25506-7-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch "pinctrl: samsung: Parse pin banks from DT" introduced
platform-specific data parsing from DT.

This patch adds all necessary nodes and properties to exynos4210 device
tree sources.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4210-pinctrl-banks.dtsi | 605 ++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi       |   2 +
 arch/arm/boot/dts/exynos4210.dtsi               |  12 +
 3 files changed, 619 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos4210-pinctrl-banks.dtsi

diff --git a/arch/arm/boot/dts/exynos4210-pinctrl-banks.dtsi b/arch/arm/boot/dts/exynos4210-pinctrl-banks.dtsi
new file mode 100644
index 0000000..cac7f71
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4210-pinctrl-banks.dtsi
@@ -0,0 +1,605 @@
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
+	pinctrl at 11400000 {
+		gpa0: pin-bank at 0 {
+			gpio-controller;
+			samsung,pctl-offset = <0x000>;
+			samsung,pin-bank = "gpa0";
+			samsung,pin-count = <8>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x00>;
+		};
+
+		gpa1: pin-bank at 1 {
+			gpio-controller;
+			samsung,pctl-offset = <0x020>;
+			samsung,pin-bank = "gpa1";
+			samsung,pin-count = <6>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x04>;
+		};
+
+		gpb: pin-bank at 2 {
+			gpio-controller;
+			samsung,pctl-offset = <0x040>;
+			samsung,pin-bank = "gpb";
+			samsung,pin-count = <8>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x08>;
+		};
+
+		gpc0: pin-bank at 3 {
+			gpio-controller;
+			samsung,pctl-offset = <0x060>;
+			samsung,pin-bank = "gpc0";
+			samsung,pin-count = <5>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x0C>;
+		};
+
+		gpc1: pin-bank at 4 {
+			gpio-controller;
+			samsung,pctl-offset = <0x080>;
+			samsung,pin-bank = "gpc1";
+			samsung,pin-count = <5>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x10>;
+		};
+
+		gpd0: pin-bank at 5 {
+			gpio-controller;
+			samsung,pctl-offset = <0x0A0>;
+			samsung,pin-bank = "gpd0";
+			samsung,pin-count = <4>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x14>;
+		};
+
+		gpd1: pin-bank at 6 {
+			gpio-controller;
+			samsung,pctl-offset = <0x0C0>;
+			samsung,pin-bank = "gpd1";
+			samsung,pin-count = <4>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x18>;
+		};
+
+		gpe0: pin-bank at 7 {
+			gpio-controller;
+			samsung,pctl-offset = <0x0E0>;
+			samsung,pin-bank = "gpe0";
+			samsung,pin-count = <4>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x1C>;
+		};
+
+		gpe1: pin-bank at 8 {
+			gpio-controller;
+			samsung,pctl-offset = <0x100>;
+			samsung,pin-bank = "gpe1";
+			samsung,pin-count = <4>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x20>;
+		};
+
+		gpe2: pin-bank at 9 {
+			gpio-controller;
+			samsung,pctl-offset = <0x120>;
+			samsung,pin-bank = "gpe2";
+			samsung,pin-count = <4>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x24>;
+		};
+
+		gpe3: pin-bank at 10 {
+			gpio-controller;
+			samsung,pctl-offset = <0x140>;
+			samsung,pin-bank = "gpe3";
+			samsung,pin-count = <4>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x28>;
+		};
+
+		gpe4: pin-bank at 11 {
+			gpio-controller;
+			samsung,pctl-offset = <0x160>;
+			samsung,pin-bank = "gpe4";
+			samsung,pin-count = <4>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x2C>;
+		};
+
+		gpf0: pin-bank at 12 {
+			gpio-controller;
+			samsung,pctl-offset = <0x180>;
+			samsung,pin-bank = "gpf0";
+			samsung,pin-count = <8>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x30>;
+		};
+
+		gpf1: pin-bank at 13 {
+			gpio-controller;
+			samsung,pctl-offset = <0x1A0>;
+			samsung,pin-bank = "gpf1";
+			samsung,pin-count = <8>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x34>;
+		};
+
+		gpf2: pin-bank at 14 {
+			gpio-controller;
+			samsung,pctl-offset = <0x1C0>;
+			samsung,pin-bank = "gpf2";
+			samsung,pin-count = <8>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x38>;
+		};
+
+		gpf3: pin-bank at 15 {
+			gpio-controller;
+			samsung,pctl-offset = <0x1E0>;
+			samsung,pin-bank = "gpf3";
+			samsung,pin-count = <6>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x3C>;
+		};
+	};
+
+	pinctrl at 11000000 {
+		gpj0: pin-bank at 0 {
+			gpio-controller;
+			samsung,pctl-offset = <0x000>;
+			samsung,pin-bank = "gpj0";
+			samsung,pin-count = <8>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x00>;
+		};
+
+		gpj1: pin-bank at 1 {
+			gpio-controller;
+			samsung,pctl-offset = <0x020>;
+			samsung,pin-bank = "gpj1";
+			samsung,pin-count = <5>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x04>;
+		};
+
+		gpk0: pin-bank at 2 {
+			gpio-controller;
+			samsung,pctl-offset = <0x040>;
+			samsung,pin-bank = "gpk0";
+			samsung,pin-count = <7>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x08>;
+		};
+
+		gpk1: pin-bank at 3 {
+			gpio-controller;
+			samsung,pctl-offset = <0x060>;
+			samsung,pin-bank = "gpk1";
+			samsung,pin-count = <7>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x0C>;
+		};
+
+		gpk2: pin-bank at 4 {
+			gpio-controller;
+			samsung,pctl-offset = <0x080>;
+			samsung,pin-bank = "gpk2";
+			samsung,pin-count = <7>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x10>;
+		};
+
+		gpk3: pin-bank at 5 {
+			gpio-controller;
+			samsung,pctl-offset = <0x0A0>;
+			samsung,pin-bank = "gpk3";
+			samsung,pin-count = <7>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x14>;
+		};
+
+		gpl0: pin-bank at 6 {
+			gpio-controller;
+			samsung,pctl-offset = <0x0C0>;
+			samsung,pin-bank = "gpl0";
+			samsung,pin-count = <7>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x18>;
+		};
+
+		gpl1: pin-bank at 7 {
+			gpio-controller;
+			samsung,pctl-offset = <0x0E0>;
+			samsung,pin-bank = "gpl1";
+			samsung,pin-count = <2>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x1C>;
+		};
+
+		gpl2: pin-bank at 8 {
+			gpio-controller;
+			samsung,pctl-offset = <0x100>;
+			samsung,pin-bank = "gpl2";
+			samsung,pin-count = <8>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x20>;
+		};
+
+		gpm0: pin-bank at 9 {
+			gpio-controller;
+			samsung,pctl-offset = <0x260>;
+			samsung,pin-bank = "gpm0";
+			samsung,pin-count = <8>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x24>;
+		};
+
+		gpm1: pin-bank at 10 {
+			gpio-controller;
+			samsung,pctl-offset = <0x280>;
+			samsung,pin-bank = "gpm1";
+			samsung,pin-count = <7>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x28>;
+		};
+
+		gpm2: pin-bank at 11 {
+			gpio-controller;
+			samsung,pctl-offset = <0x2A0>;
+			samsung,pin-bank = "gpm2";
+			samsung,pin-count = <5>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x2C>;
+		};
+
+		gpm3: pin-bank at 12 {
+			gpio-controller;
+			samsung,pctl-offset = <0x2C0>;
+			samsung,pin-bank = "gpm3";
+			samsung,pin-count = <8>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x30>;
+		};
+
+		gpm4: pin-bank at 13 {
+			gpio-controller;
+			samsung,pctl-offset = <0x2E0>;
+			samsung,pin-bank = "gpm4";
+			samsung,pin-count = <8>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+
+			interrupt-controller;
+			samsung,eint-offset = <0x34>;
+		};
+
+		gpy0: pin-bank at 14 {
+			gpio-controller;
+			samsung,pctl-offset = <0x120>;
+			samsung,pin-bank = "gpy0";
+			samsung,pin-count = <6>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+		};
+
+		gpy1: pin-bank at 15 {
+			gpio-controller;
+			samsung,pctl-offset = <0x140>;
+			samsung,pin-bank = "gpy1";
+			samsung,pin-count = <4>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+		};
+
+		gpy2: pin-bank at 16 {
+			gpio-controller;
+			samsung,pctl-offset = <0x160>;
+			samsung,pin-bank = "gpy2";
+			samsung,pin-count = <6>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+		};
+
+		gpy3: pin-bank at 17 {
+			gpio-controller;
+			samsung,pctl-offset = <0x180>;
+			samsung,pin-bank = "gpy3";
+			samsung,pin-count = <8>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+		};
+
+		gpy4: pin-bank at 18 {
+			gpio-controller;
+			samsung,pctl-offset = <0x1A0>;
+			samsung,pin-bank = "gpy4";
+			samsung,pin-count = <8>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+		};
+
+		gpy5: pin-bank at 19{
+			gpio-controller;
+			samsung,pctl-offset = <0x1C0>;
+			samsung,pin-bank = "gpy5";
+			samsung,pin-count = <8>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+		};
+
+		gpy6: pin-bank at 20 {
+			gpio-controller;
+			samsung,pctl-offset = <0x1E0>;
+			samsung,pin-bank = "gpy6";
+			samsung,pin-count = <8>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+			samsung,conpdn-width = <2>;
+			samsung,pudpdn-width = <2>;
+		};
+
+		gpx0: pin-bank at 21 {
+			gpio-controller;
+			samsung,pctl-offset = <0xC00>;
+			samsung,pin-bank = "gpx0";
+			samsung,pin-count = <8>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+		};
+
+		gpx1: pin-bank at 22 {
+			gpio-controller;
+			samsung,pctl-offset = <0xC20>;
+			samsung,pin-bank = "gpx1";
+			samsung,pin-count = <8>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+		};
+
+		gpx2: pin-bank at 23 {
+			gpio-controller;
+			samsung,pctl-offset = <0xC40>;
+			samsung,pin-bank = "gpx2";
+			samsung,pin-count = <8>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+		};
+
+		gpx3: pin-bank at 24 {
+			gpio-controller;
+			samsung,pctl-offset = <0xC60>;
+			samsung,pin-bank = "gpx3";
+			samsung,pin-count = <8>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
+		};
+	};
+
+	pinctrl at 03860000 {
+		gpz: pin-bank at 0 {
+			gpio-controller;
+			samsung,pctl-offset = <0x000>;
+			samsung,pin-bank = "gpz";
+			samsung,pin-count = <7>;
+			samsung,func-width = <4>;
+			samsung,pud-width = <2>;
+			samsung,drv-width = <2>;
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
index ecbc707..0e93717 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -59,6 +59,10 @@
 		reg = <0x11400000 0x1000>;
 		interrupts = <0 47 0>;
 		interrupt-controller;
+		samsung,geint-con = <0x700>;
+		samsung,geint-mask = <0x900>;
+		samsung,geint-pend = <0xA00>;
+		samsung,svc = <0xB08>;
 		#interrupt-cells = <2>;
 	};
 
@@ -67,6 +71,10 @@
 		reg = <0x11000000 0x1000>;
 		interrupts = <0 46 0>;
 		interrupt-controller;
+		samsung,geint-con = <0x700>;
+		samsung,geint-mask = <0x900>;
+		samsung,geint-pend = <0xA00>;
+		samsung,svc = <0xB08>;
 		#interrupt-cells = <2>;
 
 		wakup_eint: wakeup-interrupt-controller {
@@ -79,6 +87,10 @@
 					<0 24 0>, <0 25 0>, <0 26 0>, <0 27 0>,
 					<0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>,
 					<0 32 0>;
+			samsung,weint-count = <32>;
+			samsung,weint-con = <0xE00>;
+			samsung,weint-mask = <0xF00>;
+			samsung,weint-pend = <0xF40>;
 		};
 	};
 
-- 
1.7.12
