From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  1 Feb 2016 22:59:58 +0800
Subject: [PATCH] ARM: dts: sun9i: a80-optimus: Remove i2c3 and uart4
Message-ID: <1454338798-5929-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i2c3 and uart4 are available on the GPIO header. Though these pins only
have this one special function, the user may choose to use them as GPIOs
instead.

Since our policy is not to choose what function to present on the GPIO
headers of development boards, remove them.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 958160e40fd0..d7a20d92b114 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -109,17 +109,6 @@
 	status = "okay";
 };
 
-&i2c3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c3_pins_a>;
-	status = "okay";
-};
-
-&i2c3_pins_a {
-	/* Enable internal pull-up */
-	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-};
-
 &ohci0 {
 	status = "okay";
 };
@@ -212,17 +201,6 @@
 	status = "okay";
 };
 
-&uart4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart4_pins_a>;
-	status = "okay";
-};
-
-&uart4_pins_a {
-	/* Enable internal pull-up */
-	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-};
-
 &usbphy1 {
 	phy-supply = <&reg_usb1_vbus>;
 	status = "okay";
-- 
2.7.0
