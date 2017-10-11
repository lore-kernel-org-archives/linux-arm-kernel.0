From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 11 Oct 2017 13:07:37 +0200
Subject: [PATCH 3/7] ARM: dts: imx53-tx53: remove obsolete eeti,egalax_ts
In-Reply-To: <1507720061-27666-1-git-send-email-LW@KARO-electronics.de>
References: <1507720061-27666-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1507720061-27666-4-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The display, that incorporates this touchpanel is obsolete and won't
be supported any more.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx53-tx53-x13x.dts | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-tx53-x13x.dts b/arch/arm/boot/dts/imx53-tx53-x13x.dts
index 0d17c80..e21bc91 100644
--- a/arch/arm/boot/dts/imx53-tx53-x13x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x13x.dts
@@ -120,23 +120,6 @@
 	};
 };
 
-&i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
-
-	touchscreen2: eeti at 04 {
-		compatible = "eeti,egalax_ts";
-		reg = <0x04>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_eeti2>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <23 0>;
-		wakeup-gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
-		wakeup-source;
-	};
-};
-
 &i2c3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c3>;
@@ -149,28 +132,10 @@
 		VDDIO-supply = <&reg_3v3>;
 		clocks = <&mclk>;
 	};
-
-	touchscreen1: eeti at 04 {
-		compatible = "eeti,egalax_ts";
-		reg = <0x04>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_eeti1>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <22 0>;
-		wakeup-gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
-		wakeup-source;
-	};
 };
 
 &iomuxc {
 	imx53-tx53-x13x {
-		pinctrl_i2c2: i2c2-grp1 {
-			fsl,pins = <
-				MX53_PAD_KEY_ROW3__I2C2_SDA		0xc0000000
-				MX53_PAD_KEY_COL3__I2C2_SCL		0xc0000000
-			>;
-		};
-
 		pinctrl_lvds0: lvds0grp {
 			fsl,pins = <
 				MX53_PAD_LVDS0_TX3_P__LDB_LVDS0_TX3 0x80000000
-- 
2.1.4
