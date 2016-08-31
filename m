From: jorik@kippendief.biz (jorik at kippendief.biz)
Date: Wed, 31 Aug 2016 21:30:53 +0200
Subject: [PATCH v2 2/7] dts: sun8i-h3: add pinmux definitions for i2c0/i2c1
In-Reply-To: <1472671858-29220-1-git-send-email-jorik@kippendief.biz>
References: <1472671858-29220-1-git-send-email-jorik@kippendief.biz>
Message-ID: <1472671858-29220-3-git-send-email-jorik@kippendief.biz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jorik Jonker <jorik@kippendief.biz>

This adds proper pinmux definitions for i2c0 and i2c1. Although H3 has a third
i2c controller, these are not exposed on my boards. If someone actually has a
H3 board with an exposed i2c2, they could add the third.

Signed-off-by: Jorik Jonker <jorik@kippendief.biz>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 7740748..0637b95 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -327,6 +327,20 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			i2c0_pins_a: i2c0 at 0 {
+				allwinner,pins = "PA11", "PA12";
+				allwinner,function = "i2c0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			i2c1_pins_a: i2c1 at 0 {
+				allwinner,pins = "PA18", "PA19";
+				allwinner,function = "i2c1";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
 			mmc0_pins_a: mmc0 at 0 {
 				allwinner,pins = "PF0", "PF1", "PF2", "PF3",
 						 "PF4", "PF5";
-- 
2.7.4
