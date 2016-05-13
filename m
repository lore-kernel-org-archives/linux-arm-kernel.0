From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 13 May 2016 09:55:58 +0200
Subject: [PATCH 18/23] ARM: dts: lager: Fix W=1 dtc warnings
In-Reply-To: <1463126163-29423-1-git-send-email-geert+renesas@glider.be>
References: <1463126163-29423-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1463126163-29423-19-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Warning (unit_address_vs_reg): Node /keyboard/button at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /keyboard/button at 2 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /keyboard/button at 3 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /keyboard/button at 4 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /fixedregulator at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 2 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 3 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 4 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /i2c at 8 has a unit name, but no reg property

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 749ba02b6a53a9de..c01e27868083147a 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -76,28 +76,28 @@
 	keyboard {
 		compatible = "gpio-keys";
 
-		button at 1 {
+		one {
 			linux,code = <KEY_1>;
 			label = "SW2-1";
 			wakeup-source;
 			debounce-interval = <20>;
 			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
 		};
-		button at 2 {
+		two {
 			linux,code = <KEY_2>;
 			label = "SW2-2";
 			wakeup-source;
 			debounce-interval = <20>;
 			gpios = <&gpio1 24 GPIO_ACTIVE_LOW>;
 		};
-		button at 3 {
+		three {
 			linux,code = <KEY_3>;
 			label = "SW2-3";
 			wakeup-source;
 			debounce-interval = <20>;
 			gpios = <&gpio1 26 GPIO_ACTIVE_LOW>;
 		};
-		button at 4 {
+		four {
 			linux,code = <KEY_4>;
 			label = "SW2-4";
 			wakeup-source;
@@ -119,7 +119,7 @@
 		};
 	};
 
-	fixedregulator3v3: fixedregulator at 0 {
+	fixedregulator3v3: fixedregulator3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-3.3V";
 		regulator-min-microvolt = <3300000>;
@@ -128,7 +128,7 @@
 		regulator-always-on;
 	};
 
-	vcc_sdhi0: regulator at 1 {
+	vcc_sdhi0: regulator-vcc-sdhi0 {
 		compatible = "regulator-fixed";
 
 		regulator-name = "SDHI0 Vcc";
@@ -139,7 +139,7 @@
 		enable-active-high;
 	};
 
-	vccq_sdhi0: regulator at 2 {
+	vccq_sdhi0: regulator-vccq-sdhi0 {
 		compatible = "regulator-gpio";
 
 		regulator-name = "SDHI0 VccQ";
@@ -152,7 +152,7 @@
 			  1800000 0>;
 	};
 
-	vcc_sdhi2: regulator at 3 {
+	vcc_sdhi2: regulator-vcc-sdhi2 {
 		compatible = "regulator-fixed";
 
 		regulator-name = "SDHI2 Vcc";
@@ -163,7 +163,7 @@
 		enable-active-high;
 	};
 
-	vccq_sdhi2: regulator at 4 {
+	vccq_sdhi2: regulator-vccq-sdhi2 {
 		compatible = "regulator-gpio";
 
 		regulator-name = "SDHI2 VccQ";
@@ -263,7 +263,7 @@
 	 * instantiate the slave device at runtime according to the documentation.
 	 * You can then communicate with the slave via IIC3.
 	 */
-	i2cexio: i2c at 8 {
+	i2cexio: i2c-8 {
 		compatible = "i2c-demux-pinctrl";
 		i2c-parent = <&iic0>, <&i2c0>;
 		i2c-bus-name = "i2c-exio";
-- 
1.9.1
