From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sun, 17 May 2015 17:09:43 +0900
Subject: [PATCH v6 01/13] ARM: dts: Add labels to exynos4 nodes
In-Reply-To: <1431850195-9558-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1431850195-9558-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1431850195-9558-2-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new labels to certain nodes so they could be easily referenced by
Exynos4 board DTS files.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/boot/dts/exynos4.dtsi            | 22 +++++++++++-----------
 arch/arm/boot/dts/exynos4210.dtsi         |  6 +++---
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi |  8 ++++----
 arch/arm/boot/dts/exynos4x12.dtsi         |  2 +-
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 1c74c1296ab7..0ec292d25b6e 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -257,7 +257,7 @@
 		};
 	};
 
-	watchdog at 10060000 {
+	watchdog: watchdog at 10060000 {
 		compatible = "samsung,s3c2410-wdt";
 		reg = <0x10060000 0x100>;
 		interrupts = <0 43 0>;
@@ -276,7 +276,7 @@
 		status = "disabled";
 	};
 
-	keypad at 100A0000 {
+	keypad: keypad at 100A0000 {
 		compatible = "samsung,s5pv210-keypad";
 		reg = <0x100A0000 0x100>;
 		interrupts = <0 109 0>;
@@ -285,7 +285,7 @@
 		status = "disabled";
 	};
 
-	sdhci at 12510000 {
+	sdhci_0: sdhci at 12510000 {
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12510000 0x100>;
 		interrupts = <0 73 0>;
@@ -294,7 +294,7 @@
 		status = "disabled";
 	};
 
-	sdhci at 12520000 {
+	sdhci_1: sdhci at 12520000 {
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12520000 0x100>;
 		interrupts = <0 74 0>;
@@ -303,7 +303,7 @@
 		status = "disabled";
 	};
 
-	sdhci at 12530000 {
+	sdhci_2: sdhci at 12530000 {
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12530000 0x100>;
 		interrupts = <0 75 0>;
@@ -312,7 +312,7 @@
 		status = "disabled";
 	};
 
-	sdhci at 12540000 {
+	sdhci_3: sdhci at 12540000 {
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12540000 0x100>;
 		interrupts = <0 76 0>;
@@ -331,7 +331,7 @@
 		status = "disabled";
 	};
 
-	hsotg at 12480000 {
+	hsotg: hsotg at 12480000 {
 		compatible = "samsung,s3c6400-hsotg";
 		reg = <0x12480000 0x20000>;
 		interrupts = <0 71 0>;
@@ -342,7 +342,7 @@
 		status = "disabled";
 	};
 
-	ehci at 12580000 {
+	ehci: ehci at 12580000 {
 		compatible = "samsung,exynos4210-ehci";
 		reg = <0x12580000 0x100>;
 		interrupts = <0 70 0>;
@@ -368,7 +368,7 @@
 		};
 	};
 
-	ohci at 12590000 {
+	ohci: ohci at 12590000 {
 		compatible = "samsung,exynos4210-ohci";
 		reg = <0x12590000 0x100>;
 		interrupts = <0 70 0>;
@@ -621,7 +621,7 @@
 		status = "disabled";
 	};
 
-	pwm at 139D0000 {
+	pwm: pwm at 139D0000 {
 		compatible = "samsung,exynos4210-pwm";
 		reg = <0x139D0000 0x1000>;
 		interrupts = <0 37 0>, <0 38 0>, <0 39 0>, <0 40 0>, <0 41 0>;
@@ -689,7 +689,7 @@
 		#include "exynos4412-tmu-sensor-conf.dtsi"
 	};
 
-	jpeg-codec at 11840000 {
+	jpeg_codec: jpeg-codec at 11840000 {
 		compatible = "samsung,exynos4210-jpeg";
 		reg = <0x11840000 0x1000>;
 		interrupts = <0 88 0>;
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index be89f83f70e7..76b84852f29c 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -62,7 +62,7 @@
 		#clock-cells = <1>;
 	};
 
-	sysram at 02020000 {
+	sysram: sysram at 02020000 {
 		compatible = "mmio-sram";
 		reg = <0x02020000 0x20000>;
 		#address-cells = <1>;
@@ -107,7 +107,7 @@
 			     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>;
 	};
 
-	mct at 10050000 {
+	mct: mct at 10050000 {
 		compatible = "samsung,exynos4210-mct";
 		reg = <0x10050000 0x800>;
 		interrupt-parent = <&mct_map>;
@@ -189,7 +189,7 @@
 		};
 	};
 
-	g2d at 12800000 {
+	g2d: g2d at 12800000 {
 		compatible = "samsung,s5pv210-g2d";
 		reg = <0x12800000 0x1000>;
 		interrupts = <0 89 0>;
diff --git a/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi b/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
index c141931378e7..bac25c672789 100644
--- a/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
@@ -29,7 +29,7 @@
 	}
 
 / {
-	pinctrl at 11400000 {
+	pinctrl_0: pinctrl at 11400000 {
 		gpa0: gpa0 {
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -441,7 +441,7 @@
 		};
 	};
 
-	pinctrl at 11000000 {
+	pinctrl_1: pinctrl at 11000000 {
 		gpk0: gpk0 {
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -887,7 +887,7 @@
 		};
 	};
 
-	pinctrl at 03860000 {
+	pinctrl_2: pinctrl at 03860000 {
 		gpz: gpz {
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -913,7 +913,7 @@
 		};
 	};
 
-	pinctrl at 106E0000 {
+	pinctrl_3: pinctrl at 106E0000 {
 		gpv0: gpv0 {
 			gpio-controller;
 			#gpio-cells = <2>;
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 72b9a1d744fa..8cd27641cfb7 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -159,7 +159,7 @@
 		#clock-cells = <1>;
 	};
 
-	g2d at 10800000 {
+	g2d: g2d at 10800000 {
 		compatible = "samsung,exynos4212-g2d";
 		reg = <0x10800000 0x1000>;
 		interrupts = <0 89 0>;
-- 
2.1.4
