From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Sun,  6 Jul 2014 01:05:16 -0300
Subject: [PATCH v2 9/8] ARM: sun4i: cubieboard: add an SPIdev device for
 testing
In-Reply-To: <1404619518-7592-1-git-send-email-emilio@elopez.com.ar>
References: <1404619518-7592-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1404619518-7592-10-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts | 12 ++++++++++++
 arch/arm/boot/dts/sun4i-a10.dtsi           |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index c200eac..c7a4c4e 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -71,6 +71,18 @@
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
index 56d02af..63c0ff6 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -585,6 +585,13 @@
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
2.0.1
