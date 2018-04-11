From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 11 Apr 2018 16:53:58 +0800
Subject: [PATCH v2 05/12] arm: dts: mt7623: fix all Warnings
 (unit_address_vs_reg)
In-Reply-To: <cover.1523434757.git.sean.wang@mediatek.com>
References: <cover.1523434757.git.sean.wang@mediatek.com>
Message-ID: <9b5b74f9847d024c05b5d485c967c8b9c8eec561.1523434758.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Fix below a lot of Warnings (unit_address_vs_reg) that dtc complains so
much for

Node /oscillator at 1 has a unit name, but no reg property
Node /oscillator at 0 has a unit name, but no reg property
Node /pinctrl at 10005000/cir at 0 has a unit name, but no reg property
Node /pinctrl at 10005000/i2c at 0 has a unit name, but no reg property
Node /pinctrl at 10005000/i2c at 1 has a unit name, but no reg property
Node /pinctrl at 10005000/i2s at 0 has a unit name, but no reg property
Node /pinctrl at 10005000/i2s at 1 has a unit name, but no reg property
Node /pinctrl at 10005000/keys at 0 has a unit name, but no reg property
Node /pinctrl at 10005000/leds at 0 has a unit name, but no reg property
Node /pinctrl at 10005000/pwm at 0 has a unit name, but no reg property
Node /pinctrl at 10005000/spi at 0 has a unit name, but no reg property
Node /pinctrl at 10005000/uart at 0 has a unit name, but no reg property
Node /pinctrl at 10005000/uart at 1 has a unit name, but no reg property
Node /pinctrl at 10005000/uart at 2 has a unit name, but no reg property
Node /ethernet at 1b100000/mdio-bus/switch at 0/ports has a reg or ranges
property, but no unit name

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree at vger.kernel.org
---
 arch/arm/boot/dts/mt7623.dtsi                 |  4 ++--
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 27 ++++++++++++---------------
 arch/arm/boot/dts/mt7623n-rfb.dtsi            |  2 +-
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 406a9f3..b9b5619 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -124,14 +124,14 @@
 		#clock-cells = <0>;
 	};
 
-	rtc32k: oscillator at 1 {
+	rtc32k: oscillator-1 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32000>;
 		clock-output-names = "rtc32k";
 	};
 
-	clk26m: oscillator at 0 {
+	clk26m: oscillator-0 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <26000000>;
diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index d2a354e..71023a6 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -145,8 +145,6 @@
 
 		switch at 0 {
 			compatible = "mediatek,mt7530";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			reg = <0>;
 			reset-gpios = <&pio 33 0>;
 			core-supply = <&mt6323_vpa_reg>;
@@ -155,7 +153,6 @@
 			ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				reg = <0>;
 
 				port at 0 {
 					reg = <0>;
@@ -259,14 +256,14 @@
 };
 
 &pio {
-	cir_pins_a:cir at 0 {
+	cir_pins_a:cir-default {
 		pins-cir {
 			pinmux = <MT7623_PIN_46_IR_FUNC_IR>;
 			bias-disable;
 		};
 	};
 
-	i2c0_pins_a: i2c at 0 {
+	i2c0_pins_a: i2c0-default {
 		pins-i2c0 {
 			pinmux = <MT7623_PIN_75_SDA0_FUNC_SDA0>,
 				 <MT7623_PIN_76_SCL0_FUNC_SCL0>;
@@ -274,7 +271,7 @@
 		};
 	};
 
-	i2c1_pins_a: i2c at 1 {
+	i2c1_pins_a: i2c1-default {
 		pin-i2c1 {
 			pinmux = <MT7623_PIN_57_SDA1_FUNC_SDA1>,
 				 <MT7623_PIN_58_SCL1_FUNC_SCL1>;
@@ -282,7 +279,7 @@
 		};
 	};
 
-	i2s0_pins_a: i2s at 0 {
+	i2s0_pins_a: i2s0-default {
 		pin-i2s0 {
 			pinmux = <MT7623_PIN_49_I2S0_DATA_FUNC_I2S0_DATA>,
 				 <MT7623_PIN_72_I2S0_DATA_IN_FUNC_I2S0_DATA_IN>,
@@ -294,7 +291,7 @@
 		};
 	};
 
-	i2s1_pins_a: i2s at 1 {
+	i2s1_pins_a: i2s1-default {
 		pin-i2s1 {
 			pinmux = <MT7623_PIN_33_I2S1_DATA_FUNC_I2S1_DATA>,
 				 <MT7623_PIN_34_I2S1_DATA_IN_FUNC_I2S1_DATA_IN>,
@@ -306,7 +303,7 @@
 		};
 	};
 
-	key_pins_a: keys at 0 {
+	key_pins_a: keys-alt {
 		pins-keys {
 			pinmux = <MT7623_PIN_256_GPIO256_FUNC_GPIO256>,
 				 <MT7623_PIN_257_GPIO257_FUNC_GPIO257> ;
@@ -314,7 +311,7 @@
 		};
 	};
 
-	led_pins_a: leds at 0 {
+	led_pins_a: leds-alt {
 		pins-leds {
 			pinmux = <MT7623_PIN_239_EXT_SDIO0_FUNC_GPIO239>,
 				 <MT7623_PIN_240_EXT_XCS_FUNC_GPIO240>,
@@ -433,7 +430,7 @@
 		};
 	};
 
-	pwm_pins_a: pwm at 0 {
+	pwm_pins_a: pwm-default {
 		pins-pwm {
 			pinmux = <MT7623_PIN_203_PWM0_FUNC_PWM0>,
 				 <MT7623_PIN_204_PWM1_FUNC_PWM1>,
@@ -443,7 +440,7 @@
 		};
 	};
 
-	spi0_pins_a: spi at 0 {
+	spi0_pins_a: spi0-default {
 		pins-spi {
 			pinmux = <MT7623_PIN_53_SPI0_CSN_FUNC_SPI0_CS>,
 				<MT7623_PIN_54_SPI0_CK_FUNC_SPI0_CK>,
@@ -453,21 +450,21 @@
 		};
 	};
 
-	uart0_pins_a: uart at 0 {
+	uart0_pins_a: uart0-default {
 		pins-dat {
 			pinmux = <MT7623_PIN_79_URXD0_FUNC_URXD0>,
 				 <MT7623_PIN_80_UTXD0_FUNC_UTXD0>;
 		};
 	};
 
-	uart1_pins_a: uart at 1 {
+	uart1_pins_a: uart1-default {
 		pins-dat {
 			pinmux = <MT7623_PIN_81_URXD1_FUNC_URXD1>,
 				 <MT7623_PIN_82_UTXD1_FUNC_UTXD1>;
 		};
 	};
 
-	uart2_pins_a: uart at 2 {
+	uart2_pins_a: uart2-default {
 		pins-dat {
 			pinmux = <MT7623_PIN_14_GPIO14_FUNC_URXD2>,
 				 <MT7623_PIN_15_GPIO15_FUNC_UTXD2>;
diff --git a/arch/arm/boot/dts/mt7623n-rfb.dtsi b/arch/arm/boot/dts/mt7623n-rfb.dtsi
index 343e8ef..5c5cc7d 100644
--- a/arch/arm/boot/dts/mt7623n-rfb.dtsi
+++ b/arch/arm/boot/dts/mt7623n-rfb.dtsi
@@ -44,7 +44,7 @@
 		reg = <0 0x80000000 0 0x40000000>;
 	};
 
-	usb_p1_vbus: regulator at 0 {
+	usb_p1_vbus: regulator-5v {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_vbus";
 		regulator-min-microvolt = <5000000>;
-- 
2.7.4
