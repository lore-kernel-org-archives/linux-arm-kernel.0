From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 15 Aug 2014 07:19:10 +0900
Subject: [PATCH] ARM: shmobile: koelsch: Remove non-existent i2c6 pinmux
Message-ID: <1408054750-9642-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

On r8a7791, i2c6 (aka iic3) doesn't need pinmux, but the koelsch dts
refers to non-existent pinmux configuration data:

pinmux core: sh-pfc does not support function i2c6
sh-pfc e6060000.pfc: invalid function i2c6 in map table

Remove it to fix this.

Fixes: commit 1d41f36a68c0f4e9b01d563ce33bab5201858b54 ("ARM: shmobile:
       koelsch dts: Add VDD MPU regulator for DVFS")

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 7 -------
 1 file changed, 7 deletions(-)

Hi Olof, Arnd, Kevin,

please consider this as a fix for v3.17.

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 23486c0..be59014 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -275,11 +275,6 @@
 		renesas,function = "msiof0";
 	};
 
-	i2c6_pins: i2c6 {
-		renesas,groups = "i2c6";
-		renesas,function = "i2c6";
-	};
-
 	usb0_pins: usb0 {
 		renesas,groups = "usb0";
 		renesas,function = "usb0";
@@ -420,8 +415,6 @@
 };
 
 &i2c6 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c6_pins>;
 	status = "okay";
 	clock-frequency = <100000>;
 
-- 
2.0.1
