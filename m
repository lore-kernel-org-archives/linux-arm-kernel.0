From: akurz@blala.de (Alexander Kurz)
Date: Tue, 29 May 2018 06:20:19 +0000
Subject: [PATCH v2 2/4] ARM: dts: imx6dl-riotboard: remove regulators bus node
In-Reply-To: <20180529062021.3154-1-akurz@blala.de>
References: <20180529062021.3154-1-akurz@blala.de>
Message-ID: <20180529062021.3154-3-akurz@blala.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To match the convention, move regulator-fixed nodes directly into
the root node.

Signed-off-by: Alexander Kurz <akurz@blala.de>
---
 arch/arm/boot/dts/imx6dl-riotboard.dts | 55 ++++++++++++++--------------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-riotboard.dts b/arch/arm/boot/dts/imx6dl-riotboard.dts
index 2e98c92adff7..a6851bfebbdb 100644
--- a/arch/arm/boot/dts/imx6dl-riotboard.dts
+++ b/arch/arm/boot/dts/imx6dl-riotboard.dts
@@ -19,38 +19,6 @@
 		reg = <0x10000000 0x40000000>;
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_2p5v: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "2P5V";
-			regulator-min-microvolt = <2500000>;
-			regulator-max-microvolt = <2500000>;
-		};
-
-		reg_3p3v: regulator at 1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "3P3V";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-		};
-
-		reg_usb_otg_vbus: regulator at 2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "usb_otg_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio3 22 0>;
-			enable-active-high;
-		};
-	};
-
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -82,6 +50,29 @@
 			mux-int-port = <1>;
 			mux-ext-port = <3>;
 	};
+
+	reg_2p5v: regulator-2p5v {
+		compatible = "regulator-fixed";
+		regulator-name = "2P5V";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_usb_otg_vbus: regulator-usbotgvbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 &audmux {
-- 
2.11.0
