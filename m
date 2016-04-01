From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 01 Apr 2016 15:57:47 +0900
Subject: [PATCH 04/11] ARM: dts: exynos: Fix DTC unit name warnings in Trats2
 board
In-Reply-To: <1459493874-2366-1-git-send-email-k.kozlowski@samsung.com>
References: <1459493874-2366-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1459493874-2366-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix following DTC warnings in Trats2 board:

Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /i2c-gpio-1/max77693 at 66/regulators/ESAFEOUT1 at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /i2c-gpio-1/max77693 at 66/regulators/ESAFEOUT2 at 2 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /i2c-gpio-1/max77693 at 66/regulators/CHARGER at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /thermistor-ap at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /thermistor-battery at 1 has a unit name, but no reg property

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 2bf363c3bf62..523627003738 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -29,7 +29,7 @@
 		i2c12 = &i2c_max77693_fuel;
 	};
 
-	memory {
+	mmemory at 40000000 {
 		reg =  <0x40000000 0x40000000>;
 	};
 
@@ -146,13 +146,13 @@
 			reg = <0x66>;
 
 			regulators {
-				esafeout1_reg: ESAFEOUT1 at 1 {
+				esafeout1_reg: ESAFEOUT1 {
 					regulator-name = "ESAFEOUT1";
 				};
-				esafeout2_reg: ESAFEOUT2 at 2 {
+				esafeout2_reg: ESAFEOUT2 {
 					regulator-name = "ESAFEOUT2";
 				};
-				charger_reg: CHARGER at 0 {
+				charger_reg: CHARGER {
 					regulator-name = "CHARGER";
 					regulator-min-microamp = <60000>;
 					regulator-max-microamp = <2580000>;
@@ -251,7 +251,7 @@
 			"SPK", "SPKOUTRP";
 	};
 
-	thermistor-ap at 0 {
+	thermistor-ap {
 		compatible = "ntc,ncp15wb473";
 		pullup-uv = <1800000>;	 /* VCC_1.8V_AP */
 		pullup-ohm = <100000>;	 /* 100K */
@@ -259,7 +259,7 @@
 		io-channels = <&adc 1>;  /* AP temperature */
 	};
 
-	thermistor-battery at 1 {
+	thermistor-battery {
 		compatible = "ntc,ncp15wb473";
 		pullup-uv = <1800000>;	 /* VCC_1.8V_AP */
 		pullup-ohm = <100000>;	 /* 100K */
@@ -1276,7 +1276,7 @@
 	cs-gpios = <&gpb 5 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 
-	s5c73m3_spi: s5c73m3 {
+	s5c73m3_spi: s5c73m3 at 0 {
 		compatible = "samsung,s5c73m3";
 		spi-max-frequency = <50000000>;
 		reg = <0>;
-- 
2.5.0
