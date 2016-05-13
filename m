From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 13 May 2016 09:55:56 +0200
Subject: [PATCH 16/23] ARM: dts: kzm9d: Fix W=1 dtc warnings
In-Reply-To: <1463126163-29423-1-git-send-email-geert+renesas@glider.be>
References: <1463126163-29423-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1463126163-29423-17-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /pfc at e0140200/serial at e1030000 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /gpio_keys/button at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /gpio_keys/button at 2 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /gpio_keys/button at 3 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /gpio_keys/button at 4 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /regulator at 1 has a unit name, but no reg property

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/emev2-kzm9d.dts | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index a35b851e1cd7678a..9eb86f8f32c5afc0 100644
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
1.9.1
