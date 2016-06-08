From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jun 2016 09:59:55 +0900
Subject: [PATCH 25/30] ARM: dts: kzm9d: Fix W=1 dtc warnings
In-Reply-To: <cover.1465346599.git.horms+renesas@verge.net.au>
References: <cover.1465346599.git.horms+renesas@verge.net.au>
Message-ID: <815be9c2a436855227774f77b4d251292792964b.1465346599.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /pfc at e0140200/serial at e1030000 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /gpio_keys/button at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /gpio_keys/button at 2 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /gpio_keys/button at 3 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /gpio_keys/button at 4 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 1 has a unit name, but no reg property

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2-kzm9d.dts | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index a35b851e1cd7..9eb86f8f32c5 100644
--- a/arch/arm/boot/dts/emev2-kzm9d.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d.dts
@@ -18,7 +18,7 @@
 	model = "EMEV2 KZM9D Board";
 	compatible = "renesas,kzm9d", "renesas,emev2";
 
-	memory {
+	memory at 40000000 {
 		device_type = "memory";
 		reg = <0x40000000 0x8000000>;
 	};
@@ -33,28 +33,28 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		button at 1 {
+		one {
 			debounce_interval = <50>;
 			wakeup-source;
 			label = "DSW2-1";
 			linux,code = <KEY_1>;
 			gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
 		};
-		button at 2 {
+		two {
 			debounce_interval = <50>;
 			wakeup-source;
 			label = "DSW2-2";
 			linux,code = <KEY_2>;
 			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
 		};
-		button at 3 {
+		three {
 			debounce_interval = <50>;
 			wakeup-source;
 			label = "DSW2-3";
 			linux,code = <KEY_3>;
 			gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
 		};
-		button at 4 {
+		four {
 			debounce_interval = <50>;
 			wakeup-source;
 			label = "DSW2-4";
@@ -63,7 +63,7 @@
 		};
 	};
 
-	reg_1p8v: regulator at 0 {
+	reg_1p8v: regulator-1p8v {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-1.8V";
 		regulator-min-microvolt = <1800000>;
@@ -72,7 +72,7 @@
 		regulator-boot-on;
 	};
 
-	reg_3p3v: regulator at 1 {
+	reg_3p3v: regulator-3p3v {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-3.3V";
 		regulator-min-microvolt = <3300000>;
@@ -104,7 +104,7 @@
 };
 
 &pfc {
-	uart1_pins: serial at e1030000 {
+	uart1_pins: uart1 {
 		groups = "uart1_ctrl", "uart1_data";
 		function = "uart1";
 	};
-- 
2.1.4
