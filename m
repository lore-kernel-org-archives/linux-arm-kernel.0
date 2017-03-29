From: stefan@agner.ch (Stefan Agner)
Date: Wed, 29 Mar 2017 16:21:13 -0700
Subject: [PATCH 5/5] ARM: dts: imx7-colibri: add Carrier Board 3.3V/5V
 regulators
In-Reply-To: <20170329232113.19078-1-stefan@agner.ch>
References: <20170329232113.19078-1-stefan@agner.ch>
Message-ID: <20170329232113.19078-5-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Model the Carrier Board power distribution by adding a fixed 3.3V
and 5V regulator. The 3.3V regulator is connected to the backlight
as well as the display supply. The 5V regulator is used to supply
USB VBUS.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 17 +++++++++++++++++
 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts |  1 +
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
index 7a98a45a0d95..18bebd6d8d47 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -48,6 +48,7 @@
 	panel: panel {
 		compatible = "edt,et057090dhu";
 		backlight = <&bl>;
+		power-supply = <&reg_3v3>;
 
 		port {
 			panel_in: endpoint {
@@ -55,11 +56,27 @@
 			};
 		};
 	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_5v0: regulator-5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
 };
 
 &bl {
 	brightness-levels = <0 4 8 16 32 64 128 255>;
 	default-brightness-level = <6>;
+	power-supply = <&reg_3v3>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts b/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
index bd01d2cc642d..a608a14d8c85 100644
--- a/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
@@ -57,6 +57,7 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		gpio = <&gpio4 7 GPIO_ACTIVE_LOW>;
+		vin-supply = <&reg_5v0>;
 	};
 };
 
-- 
2.12.1
