From: akurz@blala.de (Alexander Kurz)
Date: Tue, 29 May 2018 06:20:18 +0000
Subject: [PATCH v2 1/4] ARM: dts: imx6qdl-wandboard: remove regulators bus node
In-Reply-To: <20180529062021.3154-1-akurz@blala.de>
References: <20180529062021.3154-1-akurz@blala.de>
Message-ID: <20180529062021.3154-2-akurz@blala.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To match the convention, move all regulator-fixed nodes directly into
the root node.

Signed-off-by: Alexander Kurz <akurz@blala.de>
---
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi | 40 +++++++++++++-------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index ed96d7b5feab..b9c6c9d5d357 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -12,30 +12,6 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
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
-			regulator-always-on;
-		};
-
-		reg_3p3v: regulator at 1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "3P3V";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
-	};
-
 	sound {
 		compatible = "fsl,imx6-wandboard-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
@@ -56,6 +32,22 @@
 		spdif-controller = <&spdif>;
 		spdif-out;
 	};
+
+	reg_2p5v: regulator-2p5v {
+		compatible = "regulator-fixed";
+		regulator-name = "2P5V";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 };
 
 &audmux {
-- 
2.11.0
