From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Jan 2017 10:09:24 +0100
Subject: [PATCH 4/4] ARM: dts: imx7: Add "LPSR" to LPSR iomux pin names
In-Reply-To: <20170119090924.19636-1-s.hauer@pengutronix.de>
References: <20170119090924.19636-1-s.hauer@pengutronix.de>
Message-ID: <20170119090924.19636-5-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX7 has two iomux controllers. the iomuxc and the iomuxc_lpsr.
In a board dts we have to make sure that both controllers are supplied
with the correct pins. It's way too easy to do this wrong since only
a look into the reference manual can reveal which pins belong to which
controller. To make this clearer add "LPSR" to the pin names which
belong to the LPSR controller.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx7-colibri.dtsi     |  16 ++---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts |   2 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts   |  14 ++--
 arch/arm/boot/dts/imx7d-pinfunc.h       | 110 ++++++++++++++++----------------
 arch/arm/boot/dts/imx7d-sdb.dts         |   4 +-
 arch/arm/boot/dts/imx7s-warp.dts        |   2 +-
 6 files changed, 74 insertions(+), 74 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index a9cc65725f19..a171545478be 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -596,29 +596,29 @@
 
 	pinctrl_gpio_lpsr: gpio1-grp {
 		fsl,pins = <
-			MX7D_PAD_GPIO1_IO01__GPIO1_IO1	0x59
-			MX7D_PAD_GPIO1_IO02__GPIO1_IO2	0x59
-			MX7D_PAD_GPIO1_IO03__GPIO1_IO3	0x59
+			MX7D_PAD_LPSR_GPIO1_IO01__GPIO1_IO1	0x59
+			MX7D_PAD_LPSR_GPIO1_IO02__GPIO1_IO2	0x59
+			MX7D_PAD_LPSR_GPIO1_IO03__GPIO1_IO3	0x59
 		>;
 	};
 
 	pinctrl_i2c1: i2c1-grp {
 		fsl,pins = <
-			MX7D_PAD_GPIO1_IO05__I2C1_SDA	0x4000007f
-			MX7D_PAD_GPIO1_IO04__I2C1_SCL	0x4000007f
+			MX7D_PAD_LPSR_GPIO1_IO05__I2C1_SDA	0x4000007f
+			MX7D_PAD_LPSR_GPIO1_IO04__I2C1_SCL	0x4000007f
 		>;
 	};
 
 	pinctrl_cd_usdhc1: usdhc1-cd-grp {
 		fsl,pins = <
-			MX7D_PAD_GPIO1_IO00__GPIO1_IO0	0x59 /* CD */
+			MX7D_PAD_LPSR_GPIO1_IO00__GPIO1_IO0	0x59 /* CD */
 		>;
 	};
 
 	pinctrl_uart1_ctrl2: uart1-ctrl2-grp {
 		fsl,pins = <
-			MX7D_PAD_GPIO1_IO07__GPIO1_IO7	0x14 /* DSR */
-			MX7D_PAD_GPIO1_IO06__GPIO1_IO6	0x14 /* RI */
+			MX7D_PAD_LPSR_GPIO1_IO07__GPIO1_IO7	0x14 /* DSR */
+			MX7D_PAD_LPSR_GPIO1_IO06__GPIO1_IO6	0x14 /* RI */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 1135bc99b3e7..ae45af1ad062 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -281,7 +281,7 @@
 &iomuxc_lpsr {
 	pinctrl_usbotg1: usbotg1grp {
 		fsl,pins = <
-			MX7D_PAD_GPIO1_IO05__GPIO1_IO5		0x14 /* OTG PWREN */
+			MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5	0x14 /* OTG PWREN */
 		>;
 	};
 };
\ No newline at end of file
diff --git a/arch/arm/boot/dts/imx7d-nitrogen7.dts b/arch/arm/boot/dts/imx7d-nitrogen7.dts
index ce08f180f213..5d98e2b5d54b 100644
--- a/arch/arm/boot/dts/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/imx7d-nitrogen7.dts
@@ -712,33 +712,33 @@
 
 	pinctrl_hog_2: hoggrp-2 {
 		fsl,pins = <
-			MX7D_PAD_GPIO1_IO02__GPIO1_IO2		0x7d
-			MX7D_PAD_GPIO1_IO03__CCM_CLKO2		0x7d
+			MX7D_PAD_LPSR_GPIO1_IO02__GPIO1_IO2	0x7d
+			MX7D_PAD_LPSR_GPIO1_IO03__CCM_CLKO2	0x7d
 		>;
 	};
 
 	pinctrl_backlight_j9: backlightj9grp {
 		fsl,pins = <
-			MX7D_PAD_GPIO1_IO07__GPIO1_IO7		0x7d
+			MX7D_PAD_LPSR_GPIO1_IO07__GPIO1_IO7	0x7d
 		>;
 	};
 
 	pinctrl_pwm1: pwm1grp {
 		fsl,pins = <
-			MX7D_PAD_GPIO1_IO01__PWM1_OUT		0x7d
+			MX7D_PAD_LPSR_GPIO1_IO01__PWM1_OUT	0x7d
 		>;
 	};
 
 	pinctrl_usbotg1: usbotg1grp {
 		fsl,pins = <
-			MX7D_PAD_GPIO1_IO04__USB_OTG1_OC	0x7d
-			MX7D_PAD_GPIO1_IO05__GPIO1_IO5		0x14
+			MX7D_PAD_LPSR_GPIO1_IO04__USB_OTG1_OC	0x7d
+			MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5	0x14
 		>;
 	};
 
 	pinctrl_wdog1: wdog1grp {
 		fsl,pins = <
-			MX7D_PAD_GPIO1_IO00__WDOD1_WDOG_B	0x75
+			MX7D_PAD_LPSR_GPIO1_IO00__WDOD1_WDOG_B	0x75
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx7d-pinfunc.h b/arch/arm/boot/dts/imx7d-pinfunc.h
index 7bc3c00e56c6..f6f7e78f8820 100644
--- a/arch/arm/boot/dts/imx7d-pinfunc.h
+++ b/arch/arm/boot/dts/imx7d-pinfunc.h
@@ -15,61 +15,61 @@
  * <mux_reg conf_reg input_reg mux_mode input_val>
  */
 
-#define MX7D_PAD_GPIO1_IO00__GPIO1_IO0                            0x0000 0x0030 0x0000 0x0 0x0
-#define MX7D_PAD_GPIO1_IO00__PWM4_OUT                             0x0000 0x0030 0x0000 0x1 0x0
-#define MX7D_PAD_GPIO1_IO00__WDOD1_WDOG_ANY                       0x0000 0x0030 0x0000 0x2 0x0
-#define MX7D_PAD_GPIO1_IO00__WDOD1_WDOG_B                         0x0000 0x0030 0x0000 0x3 0x0
-#define MX7D_PAD_GPIO1_IO00__WDOD1_WDOG__RST_B_DEB                0x0000 0x0030 0x0000 0x4 0x0
-#define MX7D_PAD_GPIO1_IO01__GPIO1_IO1                            0x0004 0x0034 0x0000 0x0 0x0
-#define MX7D_PAD_GPIO1_IO01__PWM1_OUT                             0x0004 0x0034 0x0000 0x1 0x0
-#define MX7D_PAD_GPIO1_IO01__CCM_ENET_REF_CLK3                    0x0004 0x0034 0x0000 0x2 0x0
-#define MX7D_PAD_GPIO1_IO01__SAI1_MCLK                            0x0004 0x0034 0x0000 0x3 0x0
-#define MX7D_PAD_GPIO1_IO01__ANATOP_24M_OUT                       0x0004 0x0034 0x0000 0x4 0x0
-#define MX7D_PAD_GPIO1_IO01__OBSERVE0_OUT                         0x0004 0x0034 0x0000 0x6 0x0
-#define MX7D_PAD_GPIO1_IO02__GPIO1_IO2                            0x0008 0x0038 0x0000 0x0 0x0
-#define MX7D_PAD_GPIO1_IO02__PWM2_OUT                             0x0008 0x0038 0x0000 0x1 0x0
-#define MX7D_PAD_GPIO1_IO02__CCM_ENET_REF_CLK1                    0x0008 0x0038 0x0564 0x2 0x3
-#define MX7D_PAD_GPIO1_IO02__SAI2_MCLK                            0x0008 0x0038 0x0000 0x3 0x0
-#define MX7D_PAD_GPIO1_IO02__CCM_CLKO1                            0x0008 0x0038 0x0000 0x5 0x0
-#define MX7D_PAD_GPIO1_IO02__OBSERVE1_OUT                         0x0008 0x0038 0x0000 0x6 0x0
-#define MX7D_PAD_GPIO1_IO02__USB_OTG1_ID                          0x0008 0x0038 0x0734 0x7 0x3
-#define MX7D_PAD_GPIO1_IO03__GPIO1_IO3                            0x000C 0x003C 0x0000 0x0 0x0
-#define MX7D_PAD_GPIO1_IO03__PWM3_OUT                             0x000C 0x003C 0x0000 0x1 0x0
-#define MX7D_PAD_GPIO1_IO03__CCM_ENET_REF_CLK2                    0x000C 0x003C 0x0570 0x2 0x3
-#define MX7D_PAD_GPIO1_IO03__SAI3_MCLK                            0x000C 0x003C 0x0000 0x3 0x0
-#define MX7D_PAD_GPIO1_IO03__CCM_CLKO2                            0x000C 0x003C 0x0000 0x5 0x0
-#define MX7D_PAD_GPIO1_IO03__OBSERVE2_OUT                         0x000C 0x003C 0x0000 0x6 0x0
-#define MX7D_PAD_GPIO1_IO03__USB_OTG2_ID                          0x000C 0x003C 0x0730 0x7 0x3
-#define MX7D_PAD_GPIO1_IO04__GPIO1_IO4                            0x0010 0x0040 0x0000 0x0 0x0
-#define MX7D_PAD_GPIO1_IO04__USB_OTG1_OC                          0x0010 0x0040 0x072C 0x1 0x1
-#define MX7D_PAD_GPIO1_IO04__FLEXTIMER1_CH4                       0x0010 0x0040 0x0594 0x2 0x1
-#define MX7D_PAD_GPIO1_IO04__UART5_DCE_CTS                        0x0010 0x0040 0x0000 0x3 0x0
-#define MX7D_PAD_GPIO1_IO04__UART5_DTE_RTS                        0x0010 0x0040 0x0710 0x3 0x4
-#define MX7D_PAD_GPIO1_IO04__I2C1_SCL                             0x0010 0x0040 0x05D4 0x4 0x2
-#define MX7D_PAD_GPIO1_IO04__OBSERVE3_OUT                         0x0010 0x0040 0x0000 0x6 0x0
-#define MX7D_PAD_GPIO1_IO05__GPIO1_IO5                            0x0014 0x0044 0x0000 0x0 0x0
-#define MX7D_PAD_GPIO1_IO05__USB_OTG1_PWR                         0x0014 0x0044 0x0000 0x1 0x0
-#define MX7D_PAD_GPIO1_IO05__FLEXTIMER1_CH5                       0x0014 0x0044 0x0598 0x2 0x1
-#define MX7D_PAD_GPIO1_IO05__UART5_DCE_RTS                        0x0014 0x0044 0x0710 0x3 0x5
-#define MX7D_PAD_GPIO1_IO05__UART5_DTE_CTS                        0x0014 0x0044 0x0000 0x3 0x0
-#define MX7D_PAD_GPIO1_IO05__I2C1_SDA                             0x0014 0x0044 0x05D8 0x4 0x2
-#define MX7D_PAD_GPIO1_IO05__OBSERVE4_OUT                         0x0014 0x0044 0x0000 0x6 0x0
-#define MX7D_PAD_GPIO1_IO06__GPIO1_IO6                            0x0018 0x0048 0x0000 0x0 0x0
-#define MX7D_PAD_GPIO1_IO06__USB_OTG2_OC                          0x0018 0x0048 0x0728 0x1 0x1
-#define MX7D_PAD_GPIO1_IO06__FLEXTIMER1_CH6                       0x0018 0x0048 0x059C 0x2 0x1
-#define MX7D_PAD_GPIO1_IO06__UART5_DCE_RX                         0x0018 0x0048 0x0714 0x3 0x4
-#define MX7D_PAD_GPIO1_IO06__UART5_DTE_TX                         0x0018 0x0048 0x0000 0x3 0x0
-#define MX7D_PAD_GPIO1_IO06__I2C2_SCL                             0x0018 0x0048 0x05DC 0x4 0x2
-#define MX7D_PAD_GPIO1_IO06__CCM_WAIT                             0x0018 0x0048 0x0000 0x5 0x0
-#define MX7D_PAD_GPIO1_IO06__KPP_ROW4                             0x0018 0x0048 0x0624 0x6 0x1
-#define MX7D_PAD_GPIO1_IO07__GPIO1_IO7                            0x001C 0x004C 0x0000 0x0 0x0
-#define MX7D_PAD_GPIO1_IO07__USB_OTG2_PWR                         0x001C 0x004C 0x0000 0x1 0x0
-#define MX7D_PAD_GPIO1_IO07__FLEXTIMER1_CH7                       0x001C 0x004C 0x05A0 0x2 0x1
-#define MX7D_PAD_GPIO1_IO07__UART5_DCE_TX                         0x001C 0x004C 0x0000 0x3 0x0
-#define MX7D_PAD_GPIO1_IO07__UART5_DTE_RX                         0x001C 0x004C 0x0714 0x3 0x5
-#define MX7D_PAD_GPIO1_IO07__I2C2_SDA                             0x001C 0x004C 0x05E0 0x4 0x2
-#define MX7D_PAD_GPIO1_IO07__CCM_STOP                             0x001C 0x004C 0x0000 0x5 0x0
-#define MX7D_PAD_GPIO1_IO07__KPP_COL4                             0x001C 0x004C 0x0604 0x6 0x1
+#define MX7D_PAD_LPSR_GPIO1_IO00__GPIO1_IO0                       0x0000 0x0030 0x0000 0x0 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO00__PWM4_OUT                        0x0000 0x0030 0x0000 0x1 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO00__WDOD1_WDOG_ANY                  0x0000 0x0030 0x0000 0x2 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO00__WDOD1_WDOG_B                    0x0000 0x0030 0x0000 0x3 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO00__WDOD1_WDOG__RST_B_DEB           0x0000 0x0030 0x0000 0x4 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO01__GPIO1_IO1                       0x0004 0x0034 0x0000 0x0 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO01__PWM1_OUT                        0x0004 0x0034 0x0000 0x1 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO01__CCM_ENET_REF_CLK3               0x0004 0x0034 0x0000 0x2 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO01__SAI1_MCLK                       0x0004 0x0034 0x0000 0x3 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO01__ANATOP_24M_OUT                  0x0004 0x0034 0x0000 0x4 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO01__OBSERVE0_OUT                    0x0004 0x0034 0x0000 0x6 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO02__GPIO1_IO2                       0x0008 0x0038 0x0000 0x0 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO02__PWM2_OUT                        0x0008 0x0038 0x0000 0x1 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO02__CCM_ENET_REF_CLK1               0x0008 0x0038 0x0564 0x2 0x3
+#define MX7D_PAD_LPSR_GPIO1_IO02__SAI2_MCLK                       0x0008 0x0038 0x0000 0x3 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO02__CCM_CLKO1                       0x0008 0x0038 0x0000 0x5 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO02__OBSERVE1_OUT                    0x0008 0x0038 0x0000 0x6 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO02__USB_OTG1_ID                     0x0008 0x0038 0x0734 0x7 0x3
+#define MX7D_PAD_LPSR_GPIO1_IO03__GPIO1_IO3                       0x000C 0x003C 0x0000 0x0 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO03__PWM3_OUT                        0x000C 0x003C 0x0000 0x1 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO03__CCM_ENET_REF_CLK2               0x000C 0x003C 0x0570 0x2 0x3
+#define MX7D_PAD_LPSR_GPIO1_IO03__SAI3_MCLK                       0x000C 0x003C 0x0000 0x3 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO03__CCM_CLKO2                       0x000C 0x003C 0x0000 0x5 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO03__OBSERVE2_OUT                    0x000C 0x003C 0x0000 0x6 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO03__USB_OTG2_ID                     0x000C 0x003C 0x0730 0x7 0x3
+#define MX7D_PAD_LPSR_GPIO1_IO04__GPIO1_IO4                       0x0010 0x0040 0x0000 0x0 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO04__USB_OTG1_OC                     0x0010 0x0040 0x072C 0x1 0x1
+#define MX7D_PAD_LPSR_GPIO1_IO04__FLEXTIMER1_CH4                  0x0010 0x0040 0x0594 0x2 0x1
+#define MX7D_PAD_LPSR_GPIO1_IO04__UART5_DCE_CTS                   0x0010 0x0040 0x0000 0x3 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO04__UART5_DTE_RTS                   0x0010 0x0040 0x0710 0x3 0x4
+#define MX7D_PAD_LPSR_GPIO1_IO04__I2C1_SCL                        0x0010 0x0040 0x05D4 0x4 0x2
+#define MX7D_PAD_LPSR_GPIO1_IO04__OBSERVE3_OUT                    0x0010 0x0040 0x0000 0x6 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5                       0x0014 0x0044 0x0000 0x0 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO05__USB_OTG1_PWR                    0x0014 0x0044 0x0000 0x1 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO05__FLEXTIMER1_CH5                  0x0014 0x0044 0x0598 0x2 0x1
+#define MX7D_PAD_LPSR_GPIO1_IO05__UART5_DCE_RTS                   0x0014 0x0044 0x0710 0x3 0x5
+#define MX7D_PAD_LPSR_GPIO1_IO05__UART5_DTE_CTS                   0x0014 0x0044 0x0000 0x3 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO05__I2C1_SDA                        0x0014 0x0044 0x05D8 0x4 0x2
+#define MX7D_PAD_LPSR_GPIO1_IO05__OBSERVE4_OUT                    0x0014 0x0044 0x0000 0x6 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO06__GPIO1_IO6                       0x0018 0x0048 0x0000 0x0 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO06__USB_OTG2_OC                     0x0018 0x0048 0x0728 0x1 0x1
+#define MX7D_PAD_LPSR_GPIO1_IO06__FLEXTIMER1_CH6                  0x0018 0x0048 0x059C 0x2 0x1
+#define MX7D_PAD_LPSR_GPIO1_IO06__UART5_DCE_RX                    0x0018 0x0048 0x0714 0x3 0x4
+#define MX7D_PAD_LPSR_GPIO1_IO06__UART5_DTE_TX                    0x0018 0x0048 0x0000 0x3 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO06__I2C2_SCL                        0x0018 0x0048 0x05DC 0x4 0x2
+#define MX7D_PAD_LPSR_GPIO1_IO06__CCM_WAIT                        0x0018 0x0048 0x0000 0x5 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO06__KPP_ROW4                        0x0018 0x0048 0x0624 0x6 0x1
+#define MX7D_PAD_LPSR_GPIO1_IO07__GPIO1_IO7                       0x001C 0x004C 0x0000 0x0 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO07__USB_OTG2_PWR                    0x001C 0x004C 0x0000 0x1 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO07__FLEXTIMER1_CH7                  0x001C 0x004C 0x05A0 0x2 0x1
+#define MX7D_PAD_LPSR_GPIO1_IO07__UART5_DCE_TX                    0x001C 0x004C 0x0000 0x3 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO07__UART5_DTE_RX                    0x001C 0x004C 0x0714 0x3 0x5
+#define MX7D_PAD_LPSR_GPIO1_IO07__I2C2_SDA                        0x001C 0x004C 0x05E0 0x4 0x2
+#define MX7D_PAD_LPSR_GPIO1_IO07__CCM_STOP                        0x001C 0x004C 0x0000 0x5 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO07__KPP_COL4                        0x001C 0x004C 0x0604 0x6 0x1
 #define MX7D_PAD_GPIO1_IO08__GPIO1_IO8                            0x0014 0x026C 0x0000 0x0 0x0
 #define MX7D_PAD_GPIO1_IO08__SD1_VSELECT                          0x0014 0x026C 0x0000 0x1 0x0
 #define MX7D_PAD_GPIO1_IO08__WDOG1_WDOG_B                         0x0014 0x026C 0x0000 0x2 0x0
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 84f35a6cbb30..2afe48439948 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -635,13 +635,13 @@
 &iomuxc_lpsr {
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
-			MX7D_PAD_GPIO1_IO00__WDOD1_WDOG_B	0x74
+			MX7D_PAD_LPSR_GPIO1_IO00__WDOD1_WDOG_B		0x74
 		>;
 	};
 
 	pinctrl_pwm1: pwm1grp {
 		fsl,pins = <
-			MX7D_PAD_GPIO1_IO01__PWM1_OUT		0x110b0
+			MX7D_PAD_LPSR_GPIO1_IO01__PWM1_OUT		0x110b0
 		>;
 	};
 };
\ No newline at end of file
diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index cbb5bc16e713..d5237fd0fa65 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -442,7 +442,7 @@
 &iomuxc_lpsr {
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
-			MX7D_PAD_GPIO1_IO00__WDOD1_WDOG_B	0x74
+			MX7D_PAD_LPSR_GPIO1_IO00__WDOD1_WDOG_B	0x74
 		>;
 	};
 };
-- 
2.11.0
