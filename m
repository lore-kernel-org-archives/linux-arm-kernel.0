From: smoch@web.de (Soeren Moch)
Date: Sun,  7 Feb 2016 19:34:33 +0100
Subject: [PATCH 4/4] ARM: dts: imx6q-tbs2910: remove artificial simple-bus for
 regulators
In-Reply-To: <1454870073-6506-1-git-send-email-smoch@web.de>
References: <1454870073-6506-1-git-send-email-smoch@web.de>
Message-ID: <1454870073-6506-4-git-send-email-smoch@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Soeren Moch <smoch@web.de>
---
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/boot/dts/imx6q-tbs2910.dts | 43 +++++++++++++++----------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-tbs2910.dts b/arch/arm/boot/dts/imx6q-tbs2910.dts
index b9afafc..0da81bc 100644
--- a/arch/arm/boot/dts/imx6q-tbs2910.dts
+++ b/arch/arm/boot/dts/imx6q-tbs2910.dts
@@ -91,34 +91,25 @@
 		};
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
+	reg_2p5v: regulator-2p5v {
+		compatible = "regulator-fixed";
+		regulator-name = "2P5V";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+	};
 
-		reg_3p3v: regulator at 1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "3P3V";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-		};
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 
-		reg_5p0v: regulator at 2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "5P0V";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-		};
+	reg_5p0v: regulator-5p0v {
+		compatible = "regulator-fixed";
+		regulator-name = "5P0V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
 	};
 
 	sound-sgtl5000 {
-- 
1.9.1
