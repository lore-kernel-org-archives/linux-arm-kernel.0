From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:17 +0100
Subject: [PATCH 16/77] ARM: dts: sun5i: Remove underscores from nodes names
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <afe95c2d468c0ea61ea6f04cb8689115872a5c42.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some GPIO pinctrl nodes cannot be easily removed, because they would also
change the pin configuration, for example to add a pull resistor or change
the current delivered by the pin.

Those nodes still have underscores and unit-addresses in their node names
in our DTs, so adjust their name to remove the warnings. Use that occasion
to also fix some poorly chosen node-names.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts | 2 +-
 arch/arm/boot/dts/sun5i-r8-chip.dts      | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
index 31a4b61f1d75..abc8402fe04e 100644
--- a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
+++ b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
@@ -58,7 +58,7 @@
 		/delete-property/stdout-path;
 	};
 
-	i2c_lcd: i2c at 0 {
+	i2c_lcd: i2c-gpio {
 		/* The lcd panel i2c interface is hooked up via gpios */
 		compatible = "i2c-gpio";
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
index a913084c8d20..3c9f4f35d43b 100644
--- a/arch/arm/boot/dts/sun5i-r8-chip.dts
+++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
@@ -182,8 +182,7 @@
 };
 
 &pio {
-
-	chip_w1_pin: chip_w1_pin at 0 {
+	chip_w1_pin: chip-w1-pin {
 		pins = "PD2";
 		function = "gpio_in";
 	        bias-pull-up;
-- 
git-series 0.9.1
