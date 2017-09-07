From: jbe@pengutronix.de (Juergen Borleis)
Date: Thu,  7 Sep 2017 11:05:22 +0200
Subject: [PATCH 1/9] ARM: dts: TQma53: regulators are no bus
In-Reply-To: <20170907090530.1241-1-jbe@pengutronix.de>
References: <20170907090530.1241-1-jbe@pengutronix.de>
Message-ID: <20170907090530.1241-2-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 arch/arm/boot/dts/imx53-mba53.dts   | 33 +++++++++++++--------------------
 arch/arm/boot/dts/imx53-tqma53.dtsi | 19 ++++++-------------
 2 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index df705ba48897f..11c61844d5d85 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -44,27 +44,20 @@
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_backlight: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "lcd-supply";
-			gpio = <&gpio2 5 0>;
-			startup-delay-us = <5000>;
-		};
 
-		reg_3p2v: regulator at 1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "3P2V";
-			regulator-min-microvolt = <3200000>;
-			regulator-max-microvolt = <3200000>;
-			regulator-always-on;
-		};
+	reg_backlight: backlight {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd-supply";
+		gpio = <&gpio2 5 0>;
+		startup-delay-us = <5000>;
+	};
+
+	reg_3p2v: base3p2v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P2V";
+		regulator-min-microvolt = <3200000>;
+		regulator-max-microvolt = <3200000>;
+		regulator-always-on;
 	};
 
 	sound {
diff --git a/arch/arm/boot/dts/imx53-tqma53.dtsi b/arch/arm/boot/dts/imx53-tqma53.dtsi
index eecdc1c55eefc..4aff91e31f288 100644
--- a/arch/arm/boot/dts/imx53-tqma53.dtsi
+++ b/arch/arm/boot/dts/imx53-tqma53.dtsi
@@ -20,19 +20,12 @@
 		reg = <0x70000000 0x40000000>; /* Up to 1GiB */
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_3p3v: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "3P3V";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
+	reg_3p3v: card3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
 	};
 };
 
-- 
2.11.0
