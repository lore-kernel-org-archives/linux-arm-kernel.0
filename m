From: jorik@kippendief.biz (jorik at kippendief.biz)
Date: Mon, 12 Sep 2016 20:12:46 +0200
Subject: [PATCH v5 4/5] dts: sun8i-h3: add pinmux definitions for I2C0-2
In-Reply-To: <1473703967-21356-1-git-send-email-jorik@kippendief.biz>
References: <1473703967-21356-1-git-send-email-jorik@kippendief.biz>
Message-ID: <1473703967-21356-5-git-send-email-jorik@kippendief.biz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jorik Jonker <jorik@kippendief.biz>

These are the only possible pins for these peripherals according to the
datasheet.

Signed-off-by: Jorik Jonker <jorik@kippendief.biz>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 742bced..ed6628d 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -327,6 +327,27 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			i2c0_pins: i2c0 {
+				allwinner,pins = "PA11", "PA12";
+				allwinner,function = "i2c0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			i2c1_pins: i2c1 {
+				allwinner,pins = "PA18", "PA19";
+				allwinner,function = "i2c1";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			i2c2_pins: i2c2 {
+				allwinner,pins = "PE12", "PE13";
+				allwinner,function = "i2c2";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
 			mmc0_pins_a: mmc0 at 0 {
 				allwinner,pins = "PF0", "PF1", "PF2", "PF3",
 						 "PF4", "PF5";
-- 
2.7.4
