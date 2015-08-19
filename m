From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 19 Aug 2015 16:57:22 +0800
Subject: [PATCH] ARM: dts: sun6i: hummingbird: Add missing pinmux setting for
 gmac phy reset
Message-ID: <1439974642-12091-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index d0cfadac0691..06d9391ca30e 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -73,7 +73,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_rgmii_a>;
+	pinctrl-0 = <&gmac_pins_rgmii_a>, <&gmac_phy_reset_pin_hummingbird>;
 	phy = <&phy1>;
 	phy-mode = "rgmii";
 	snps,reset-gpio = <&pio 0 21 GPIO_ACTIVE_HIGH>;
@@ -146,6 +146,13 @@
 };
 
 &pio {
+	gmac_phy_reset_pin_hummingbird: gmac_phy_reset_pin at 0 {
+		allwinner,pins = "PA21";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
 	mmc0_cd_pin_hummingbird: mmc0_cd_pin at 0 {
 		allwinner,pins = "PA8";
 		allwinner,function = "gpio_in";
-- 
2.5.0
