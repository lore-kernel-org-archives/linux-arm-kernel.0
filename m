From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 16 Jun 2014 00:50:34 -0300
Subject: [PATCH 09/10] ARM: sun4i: cubieboard: add an SPIdev device for testing
In-Reply-To: <1402890635-12342-1-git-send-email-emilio@elopez.com.ar>
References: <1402890635-12342-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1402890635-12342-10-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts | 12 ++++++++++++
 arch/arm/boot/dts/sun4i-a10.dtsi           |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index 4684cbe..9b8d6b0 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -61,6 +61,18 @@
 			status = "okay";
 		};
 
+		spi0: spi at 01c05000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi0_pins_a>;
+			status = "okay";
+
+			dac0: dh2228 at 2 {
+				compatible = "rohm,dh2228fv";
+				reg = <2>;
+				spi-max-frequency = <100000>;
+			};
+		};
+
 		pinctrl at 01c20800 {
 			led_pins_cubieboard: led_pins at 0 {
 				allwinner,pins = "PH20", "PH21";
diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index c66c39e..aefde20 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -535,6 +535,13 @@
 				allwinner,pull = <0>;
 			};
 
+			spi0_pins_a: spi0 at 0 {
+				allwinner,pins = "PI10", "PI11", "PI12", "PI13";
+				allwinner,function = "spi0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			emac_pins_a: emac0 at 0 {
 				allwinner,pins = "PA0", "PA1", "PA2",
 						"PA3", "PA4", "PA5", "PA6",
-- 
2.0.0
