From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 27 Feb 2012 17:23:24 +0800
Subject: [PATCH 1/2] ARM: dts: imx6q-arm2: add vmmc-supply for usdhc
Message-ID: <1330334605-568-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6q-arm2.dts |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
index c3977e0..ce1c823 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dts
@@ -36,11 +36,13 @@
 			usdhc at 02198000 { /* uSDHC3 */
 				cd-gpios = <&gpio6 11 0>;
 				wp-gpios = <&gpio6 14 0>;
+				vmmc-supply = <&reg_3p3v>;
 				status = "okay";
 			};
 
 			usdhc at 0219c000 { /* uSDHC4 */
 				fsl,card-wired;
+				vmmc-supply = <&reg_3p3v>;
 				status = "okay";
 			};
 
@@ -50,6 +52,18 @@
 		};
 	};
 
+	regulators {
+		compatible = "simple-bus";
+
+		reg_3p3v: 3p3v {
+			compatible = "regulator-fixed";
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
-- 
1.7.5.4
