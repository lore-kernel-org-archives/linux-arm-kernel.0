From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  7 Dec 2013 01:29:41 +0800
Subject: [PATCH 08/10] ARM: dts: sun7i: cubieboard2: Enable GMAC instead of
 EMAC
In-Reply-To: <1386350983-13281-1-git-send-email-wens@csie.org>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
Message-ID: <1386350983-13281-9-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GMAC has better performance and fewer hardware issues.
Use the GMAC in MII mode for ethernet instead of the EMAC.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 5c51cb8..9ef5848 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -19,21 +19,6 @@
 	compatible = "cubietech,cubieboard2", "allwinner,sun7i-a20";
 
 	soc at 01c00000 {
-		emac: ethernet at 01c0b000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&emac_pins_a>;
-			phy = <&phy1>;
-			status = "okay";
-		};
-
-		mdio at 01c0b080 {
-			status = "okay";
-
-			phy1: ethernet-phy at 1 {
-				reg = <1>;
-			};
-		};
-
 		pinctrl at 01c20800 {
 			led_pins_cubieboard2: led_pins at 0 {
 				allwinner,pins = "PH20", "PH21";
@@ -60,6 +45,14 @@
 			pinctrl-0 = <&i2c1_pins_a>;
 			status = "okay";
 		};
+
+		gmac: ethernet at 01c50000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&gmac_pins_mii>;
+			snps,phy-addr = <1>;
+			phy-mode = "mii";
+			status = "okay";
+		};
 	};
 
 	leds {
-- 
1.8.5.1
