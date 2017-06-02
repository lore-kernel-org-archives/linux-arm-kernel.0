From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri,  2 Jun 2017 20:13:45 +0200
Subject: [PATCH 1/2] ARM: dts: exynos: Use human-friendly symbols for
 interrupt flags in board sources
In-Reply-To: <20170602181346.32166-1-krzk@kernel.org>
References: <20170602181346.32166-1-krzk@kernel.org>
Message-ID: <20170602181346.32166-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace hard-coded values of interrupt flags with respective macros from
header to increase code readability.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos3250-monk.dts             | 6 +++---
 arch/arm/boot/dts/exynos3250-rinato.dts           | 6 +++---
 arch/arm/boot/dts/exynos4210-origen.dts           | 2 +-
 arch/arm/boot/dts/exynos4210-trats.dts            | 4 ++--
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi   | 6 +++---
 arch/arm/boot/dts/exynos4412-odroidx.dts          | 2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts           | 8 ++++----
 arch/arm/boot/dts/exynos5420-peach-pit.dts        | 4 ++--
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi | 2 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts         | 4 ++--
 10 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index cccfe4b791d1..accee81da266 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -67,7 +67,7 @@
 		max77836: subpmic at 25 {
 			compatible = "maxim,max77836";
 			interrupt-parent = <&gpx1>;
-			interrupts = <5 0>;
+			interrupts = <5 IRQ_TYPE_NONE>;
 			reg = <0x25>;
 			wakeup-source;
 
@@ -191,7 +191,7 @@
 	s2mps14_pmic at 66 {
 		compatible = "samsung,s2mps14-pmic";
 		interrupt-parent = <&gpx0>;
-		interrupts = <7 0>;
+		interrupts = <7 IRQ_TYPE_NONE>;
 		reg = <0x66>;
 		wakeup-source;
 
@@ -414,7 +414,7 @@
 	fuelgauge at 36 {
 		compatible = "maxim,max77836-battery";
 		interrupt-parent = <&gpx1>;
-		interrupts = <2 8>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 		reg = <0x36>;
 	};
 };
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index c9f191ca7b9c..118235b72e90 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -58,7 +58,7 @@
 		max77836: subpmic at 25 {
 			compatible = "maxim,max77836";
 			interrupt-parent = <&gpx1>;
-			interrupts = <5 0>;
+			interrupts = <5 IRQ_TYPE_NONE>;
 			reg = <0x25>;
 			wakeup-source;
 
@@ -295,7 +295,7 @@
 	s2mps14_pmic at 66 {
 		compatible = "samsung,s2mps14-pmic";
 		interrupt-parent = <&gpx0>;
-		interrupts = <7 0>;
+		interrupts = <7 IRQ_TYPE_NONE>;
 		reg = <0x66>;
 		wakeup-source;
 
@@ -626,7 +626,7 @@
 	fuelgauge at 36 {
 		compatible = "maxim,max77836-battery";
 		interrupt-parent = <&gpx1>;
-		interrupts = <2 8>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 		reg = <0x36>;
 	};
 };
diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 312650e2450f..084fcc5574ef 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -151,7 +151,7 @@
 		compatible = "maxim,max8997-pmic";
 		reg = <0x66>;
 		interrupt-parent = <&gpx0>;
-		interrupts = <4 0>, <3 0>;
+		interrupts = <4 IRQ_TYPE_NONE>, <3 IRQ_TYPE_NONE>;
 
 		max8997,pmic-buck1-dvs-voltage = <1350000>;
 		max8997,pmic-buck2-dvs-voltage = <1100000>;
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 1743ca850070..645feffb9239 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -281,7 +281,7 @@
 		compatible = "melfas,mms114";
 		reg = <0x48>;
 		interrupt-parent = <&gpx0>;
-		interrupts = <4 2>;
+		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
 		x-size = <720>;
 		y-size = <1280>;
 		avdd-supply = <&tsp_reg>;
@@ -302,7 +302,7 @@
 
 		reg = <0x66>;
 		interrupt-parent = <&gpx0>;
-		interrupts = <7 0>;
+		interrupts = <7 IRQ_TYPE_NONE>;
 
 		max8997,pmic-buck1-uses-gpio-dvs;
 		max8997,pmic-buck2-uses-gpio-dvs;
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 0f1ff792fe44..219d587c5a85 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -32,7 +32,7 @@
 
 		power_key {
 			interrupt-parent = <&gpx1>;
-			interrupts = <3 0>;
+			interrupts = <3 IRQ_TYPE_NONE>;
 			gpios = <&gpx1 3 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			label = "power key";
@@ -266,7 +266,7 @@
 	max77686: pmic at 09 {
 		compatible = "maxim,max77686";
 		interrupt-parent = <&gpx3>;
-		interrupts = <2 0>;
+		interrupts = <2 IRQ_TYPE_NONE>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&max77686_irq>;
 		reg = <0x09>;
@@ -484,7 +484,7 @@
 		compatible = "maxim,max98090";
 		reg = <0x10>;
 		interrupt-parent = <&gpx0>;
-		interrupts = <0 0>;
+		interrupts = <0 IRQ_TYPE_NONE>;
 		clocks = <&i2s0 CLK_I2S_CDCLK>;
 		clock-names = "mclk";
 		#sound-dai-cells = <0>;
diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 46b931eec228..97882267ef09 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -44,7 +44,7 @@
 
 		home_key {
 			interrupt-parent = <&gpx2>;
-			interrupts = <2 0>;
+			interrupts = <2 IRQ_TYPE_NONE>;
 			gpios = <&gpx2 2 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_HOME>;
 			label = "home key";
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 82221a00444d..35e9b94b86b8 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -144,7 +144,7 @@
 		max77693 at 66 {
 			compatible = "maxim,max77693";
 			interrupt-parent = <&gpx1>;
-			interrupts = <5 2>;
+			interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
 			reg = <0x66>;
 
 			regulators {
@@ -224,7 +224,7 @@
 			compatible = "capella,cm36651";
 			reg = <0x18>;
 			interrupt-parent = <&gpx0>;
-			interrupts = <2 2>;
+			interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
 			vled-supply = <&ps_als_reg>;
 		};
 	};
@@ -573,7 +573,7 @@
 		compatible = "melfas,mms114";
 		reg = <0x48>;
 		interrupt-parent = <&gpm2>;
-		interrupts = <3 2>;
+		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
 		x-size = <720>;
 		y-size = <1280>;
 		avdd-supply = <&ldo23_reg>;
@@ -611,7 +611,7 @@
 	max77686: max77686_pmic at 09 {
 		compatible = "maxim,max77686";
 		interrupt-parent = <&gpx0>;
-		interrupts = <7 0>;
+		interrupts = <7 IRQ_TYPE_NONE>;
 		reg = <0x09>;
 		#clock-cells = <1>;
 
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 2cd65699a29c..f9a75bfd3f2b 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -603,7 +603,7 @@
 	max98090: codec at 10 {
 		compatible = "maxim,max98090";
 		reg = <0x10>;
-		interrupts = <2 0>;
+		interrupts = <2 IRQ_TYPE_NONE>;
 		interrupt-parent = <&gpx0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&max98090_irq>;
@@ -944,7 +944,7 @@
 	cros_ec: cros-ec at 0 {
 		compatible = "google,cros-ec-spi";
 		interrupt-parent = <&gpx1>;
-		interrupts = <5 0>;
+		interrupts = <5 IRQ_TYPE_NONE>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&ec_spi_cs &ec_irq>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
index 9493923ec652..c0b85981c6bf 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
@@ -49,7 +49,7 @@
 		compatible = "maxim,max98090";
 		reg = <0x10>;
 		interrupt-parent = <&gpx3>;
-		interrupts = <2 0>;
+		interrupts = <2 IRQ_TYPE_NONE>;
 		clocks = <&i2s0 CLK_I2S_CDCLK>;
 		clock-names = "mclk";
 		#sound-dai-cells = <0>;
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index ecf1c916e8fc..953dc8677dc8 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -603,7 +603,7 @@
 	max98091: codec at 10 {
 		compatible = "maxim,max98091";
 		reg = <0x10>;
-		interrupts = <2 0>;
+		interrupts = <2 IRQ_TYPE_NONE>;
 		interrupt-parent = <&gpx0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&max98091_irq>;
@@ -913,7 +913,7 @@
 	cros_ec: cros-ec at 0 {
 		compatible = "google,cros-ec-spi";
 		interrupt-parent = <&gpx1>;
-		interrupts = <5 0>;
+		interrupts = <5 IRQ_TYPE_NONE>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&ec_spi_cs &ec_irq>;
 		reg = <0>;
-- 
2.9.3
