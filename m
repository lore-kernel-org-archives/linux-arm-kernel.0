From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  7 Oct 2016 00:06:26 +0800
Subject: [PATCH 6/9] ARM: dts: sun6i: Sort pinmux setting nodes
In-Reply-To: <20161006160629.11198-1-wens@csie.org>
References: <20161006160629.11198-1-wens@csie.org>
Message-ID: <20161006160629.11198-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pinmux setting nodes for the A31 were added out of alphabetical
order. Sort them.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 82 ++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index ce1960453a0b..c1b891e75f18 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -434,13 +434,48 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
-			uart0_pins_a: uart0 at 0 {
-				allwinner,pins = "PH20", "PH21";
-				allwinner,function = "uart0";
+			gmac_pins_gmii_a: gmac_gmii at 0 {
+				allwinner,pins = "PA0", "PA1", "PA2", "PA3",
+						"PA4", "PA5", "PA6", "PA7",
+						"PA8", "PA9", "PA10", "PA11",
+						"PA12", "PA13", "PA14",	"PA15",
+						"PA16", "PA17", "PA18", "PA19",
+						"PA20", "PA21", "PA22", "PA23",
+						"PA24", "PA25", "PA26", "PA27";
+				allwinner,function = "gmac";
+				/*
+				 * data lines in GMII mode run at 125MHz and
+				 * might need a higher signal drive strength
+				 */
+				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			gmac_pins_mii_a: gmac_mii at 0 {
+				allwinner,pins = "PA0", "PA1", "PA2", "PA3",
+						"PA8", "PA9", "PA11",
+						"PA12", "PA13", "PA14", "PA19",
+						"PA20", "PA21", "PA22", "PA23",
+						"PA24", "PA26", "PA27";
+				allwinner,function = "gmac";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
+			gmac_pins_rgmii_a: gmac_rgmii at 0 {
+				allwinner,pins = "PA0", "PA1", "PA2", "PA3",
+						"PA9", "PA10", "PA11",
+						"PA12", "PA13", "PA14", "PA19",
+						"PA20", "PA25", "PA26", "PA27";
+				allwinner,function = "gmac";
+				/*
+				 * data lines in RGMII mode use DDR mode
+				 * and need a higher signal drive strength
+				 */
+				allwinner,drive = <SUN4I_PINCTRL_40_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
 			i2c0_pins_a: i2c0 at 0 {
 				allwinner,pins = "PH14", "PH15";
 				allwinner,function = "i2c0";
@@ -506,47 +541,12 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			gmac_pins_mii_a: gmac_mii at 0 {
-				allwinner,pins = "PA0", "PA1", "PA2", "PA3",
-						"PA8", "PA9", "PA11",
-						"PA12", "PA13", "PA14", "PA19",
-						"PA20", "PA21", "PA22", "PA23",
-						"PA24", "PA26", "PA27";
-				allwinner,function = "gmac";
+			uart0_pins_a: uart0 at 0 {
+				allwinner,pins = "PH20", "PH21";
+				allwinner,function = "uart0";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
-
-			gmac_pins_gmii_a: gmac_gmii at 0 {
-				allwinner,pins = "PA0", "PA1", "PA2", "PA3",
-						"PA4", "PA5", "PA6", "PA7",
-						"PA8", "PA9", "PA10", "PA11",
-						"PA12", "PA13", "PA14",	"PA15",
-						"PA16", "PA17", "PA18", "PA19",
-						"PA20", "PA21", "PA22", "PA23",
-						"PA24", "PA25", "PA26", "PA27";
-				allwinner,function = "gmac";
-				/*
-				 * data lines in GMII mode run at 125MHz and
-				 * might need a higher signal drive strength
-				 */
-				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			gmac_pins_rgmii_a: gmac_rgmii at 0 {
-				allwinner,pins = "PA0", "PA1", "PA2", "PA3",
-						"PA9", "PA10", "PA11",
-						"PA12", "PA13", "PA14", "PA19",
-						"PA20", "PA25", "PA26", "PA27";
-				allwinner,function = "gmac";
-				/*
-				 * data lines in RGMII mode use DDR mode
-				 * and need a higher signal drive strength
-				 */
-				allwinner,drive = <SUN4I_PINCTRL_40_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
 		};
 
 		timer at 01c20c00 {
-- 
2.9.3
