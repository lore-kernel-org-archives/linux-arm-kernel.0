From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 19 Mar 2014 14:28:38 +0100
Subject: [PATCH 2/5] ARM: dts: tx53: sort the i2c subnodes by I2C address
In-Reply-To: <1395235721-13847-1-git-send-email-LW@KARO-electronics.de>
References: <1395235721-13847-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1395235721-13847-2-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx53-tx53-x13x.dts |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-tx53-x13x.dts b/arch/arm/boot/dts/imx53-tx53-x13x.dts
index c8a3473..cd3476b 100644
--- a/arch/arm/boot/dts/imx53-tx53-x13x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x13x.dts
@@ -108,14 +108,6 @@
 	pinctrl-0 = <&pinctrl_i2c3>;
 	status = "okay";
 
-	sgtl5000: codec at 0a {
-		compatible = "fsl,sgtl5000";
-		reg = <0x0a>;
-		VDDA-supply = <&reg_2v5>;
-		VDDIO-supply = <&reg_3v3>;
-		clocks = <&mclk>;
-	};
-
 	touchscreen1: eeti at 04 {
 		compatible = "eeti,egalax_ts";
 		reg = <0x04>;
@@ -126,6 +118,14 @@
 		wakeup-gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
 		linux,wakeup;
 	};
+
+	sgtl5000: codec at 0a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		VDDA-supply = <&reg_2v5>;
+		VDDIO-supply = <&reg_3v3>;
+		clocks = <&mclk>;
+	};
 };
 
 &iomuxc {
-- 
1.7.10.4
