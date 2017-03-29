From: stefan@agner.ch (Stefan Agner)
Date: Wed, 29 Mar 2017 16:21:12 -0700
Subject: [PATCH 4/5] ARM: dts: imx7-colibri: remove 1.8V fixed regulator
In-Reply-To: <20170329232113.19078-1-stefan@agner.ch>
References: <20170329232113.19078-1-stefan@agner.ch>
Message-ID: <20170329232113.19078-4-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ADC is directly supplied by the PMIC 1.8V rail, remove the
superfluous fixed regulator.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx7-colibri.dtsi | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index cbcab937b905..2d87489f9105 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -60,13 +60,6 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
-	reg_vref_1v8: regulator-vref-1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "vref-1v8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
 	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "imx7-sgtl5000";
@@ -85,11 +78,11 @@
 };
 
 &adc1 {
-	vref-supply = <&reg_vref_1v8>;
+	vref-supply = <&reg_DCDC3>;
 };
 
 &adc2 {
-	vref-supply = <&reg_vref_1v8>;
+	vref-supply = <&reg_DCDC3>;
 };
 
 &cpu0 {
-- 
2.12.1
