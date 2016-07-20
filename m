From: andrew@aj.id.au (Andrew Jeffery)
Date: Wed, 20 Jul 2016 15:28:29 +0930
Subject: [PATCH 08/12] aspeed-g4: Add syscon and pin controller nodes
In-Reply-To: <1468994313-13538-1-git-send-email-andrew@aj.id.au>
References: <1468994313-13538-1-git-send-email-andrew@aj.id.au>
Message-ID: <1468994313-13538-9-git-send-email-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pin controller's child nodes expose the functions currently
implemented in the the g4 pin controller driver.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 284 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 284 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 22dee5937d5c..a62d1b5b5054 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -54,6 +54,290 @@
 				clocks = <&clk_clkin>;
 			};
 
+			syscon: syscon at 1e6e2000 {
+				compatible = "aspeed,g4-scu", "syscon", "simple-mfd";
+				reg = <0x1e6e2000 0x1a8>;
+
+				pinctrl: pinctrl at 1e6e2000 {
+					compatible = "aspeed,g4-pinctrl";
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
+					pinctrl_mdio2_default: mdio2_default {
+						function = "MDIO2";
+						groups = "MDIO2";
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
+
+					pinctrl_lpcpd_default: lpcpd {
+						function = "LPCPD";
+						groups = "LPCPD";
+					};
+
+					pinctrl_lpcsmi_default: lpcsmi {
+						function = "LPCSMI";
+						groups = "LPCSMI";
+					};
+
+					pinctrl_lpcpme_default: lpcpme {
+						function = "LPCPME";
+						groups = "LPCPME";
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
+					pinctrl_gpid0_default: gpid0_default {
+						function = "GPID0";
+						groups = "GPID0";
+					};
+
+					pinctrl_ncts3_default: ncts3_default {
+						function = "NCTS3";
+						groups = "NCTS3";
+					};
+
+					pinctrl_ndcd3_default: ndcd3_default {
+						function = "NDCD3";
+						groups = "NDCD3";
+					};
+
+					pinctrl_gpie0_default: gpie0_default {
+						function = "GPIE0";
+						groups = "GPIE0";
+					};
+
+					pinctrl_ncts4_default: ncts4_default {
+						function = "NCTS4";
+						groups = "NCTS4";
+					};
+
+					pinctrl_ndcd4_default: ndcd4_default {
+						function = "NDCD4";
+						groups = "NDCD4";
+					};
+
+					pinctrl_nri4_default: nri4_default {
+						function = "NRI4";
+						groups = "NRI4";
+					};
+
+					pinctrl_txd4_default: txd4_default {
+						function = "TXD4";
+						groups = "TXD4";
+					};
+
+					pinctrl_rxd4_default: rxd4_default {
+						function = "RXD4";
+						groups = "RXD4";
+					};
+
+					pinctrl_flbusy_default: flbusy {
+						function = "FLBUSY";
+						groups = "FLBUSY";
+					};
+
+					pinctrl_flwp_default: flwp {
+						function = "FLWP";
+						groups = "FLWP";
+					};
+
+					pinctrl_sgpmi_default: sgpmi {
+						function = "SGPMI";
+						groups = "SGPMI";
+					};
+
+					pinctrl_vgahs_default: vgahs {
+						function = "VGAHS";
+						groups = "VGAHS";
+					};
+
+					pinctrl_vgavs_default: vgavs {
+						function = "VGAVS";
+						groups = "VGAVS";
+					};
+
+					pinctrl_ddcclk_default: ddcclk {
+						function = "DDCCLK";
+						groups = "DDCCLK";
+					};
+
+					pinctrl_ddcdat_default: ddcdat {
+						function = "DDCDAT";
+						groups = "DDCDAT";
+					};
+
+					pinctrl_ncts1_default: ncts1_default {
+						function = "NCTS1";
+						groups = "NCTS1";
+					};
+
+					pinctrl_ndcd1_default: ndcd1_default {
+						function = "NDCD1";
+						groups = "NDCD1";
+					};
+
+					pinctrl_nri1_default: nri1_default {
+						function = "NRI1";
+						groups = "NRI1";
+					};
+
+					pinctrl_ndtr1_default: ndtr1_default {
+						function = "NDTR1";
+						groups = "NDTR1";
+					};
+
+					pinctrl_nrts1_default: nrts1_default {
+						function = "NRTS1";
+						groups = "NRTS1";
+					};
+
+					pinctrl_txd1_default: txd1_default {
+						function = "TXD1";
+						groups = "TXD1";
+					};
+
+					pinctrl_rxd1_default: rxd1_default {
+						function = "RXD1";
+						groups = "RXD1";
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
+					pinctrl_bmcint_default: bmcint {
+						function = "BMCINT";
+						groups = "BMCINT";
+					};
+
+					pinctrl_flack_default: flack {
+						function = "FLACK";
+						groups = "FLACK";
+					};
+
+					pinctrl_rom8_default: rom8 {
+						function = "ROM8";
+						groups = "ROM8";
+					};
+
+					pinctrl_rgmii1_default: rgmii1_default {
+						function = "RGMII1";
+						groups = "RGMII1";
+					};
+
+					pinctrl_rmii1_default: rmii1_default {
+						function = "RMII1";
+						groups = "RMII1";
+					};
+				};
+			};
+
 			clk_apb: clk_apb at 1e6e2008 {
 				#clock-cells = <0>;
 				compatible = "aspeed,g4-apb-clock";
-- 
2.7.4
