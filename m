From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Oct 2017 12:49:52 +0200
Subject: [PATCH 17/20] ARM: dts: sun9i: optimus: Remove card detect pull-up
In-Reply-To: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <62c6ed04912e6b3ea3f7e37a09d0e102033b00e6.1507198895.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board has an external pull-up on the card-detect signal, so there's no
need to add another one.

This also removes a DTC warning.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 199777e1c5ea..ba62e814f4b8 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -122,7 +122,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>, <&mmc0_cd_pin_optimus>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 18 GPIO_ACTIVE_HIGH>; /* PH8 */
@@ -173,14 +173,6 @@
 	clocks = <&ac100_rtc 0>;
 };
 
-&pio {
-	mmc0_cd_pin_optimus: mmc0_cd_pin at 0 {
-		pins = "PH18";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-};
-
 &r_ir {
 	status = "okay";
 };
-- 
git-series 0.9.1
