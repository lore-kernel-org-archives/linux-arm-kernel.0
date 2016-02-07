From: smoch@web.de (Soeren Moch)
Date: Sun,  7 Feb 2016 19:34:32 +0100
Subject: [PATCH 3/4] ARM: dts: imx6q-tbs2910: remove unnecessary iomuxc
 container nodes
In-Reply-To: <1454870073-6506-1-git-send-email-smoch@web.de>
References: <1454870073-6506-1-git-send-email-smoch@web.de>
Message-ID: <1454870073-6506-3-git-send-email-smoch@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the following unnecessary iomuxc container nodes:
imx6q-tbs2910
gpio_fan
gpio_leds

Sort the pinctrl nodes alphabetically.

Signed-off-by: Soeren Moch <smoch@web.de>
---
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/boot/dts/imx6q-tbs2910.dts | 262 ++++++++++++++++++------------------
 1 file changed, 128 insertions(+), 134 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-tbs2910.dts b/arch/arm/boot/dts/imx6q-tbs2910.dts
index 3b4360a..b9afafc 100644
--- a/arch/arm/boot/dts/imx6q-tbs2910.dts
+++ b/arch/arm/boot/dts/imx6q-tbs2910.dts
@@ -289,157 +289,151 @@
 };
 
 &iomuxc {
-	imx6q-tbs2910 {
-		pinctrl_enet: enetgrp {
-			fsl,pins = <
-				MX6QDL_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
-				MX6QDL_PAD_ENET_MDC__ENET_MDC         0x1b0b0
-				MX6QDL_PAD_RGMII_TXC__RGMII_TXC       0x1b0b0
-				MX6QDL_PAD_RGMII_TD0__RGMII_TD0       0x1b0b0
-				MX6QDL_PAD_RGMII_TD1__RGMII_TD1       0x1b0b0
-				MX6QDL_PAD_RGMII_TD2__RGMII_TD2       0x1b0b0
-				MX6QDL_PAD_RGMII_TD3__RGMII_TD3       0x1b0b0
-				MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b0b0
-				MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
-				MX6QDL_PAD_RGMII_RXC__RGMII_RXC       0x1b0b0
-				MX6QDL_PAD_RGMII_RD0__RGMII_RD0       0x1b0b0
-				MX6QDL_PAD_RGMII_RD1__RGMII_RD1       0x1b0b0
-				MX6QDL_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
-				MX6QDL_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
-				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
-				MX6QDL_PAD_GPIO_16__ENET_REF_CLK      0x4001b0a8
-				MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25    0x1b059
-			>;
-		};
+	pinctrl_enet: enetgrp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
+			MX6QDL_PAD_ENET_MDC__ENET_MDC         0x1b0b0
+			MX6QDL_PAD_RGMII_TXC__RGMII_TXC       0x1b0b0
+			MX6QDL_PAD_RGMII_TD0__RGMII_TD0       0x1b0b0
+			MX6QDL_PAD_RGMII_TD1__RGMII_TD1       0x1b0b0
+			MX6QDL_PAD_RGMII_TD2__RGMII_TD2       0x1b0b0
+			MX6QDL_PAD_RGMII_TD3__RGMII_TD3       0x1b0b0
+			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b0b0
+			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
+			MX6QDL_PAD_RGMII_RXC__RGMII_RXC       0x1b0b0
+			MX6QDL_PAD_RGMII_RD0__RGMII_RD0       0x1b0b0
+			MX6QDL_PAD_RGMII_RD1__RGMII_RD1       0x1b0b0
+			MX6QDL_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
+			MX6QDL_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
+			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
+			MX6QDL_PAD_GPIO_16__ENET_REF_CLK      0x4001b0a8
+			MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25    0x1b059
+		>;
+	};
 
-		pinctrl_hdmi: hdmigrp {
-			fsl,pins = <
-				MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE 0x1f8b0
-			>;
-		};
+	pinctrl_gpio_fan: gpiofangrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D28__GPIO3_IO28        0x130b1
+		>;
+	};
 
-		pinctrl_i2c1: i2c1grp {
-			fsl,pins = <
-				MX6QDL_PAD_CSI0_DAT9__I2C1_SCL        0x4001b8b1
-				MX6QDL_PAD_CSI0_DAT8__I2C1_SDA        0x4001b8b1
-			>;
-		};
+	pinctrl_gpio_leds: gpioledsgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_2__GPIO1_IO02         0x130b1
+		>;
+	};
 
-		pinctrl_i2c2: i2c2grp {
-			fsl,pins = <
-				MX6QDL_PAD_KEY_COL3__I2C2_SCL         0x4001b8b1
-				MX6QDL_PAD_KEY_ROW3__I2C2_SDA         0x4001b8b1
-			>;
-		};
+	pinctrl_hdmi: hdmigrp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE 0x1f8b0
+		>;
+	};
 
-		pinctrl_i2c3: i2c3grp {
-			fsl,pins = <
-				MX6QDL_PAD_GPIO_3__I2C3_SCL           0x4001b8b1
-				MX6QDL_PAD_GPIO_6__I2C3_SDA           0x4001b8b1
-			>;
-		};
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL        0x4001b8b1
+			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA        0x4001b8b1
+		>;
+	};
 
-		pinctrl_ir: irgrp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_D18__GPIO3_IO18        0x17059
-			>;
-		};
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL3__I2C2_SCL         0x4001b8b1
+			MX6QDL_PAD_KEY_ROW3__I2C2_SDA         0x4001b8b1
+		>;
+	};
 
-		pinctrl_pcie: pciegrp {
-			fsl,pins = <
-				MX6QDL_PAD_GPIO_17__GPIO7_IO12        0x17059
-			>;
-		};
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_3__I2C3_SCL           0x4001b8b1
+			MX6QDL_PAD_GPIO_6__I2C3_SDA           0x4001b8b1
+		>;
+	};
 
-		pinctrl_sgtl5000: sgtl5000grp {
-			fsl,pins = <
-				MX6QDL_PAD_CSI0_DAT7__AUD3_RXD        0x130b0
-				MX6QDL_PAD_CSI0_DAT4__AUD3_TXC        0x130b0
-				MX6QDL_PAD_CSI0_DAT5__AUD3_TXD        0x110b0
-				MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS       0x130b0
-				MX6QDL_PAD_GPIO_0__CCM_CLKO1          0x130b0
-			>;
-		};
+	pinctrl_ir: irgrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D18__GPIO3_IO18        0x17059
+		>;
+	};
 
-		pinctrl_spdif: spdifgrp {
-			fsl,pins = <MX6QDL_PAD_GPIO_19__SPDIF_OUT     0x13091
-			>;
-		};
+	pinctrl_pcie: pciegrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_17__GPIO7_IO12        0x17059
+		>;
+	};
 
-		pinctrl_uart1: uart1grp {
-			fsl,pins = <
-				MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA  0x1b0b1
-				MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA  0x1b0b1
-			>;
-		};
+	pinctrl_sgtl5000: sgtl5000grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT7__AUD3_RXD        0x130b0
+			MX6QDL_PAD_CSI0_DAT4__AUD3_TXC        0x130b0
+			MX6QDL_PAD_CSI0_DAT5__AUD3_TXD        0x110b0
+			MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS       0x130b0
+			MX6QDL_PAD_GPIO_0__CCM_CLKO1          0x130b0
+		>;
+	};
 
-		pinctrl_uart2: uart2grp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_D26__UART2_TX_DATA     0x1b0b1
-				MX6QDL_PAD_EIM_D27__UART2_RX_DATA     0x1b0b1
-			>;
-		};
+	pinctrl_spdif: spdifgrp {
+		fsl,pins = <MX6QDL_PAD_GPIO_19__SPDIF_OUT     0x13091
+		>;
+	};
 
-		pinctrl_usbotg: usbotggrp {
-			fsl,pins = <
-				MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID     0x17059
-			>;
-		};
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA  0x1b0b1
+			MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA  0x1b0b1
+		>;
+	};
 
-		pinctrl_usdhc2: usdhc2grp {
-			fsl,pins = <
-				MX6QDL_PAD_SD2_CMD__SD2_CMD           0x17059
-				MX6QDL_PAD_SD2_CLK__SD2_CLK           0x10059
-				MX6QDL_PAD_SD2_DAT0__SD2_DATA0        0x17059
-				MX6QDL_PAD_SD2_DAT1__SD2_DATA1        0x17059
-				MX6QDL_PAD_SD2_DAT2__SD2_DATA2        0x17059
-				MX6QDL_PAD_SD2_DAT3__SD2_DATA3        0x17059
-				MX6QDL_PAD_NANDF_D2__GPIO2_IO02       0x17059
-			>;
-		};
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D26__UART2_TX_DATA     0x1b0b1
+			MX6QDL_PAD_EIM_D27__UART2_RX_DATA     0x1b0b1
+		>;
+	};
 
-		pinctrl_usdhc3: usdhc3grp {
-			fsl,pins = <
-				MX6QDL_PAD_SD3_CMD__SD3_CMD           0x17059
-				MX6QDL_PAD_SD3_CLK__SD3_CLK           0x10059
-				MX6QDL_PAD_SD3_DAT0__SD3_DATA0        0x17059
-				MX6QDL_PAD_SD3_DAT1__SD3_DATA1        0x17059
-				MX6QDL_PAD_SD3_DAT2__SD3_DATA2        0x17059
-				MX6QDL_PAD_SD3_DAT3__SD3_DATA3        0x17059
-				MX6QDL_PAD_NANDF_D0__GPIO2_IO00       0x17059
-				MX6QDL_PAD_NANDF_D1__GPIO2_IO01       0x17059
-			>;
-		};
+	pinctrl_usbotg: usbotggrp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID     0x17059
+		>;
+	};
 
-		pinctrl_usdhc4: usdhc4grp {
-			fsl,pins = <
-				MX6QDL_PAD_SD4_CMD__SD4_CMD           0x17059
-				MX6QDL_PAD_SD4_CLK__SD4_CLK           0x10059
-				MX6QDL_PAD_SD4_DAT0__SD4_DATA0        0x17059
-				MX6QDL_PAD_SD4_DAT1__SD4_DATA1        0x17059
-				MX6QDL_PAD_SD4_DAT2__SD4_DATA2        0x17059
-				MX6QDL_PAD_SD4_DAT3__SD4_DATA3        0x17059
-				MX6QDL_PAD_SD4_DAT4__SD4_DATA4        0x17059
-				MX6QDL_PAD_SD4_DAT5__SD4_DATA5        0x17059
-				MX6QDL_PAD_SD4_DAT6__SD4_DATA6        0x17059
-				MX6QDL_PAD_SD4_DAT7__SD4_DATA7        0x17059
-			>;
-		};
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD2_CMD__SD2_CMD           0x17059
+			MX6QDL_PAD_SD2_CLK__SD2_CLK           0x10059
+			MX6QDL_PAD_SD2_DAT0__SD2_DATA0        0x17059
+			MX6QDL_PAD_SD2_DAT1__SD2_DATA1        0x17059
+			MX6QDL_PAD_SD2_DAT2__SD2_DATA2        0x17059
+			MX6QDL_PAD_SD2_DAT3__SD2_DATA3        0x17059
+			MX6QDL_PAD_NANDF_D2__GPIO2_IO02       0x17059
+		>;
 	};
 
-	gpio_fan {
-		pinctrl_gpio_fan: gpiofangrp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_D28__GPIO3_IO28        0x130b1
-			>;
-		};
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_CMD__SD3_CMD           0x17059
+			MX6QDL_PAD_SD3_CLK__SD3_CLK           0x10059
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0        0x17059
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1        0x17059
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2        0x17059
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3        0x17059
+			MX6QDL_PAD_NANDF_D0__GPIO2_IO00       0x17059
+			MX6QDL_PAD_NANDF_D1__GPIO2_IO01       0x17059
+		>;
 	};
 
-	gpio_leds {
-		pinctrl_gpio_leds: gpioledsgrp {
-			fsl,pins = <
-				MX6QDL_PAD_GPIO_2__GPIO1_IO02         0x130b1
-			>;
-		};
+	pinctrl_usdhc4: usdhc4grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_CMD__SD4_CMD           0x17059
+			MX6QDL_PAD_SD4_CLK__SD4_CLK           0x10059
+			MX6QDL_PAD_SD4_DAT0__SD4_DATA0        0x17059
+			MX6QDL_PAD_SD4_DAT1__SD4_DATA1        0x17059
+			MX6QDL_PAD_SD4_DAT2__SD4_DATA2        0x17059
+			MX6QDL_PAD_SD4_DAT3__SD4_DATA3        0x17059
+			MX6QDL_PAD_SD4_DAT4__SD4_DATA4        0x17059
+			MX6QDL_PAD_SD4_DAT5__SD4_DATA5        0x17059
+			MX6QDL_PAD_SD4_DAT6__SD4_DATA6        0x17059
+			MX6QDL_PAD_SD4_DAT7__SD4_DATA7        0x17059
+		>;
 	};
 };
-- 
1.9.1
