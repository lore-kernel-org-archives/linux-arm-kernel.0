From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Oct 2017 12:49:53 +0200
Subject: [PATCH 18/20] ARM: dts: sun9i: cubieboard4: Remove card detect pull-up
In-Reply-To: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <efb84cd6e7d9685042a1dbeb80a5e89ff123cd7e.1507198895.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board has an external pull-up on the card-detect signal, so there's no
need to add another one.

This also removes a DTC warning.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index 15cc82350360..cb337e08adab 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -85,7 +85,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>, <&mmc0_cd_pin_cubieboard4>;
+	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 18 GPIO_ACTIVE_HIGH>; /* PH18 */
@@ -128,14 +128,6 @@
 	clocks = <&ac100_rtc 0>;
 };
 
-&pio {
-	mmc0_cd_pin_cubieboard4: mmc0_cd_pin at 0 {
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
