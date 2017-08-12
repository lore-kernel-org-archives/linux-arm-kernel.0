From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Sat, 12 Aug 2017 11:10:02 +0530
Subject: [PATCH] arm64: allwinner: a64: pine64: Use dcdc1 regulator for mmc0
Message-ID: <1502516402-4661-1-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Since current tree support AXP803 regulators, replace
fixed regulator with AXP803 dcdc1 regulator.

Tested on pine64.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 122b5d8..604cdae 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -62,13 +62,6 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
-
-	reg_vcc3v3: vcc3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
 };
 
 &ehci0 {
@@ -109,7 +102,7 @@
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
-	vmmc-supply = <&reg_vcc3v3>;
+	vmmc-supply = <&reg_dcdc1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
 	cd-inverted;
 	disable-wp;
-- 
2.7.4
