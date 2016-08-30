From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue, 30 Aug 2016 17:25:59 +0930
Subject: [PATCH v3 6/7] aspeed-g5: Add syscon and pin controller nodes
In-Reply-To: <20160830075600.11559-1-andrew@aj.id.au>
References: <20160830075600.11559-1-andrew@aj.id.au>
Message-ID: <20160830075600.11559-7-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pin controller's child nodes expose the functions currently
implemented in the g5 pin controller driver.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 204 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 204 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index dd94d9361fda..24d79c88019f 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -44,6 +44,210 @@
 				reg = <0x1e6e2070 0x04>;
 			};
 
+			syscon: syscon at 1e6e2000 {
+				compatible = "aspeed,g5-scu", "syscon", "simple-mfd";
+				reg = <0x1e6e2000 0x1a8>;
+
+				pinctrl: pinctrl {
+					compatible = "aspeed,g5-pinctrl";
+
+					pinctrl_gpid0_default: gpid0_default {
+						function = "GPID0";
+						groups = "GPID0";
+					};
+
+					pinctrl_gpid2_default: gpid2_default {
+						function = "GPID2";
+						groups = "GPID2";
+					};
+
+					pinctrl_gpie0_default: gpie0_default {
+						function = "GPIE0";
+						groups = "GPIE0";
+					};
+
+					pinctrl_i2c10_default: i2c10_default {
+						function = "I2C10";
+						groups = "I2C10";
+					};
+
+					pinctrl_i2c11_default: i2c11_default {
+						function = "I2C11";
+						groups = "I2C11";
+					};
+
+					pinctrl_i2c12_default: i2c12_default {
+						function = "I2C12";
+						groups = "I2C12";
+					};
+
+					pinctrl_i2c13_default: i2c13_default {
+						function = "I2C13";
+						groups = "I2C13";
+					};
+
+					pinctrl_i2c14_default: i2c14_default {
+						function = "I2C14";
+						groups = "I2C14";
+					};
+
+					pinctrl_i2c3_default: i2c3_default {
+						function = "I2C3";
+						groups = "I2C3";
+					};
+
+					pinctrl_i2c4_default: i2c4_default {
+						function = "I2C4";
+						groups = "I2C4";
+					};
+
+					pinctrl_i2c5_default: i2c5_default {
+						function = "I2C5";
+						groups = "I2C5";
+					};
+
+					pinctrl_i2c6_default: i2c6_default {
+						function = "I2C6";
+						groups = "I2C6";
+					};
+
+					pinctrl_i2c7_default: i2c7_default {
+						function = "I2C7";
+						groups = "I2C7";
+					};
+
+					pinctrl_i2c8_default: i2c8_default {
+						function = "I2C8";
+						groups = "I2C8";
+					};
+
+					pinctrl_i2c9_default: i2c9_default {
+						function = "I2C9";
+						groups = "I2C9";
+					};
+
+					pinctrl_mac1link_default: mac1link_default {
+						function = "MAC1LINK";
+						groups = "MAC1LINK";
+					};
+
+					pinctrl_mdio1_default: mdio1_default {
+						function = "MDIO1";
+						groups = "MDIO1";
+					};
+
+					pinctrl_mdio2_default: mdio2_default {
+						function = "MDIO2";
+						groups = "MDIO2";
+					};
+
+					pinctrl_oscclk_default: oscclk_default {
+						function = "OSCCLK";
+						groups = "OSCCLK";
+					};
+
+					pinctrl_pewake_default: pewake_default {
+						function = "PEWAKE";
+						groups = "PEWAKE";
+					};
+
+					pinctrl_pwm0_default: pwm0_default {
+						function = "PWM0";
+						groups = "PWM0";
+					};
+
+					pinctrl_pwm1_default: pwm1_default {
+						function = "PWM1";
+						groups = "PWM1";
+					};
+
+					pinctrl_pwm2_default: pwm2_default {
+						function = "PWM2";
+						groups = "PWM2";
+					};
+
+					pinctrl_pwm3_default: pwm3_default {
+						function = "PWM3";
+						groups = "PWM3";
+					};
+
+					pinctrl_pwm4_default: pwm4_default {
+						function = "PWM4";
+						groups = "PWM4";
+					};
+
+					pinctrl_pwm5_default: pwm5_default {
+						function = "PWM5";
+						groups = "PWM5";
+					};
+
+					pinctrl_pwm6_default: pwm6_default {
+						function = "PWM6";
+						groups = "PWM6";
+					};
+
+					pinctrl_pwm7_default: pwm7_default {
+						function = "PWM7";
+						groups = "PWM7";
+					};
+
+					pinctrl_rgmii1_default: rgmii1_default {
+						function = "RGMII1";
+						groups = "RGMII1";
+					};
+
+					pinctrl_rgmii2_default: rgmii2_default {
+						function = "RGMII2";
+						groups = "RGMII2";
+					};
+
+					pinctrl_rmii1_default: rmii1_default {
+						function = "RMII1";
+						groups = "RMII1";
+					};
+
+					pinctrl_rmii2_default: rmii2_default {
+						function = "RMII2";
+						groups = "RMII2";
+					};
+
+					pinctrl_sd1_default: sd1_default {
+						function = "SD1";
+						groups = "SD1";
+					};
+
+					pinctrl_spi1_default: spi1_default {
+						function = "SPI1";
+						groups = "SPI1";
+					};
+
+					pinctrl_timer4_default: timer4_default {
+						function = "TIMER4";
+						groups = "TIMER4";
+					};
+
+					pinctrl_timer5_default: timer5_default {
+						function = "TIMER5";
+						groups = "TIMER5";
+					};
+
+					pinctrl_timer6_default: timer6_default {
+						function = "TIMER6";
+						groups = "TIMER6";
+					};
+
+					pinctrl_timer7_default: timer7_default {
+						function = "TIMER7";
+						groups = "TIMER7";
+					};
+
+					pinctrl_timer8_default: timer8_default {
+						function = "TIMER8";
+						groups = "TIMER8";
+					};
+				};
+			};
+
 			clk_hpll: clk_hpll at 1e6e2024 {
 				#clock-cells = <0>;
 				compatible = "aspeed,g5-hpll-clock";
-- 
2.9.3.1.g0db844e
