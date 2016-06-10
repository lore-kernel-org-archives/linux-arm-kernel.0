From: mamlinav@gmail.com (Aleksei Mamlin)
Date: Fri, 10 Jun 2016 11:05:19 +0300
Subject: [PATCH 2/2] ARM: dts: sun7i: Re-order pinctrl nodes alphabetically
In-Reply-To: <1465545919-24270-1-git-send-email-mamlinav@gmail.com>
References: <1465545919-24270-1-git-send-email-mamlinav@gmail.com>
Message-ID: <1465545919-24270-3-git-send-email-mamlinav@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No functional change. Re-order sun7i pinctrl nodes alphabetically.

Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 284 +++++++++++++++++++--------------------
 1 file changed, 142 insertions(+), 142 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 82e28c3..de4231e 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1030,160 +1030,177 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
-			pwm0_pins_a: pwm0 at 0 {
-				allwinner,pins = "PB2";
-				allwinner,function = "pwm";
+			clk_out_a_pins_a: clk_out_a at 0 {
+				allwinner,pins = "PI12";
+				allwinner,function = "clk_out_a";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			pwm1_pins_a: pwm1 at 0 {
-				allwinner,pins = "PI3";
-				allwinner,function = "pwm";
+			clk_out_b_pins_a: clk_out_b at 0 {
+				allwinner,pins = "PI13";
+				allwinner,function = "clk_out_b";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			uart0_pins_a: uart0 at 0 {
-				allwinner,pins = "PB22", "PB23";
-				allwinner,function = "uart0";
+			emac_pins_a: emac0 at 0 {
+				allwinner,pins = "PA0", "PA1", "PA2",
+						"PA3", "PA4", "PA5", "PA6",
+						"PA7", "PA8", "PA9", "PA10",
+						"PA11", "PA12", "PA13", "PA14",
+						"PA15", "PA16";
+				allwinner,function = "emac";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			uart2_pins_a: uart2 at 0 {
-				allwinner,pins = "PI16", "PI17", "PI18", "PI19";
-				allwinner,function = "uart2";
+			gmac_pins_mii_a: gmac_mii at 0 {
+				allwinner,pins = "PA0", "PA1", "PA2",
+						"PA3", "PA4", "PA5", "PA6",
+						"PA7", "PA8", "PA9", "PA10",
+						"PA11", "PA12", "PA13", "PA14",
+						"PA15", "PA16";
+				allwinner,function = "gmac";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			uart3_pins_a: uart3 at 0 {
-				allwinner,pins = "PG6", "PG7", "PG8", "PG9";
-				allwinner,function = "uart3";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+			gmac_pins_rgmii_a: gmac_rgmii at 0 {
+				allwinner,pins = "PA0", "PA1", "PA2",
+						"PA3", "PA4", "PA5", "PA6",
+						"PA7", "PA8", "PA10",
+						"PA11", "PA12", "PA13",
+						"PA15", "PA16";
+				allwinner,function = "gmac";
+				/*
+				 * data lines in RGMII mode use DDR mode
+				 * and need a higher signal drive strength
+				 */
+				allwinner,drive = <SUN4I_PINCTRL_40_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			uart3_pins_b: uart3 at 1 {
-				allwinner,pins = "PH0", "PH1";
-				allwinner,function = "uart3";
+			i2c0_pins_a: i2c0 at 0 {
+				allwinner,pins = "PB0", "PB1";
+				allwinner,function = "i2c0";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			uart4_pins_a: uart4 at 0 {
-				allwinner,pins = "PG10", "PG11";
-				allwinner,function = "uart4";
+			i2c1_pins_a: i2c1 at 0 {
+				allwinner,pins = "PB18", "PB19";
+				allwinner,function = "i2c1";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			uart4_pins_b: uart4 at 1 {
-				allwinner,pins = "PH4", "PH5";
-				allwinner,function = "uart4";
+			i2c2_pins_a: i2c2 at 0 {
+				allwinner,pins = "PB20", "PB21";
+				allwinner,function = "i2c2";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			uart5_pins_a: uart5 at 0 {
-				allwinner,pins = "PI10", "PI11";
-				allwinner,function = "uart5";
+			i2c3_pins_a: i2c3 at 0 {
+				allwinner,pins = "PI0", "PI1";
+				allwinner,function = "i2c3";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			uart6_pins_a: uart6 at 0 {
-				allwinner,pins = "PI12", "PI13";
-				allwinner,function = "uart6";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			ir0_rx_pins_a: ir0 at 0 {
+				    allwinner,pins = "PB4";
+				    allwinner,function = "ir0";
+				    allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				    allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			uart7_pins_a: uart7 at 0 {
-				allwinner,pins = "PI20", "PI21";
-				allwinner,function = "uart7";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			ir0_tx_pins_a: ir0 at 1 {
+				    allwinner,pins = "PB3";
+				    allwinner,function = "ir0";
+				    allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				    allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			i2c0_pins_a: i2c0 at 0 {
-				allwinner,pins = "PB0", "PB1";
-				allwinner,function = "i2c0";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			ir1_rx_pins_a: ir1 at 0 {
+				    allwinner,pins = "PB23";
+				    allwinner,function = "ir1";
+				    allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				    allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			i2c1_pins_a: i2c1 at 0 {
-				allwinner,pins = "PB18", "PB19";
-				allwinner,function = "i2c1";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			ir1_tx_pins_a: ir1 at 1 {
+				    allwinner,pins = "PB22";
+				    allwinner,function = "ir1";
+				    allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				    allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			i2c2_pins_a: i2c2 at 0 {
-				allwinner,pins = "PB20", "PB21";
-				allwinner,function = "i2c2";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+			mmc0_pins_a: mmc0 at 0 {
+				allwinner,pins = "PF0", "PF1", "PF2",
+						 "PF3", "PF4", "PF5";
+				allwinner,function = "mmc0";
+				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			i2c3_pins_a: i2c3 at 0 {
-				allwinner,pins = "PI0", "PI1";
-				allwinner,function = "i2c3";
+			mmc0_cd_pin_reference_design: mmc0_cd_pin at 0 {
+				allwinner,pins = "PH1";
+				allwinner,function = "gpio_in";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+			};
+
+			mmc2_pins_a: mmc2 at 0 {
+				allwinner,pins = "PC6", "PC7", "PC8",
+						 "PC9", "PC10", "PC11";
+				allwinner,function = "mmc2";
+				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+			};
+
+			mmc3_pins_a: mmc3 at 0 {
+				allwinner,pins = "PI4", "PI5", "PI6",
+						 "PI7", "PI8", "PI9";
+				allwinner,function = "mmc3";
+				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			emac_pins_a: emac0 at 0 {
-				allwinner,pins = "PA0", "PA1", "PA2",
-						"PA3", "PA4", "PA5", "PA6",
-						"PA7", "PA8", "PA9", "PA10",
-						"PA11", "PA12", "PA13", "PA14",
-						"PA15", "PA16";
-				allwinner,function = "emac";
+			ps20_pins_a: ps20 at 0 {
+				allwinner,pins = "PI20", "PI21";
+				allwinner,function = "ps2";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			clk_out_a_pins_a: clk_out_a at 0 {
-				allwinner,pins = "PI12";
-				allwinner,function = "clk_out_a";
+			ps21_pins_a: ps21 at 0 {
+				allwinner,pins = "PH12", "PH13";
+				allwinner,function = "ps2";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			clk_out_b_pins_a: clk_out_b at 0 {
-				allwinner,pins = "PI13";
-				allwinner,function = "clk_out_b";
+			pwm0_pins_a: pwm0 at 0 {
+				allwinner,pins = "PB2";
+				allwinner,function = "pwm";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			gmac_pins_mii_a: gmac_mii at 0 {
-				allwinner,pins = "PA0", "PA1", "PA2",
-						"PA3", "PA4", "PA5", "PA6",
-						"PA7", "PA8", "PA9", "PA10",
-						"PA11", "PA12", "PA13", "PA14",
-						"PA15", "PA16";
-				allwinner,function = "gmac";
+			pwm1_pins_a: pwm1 at 0 {
+				allwinner,pins = "PI3";
+				allwinner,function = "pwm";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			gmac_pins_rgmii_a: gmac_rgmii at 0 {
-				allwinner,pins = "PA0", "PA1", "PA2",
-						"PA3", "PA4", "PA5", "PA6",
-						"PA7", "PA8", "PA10",
-						"PA11", "PA12", "PA13",
-						"PA15", "PA16";
-				allwinner,function = "gmac";
-				/*
-				 * data lines in RGMII mode use DDR mode
-				 * and need a higher signal drive strength
-				 */
-				allwinner,drive = <SUN4I_PINCTRL_40_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			spdif_tx_pins_a: spdif at 0 {
+				allwinner,pins = "PB13";
+				allwinner,function = "spdif";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 			};
 
 			spi0_pins_a: spi0 at 0 {
@@ -1249,84 +1266,67 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			mmc0_pins_a: mmc0 at 0 {
-				allwinner,pins = "PF0", "PF1", "PF2",
-						 "PF3", "PF4", "PF5";
-				allwinner,function = "mmc0";
-				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
+			uart0_pins_a: uart0 at 0 {
+				allwinner,pins = "PB22", "PB23";
+				allwinner,function = "uart0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			mmc0_cd_pin_reference_design: mmc0_cd_pin at 0 {
-				allwinner,pins = "PH1";
-				allwinner,function = "gpio_in";
+			uart2_pins_a: uart2 at 0 {
+				allwinner,pins = "PI16", "PI17", "PI18", "PI19";
+				allwinner,function = "uart2";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-			};
-
-			mmc2_pins_a: mmc2 at 0 {
-				allwinner,pins = "PC6", "PC7", "PC8",
-						 "PC9", "PC10", "PC11";
-				allwinner,function = "mmc2";
-				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-			};
-
-			mmc3_pins_a: mmc3 at 0 {
-				allwinner,pins = "PI4", "PI5", "PI6",
-						 "PI7", "PI8", "PI9";
-				allwinner,function = "mmc3";
-				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			ir0_rx_pins_a: ir0 at 0 {
-				    allwinner,pins = "PB4";
-				    allwinner,function = "ir0";
-				    allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				    allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			uart3_pins_a: uart3 at 0 {
+				allwinner,pins = "PG6", "PG7", "PG8", "PG9";
+				allwinner,function = "uart3";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			ir0_tx_pins_a: ir0 at 1 {
-				    allwinner,pins = "PB3";
-				    allwinner,function = "ir0";
-				    allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				    allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			uart3_pins_b: uart3 at 1 {
+				allwinner,pins = "PH0", "PH1";
+				allwinner,function = "uart3";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			ir1_rx_pins_a: ir1 at 0 {
-				    allwinner,pins = "PB23";
-				    allwinner,function = "ir1";
-				    allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				    allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			uart4_pins_a: uart4 at 0 {
+				allwinner,pins = "PG10", "PG11";
+				allwinner,function = "uart4";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			ir1_tx_pins_a: ir1 at 1 {
-				    allwinner,pins = "PB22";
-				    allwinner,function = "ir1";
-				    allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				    allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			uart4_pins_b: uart4 at 1 {
+				allwinner,pins = "PH4", "PH5";
+				allwinner,function = "uart4";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			ps20_pins_a: ps20 at 0 {
-				allwinner,pins = "PI20", "PI21";
-				allwinner,function = "ps2";
+			uart5_pins_a: uart5 at 0 {
+				allwinner,pins = "PI10", "PI11";
+				allwinner,function = "uart5";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			ps21_pins_a: ps21 at 0 {
-				allwinner,pins = "PH12", "PH13";
-				allwinner,function = "ps2";
+			uart6_pins_a: uart6 at 0 {
+				allwinner,pins = "PI12", "PI13";
+				allwinner,function = "uart6";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
-			spdif_tx_pins_a: spdif at 0 {
-				allwinner,pins = "PB13";
-				allwinner,function = "spdif";
+			uart7_pins_a: uart7 at 0 {
+				allwinner,pins = "PI20", "PI21";
+				allwinner,function = "uart7";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 		};
 
-- 
2.7.3
