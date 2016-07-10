From: uwe@kleine-koenig.org (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sun, 10 Jul 2016 12:07:43 +0200
Subject: [PATCH 3/6] ARM: dts: imx25: substitute NO_PAD_CTL by the respective
 reset value
In-Reply-To: <1468145266-7567-1-git-send-email-uwe@kleine-koenig.org>
References: <1468145266-7567-1-git-send-email-uwe@kleine-koenig.org>
Message-ID: <1468145266-7567-4-git-send-email-uwe@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

When 0x80000000 (aka NO_PAD_CTL) is used as pad config value, the
SW_PAD_CTL register isn't modified. Instead be more explicit here and
specify the reset default value.

If the machines don't depend on bootloader modifications to these
registers (and the tables in the reference manual are right) this commit
doesn't result in different behaviour of the affected machines.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi       | 18 +++----
 .../imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts  |  2 +-
 .../boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts  | 24 ++++-----
 arch/arm/boot/dts/imx25-karo-tx25.dts              | 50 +++++++++---------
 arch/arm/boot/dts/imx25-pdk.dts                    | 60 +++++++++++-----------
 5 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi b/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
index f024a84bd37b..5ba6351d55cf 100644
--- a/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
+++ b/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
@@ -43,22 +43,22 @@
 &iomuxc {
 	pinctrl_fec: fecgrp {
 		fsl,pins = <
-			MX25_PAD_FEC_MDC__FEC_MDC		0x80000000
+			MX25_PAD_FEC_MDC__FEC_MDC		0x00000060
 			MX25_PAD_FEC_MDIO__FEC_MDIO		0x400001e0
-			MX25_PAD_FEC_TDATA0__FEC_TDATA0		0x80000000
-			MX25_PAD_FEC_TDATA1__FEC_TDATA1		0x80000000
-			MX25_PAD_FEC_TX_EN__FEC_TX_EN		0x80000000
-			MX25_PAD_FEC_RDATA0__FEC_RDATA0		0x80000000
-			MX25_PAD_FEC_RDATA1__FEC_RDATA1		0x80000000
-			MX25_PAD_FEC_RX_DV__FEC_RX_DV		0x80000000
+			MX25_PAD_FEC_TDATA0__FEC_TDATA0		0x00000060
+			MX25_PAD_FEC_TDATA1__FEC_TDATA1		0x00000060
+			MX25_PAD_FEC_TX_EN__FEC_TX_EN		0x00000060
+			MX25_PAD_FEC_RDATA0__FEC_RDATA0		0x000000c1
+			MX25_PAD_FEC_RDATA1__FEC_RDATA1		0x000000c0
+			MX25_PAD_FEC_RX_DV__FEC_RX_DV		0x000000c0
 			MX25_PAD_FEC_TX_CLK__FEC_TX_CLK		0x1c0
 		>;
 	};
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
-			MX25_PAD_I2C1_CLK__I2C1_CLK		0x80000000
-			MX25_PAD_I2C1_DAT__I2C1_DAT		0x80000000
+			MX25_PAD_I2C1_CLK__I2C1_CLK		0x000000a8
+			MX25_PAD_I2C1_DAT__I2C1_DAT		0x000000a8
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
index 184778f4335f..f773690da909 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
@@ -59,7 +59,7 @@
 
 &iomuxc {
 	pinctrl_reg_lcd_3v3: reg_lcd_3v3 {
-		fsl,pins = <MX25_PAD_PWM__GPIO_1_26 0x80000000>;
+		fsl,pins = <MX25_PAD_PWM__GPIO_1_26 0x000000c0>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
index 1a4b08df061c..d6681966ee9c 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
@@ -97,11 +97,11 @@
 	};
 
 	pinctrl_gpiokeys: gpiokeysgrp {
-		fsl,pins = <MX25_PAD_VSTBY_ACK__GPIO_3_18 0x80000000>;
+		fsl,pins = <MX25_PAD_VSTBY_ACK__GPIO_3_18 0x00000080>;
 	};
 
 	pinctrl_gpioled: gpioledgrp {
-		fsl,pins = <MX25_PAD_POWER_FAIL__GPIO_3_19 0x80000000>;
+		fsl,pins = <MX25_PAD_POWER_FAIL__GPIO_3_19 0x00000080>;
 	};
 
 	pinctrl_lcdc: lcdcgrp {
@@ -124,11 +124,11 @@
 			MX25_PAD_LD15__LD15			0x0
 			MX25_PAD_GPIO_E__LD16			0x0
 			MX25_PAD_GPIO_F__LD17			0x0
-			MX25_PAD_HSYNC__HSYNC			0x80000000
-			MX25_PAD_VSYNC__VSYNC			0x80000000
-			MX25_PAD_LSCLK__LSCLK			0x80000000
-			MX25_PAD_OE_ACD__OE_ACD			0x80000000
-			MX25_PAD_CONTRAST__CONTRAST		0x80000000
+			MX25_PAD_HSYNC__HSYNC			0x00000060
+			MX25_PAD_VSYNC__VSYNC			0x00000060
+			MX25_PAD_LSCLK__LSCLK			0x00000061
+			MX25_PAD_OE_ACD__OE_ACD			0x00000060
+			MX25_PAD_CONTRAST__CONTRAST		0x00000060
 		>;
 	};
 
@@ -136,17 +136,17 @@
 		fsl,pins = <
 			MX25_PAD_UART1_RTS__UART1_RTS		0xe0
 			MX25_PAD_UART1_CTS__UART1_CTS		0xe0
-			MX25_PAD_UART1_TXD__UART1_TXD		0x80000000
+			MX25_PAD_UART1_TXD__UART1_TXD		0x00000020
 			MX25_PAD_UART1_RXD__UART1_RXD		0x00000080
 		>;
 	};
 
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
-			MX25_PAD_UART2_RXD__UART2_RXD		0x80000000
-			MX25_PAD_UART2_TXD__UART2_TXD		0x80000000
-			MX25_PAD_UART2_RTS__UART2_RTS		0x80000000
-			MX25_PAD_UART2_CTS__UART2_CTS		0x80000000
+			MX25_PAD_UART2_RXD__UART2_RXD		0x000000e0
+			MX25_PAD_UART2_TXD__UART2_TXD		0x00000060
+			MX25_PAD_UART2_RTS__UART2_RTS		0x000000e0
+			MX25_PAD_UART2_CTS__UART2_CTS		0x00000060
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx25-karo-tx25.dts b/arch/arm/boot/dts/imx25-karo-tx25.dts
index 9b31faa96377..c622c342efa0 100644
--- a/arch/arm/boot/dts/imx25-karo-tx25.dts
+++ b/arch/arm/boot/dts/imx25-karo-tx25.dts
@@ -44,46 +44,46 @@
 &iomuxc {
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
-			MX25_PAD_UART1_TXD__UART1_TXD 0x80000000
-			MX25_PAD_UART1_RXD__UART1_RXD 0x80000000
-			MX25_PAD_UART1_CTS__UART1_CTS 0x80000000
-			MX25_PAD_UART1_RTS__UART1_RTS 0x80000000
+			MX25_PAD_UART1_TXD__UART1_TXD 0x00000020
+			MX25_PAD_UART1_RXD__UART1_RXD 0x000000a0
+			MX25_PAD_UART1_CTS__UART1_CTS 0x00000060
+			MX25_PAD_UART1_RTS__UART1_RTS 0x000000e0
 		>;
 	};
 
 	pinctrl_fec: fecgrp {
 		fsl,pins = <
-			MX25_PAD_D11__GPIO_4_9		0x80000000 /* FEC PHY power on pin */
-			MX25_PAD_D13__GPIO_4_7		0x80000000 /* FEC reset */
-			MX25_PAD_FEC_MDC__FEC_MDC	0x80000000
-			MX25_PAD_FEC_MDIO__FEC_MDIO	0x80000000
-			MX25_PAD_FEC_TDATA0__FEC_TDATA0	0x80000000
-			MX25_PAD_FEC_TDATA1__FEC_TDATA1	0x80000000
-			MX25_PAD_FEC_TX_EN__FEC_TX_EN	0x80000000
-			MX25_PAD_FEC_RDATA0__FEC_RDATA0	0x80000000
-			MX25_PAD_FEC_RDATA1__FEC_RDATA1	0x80000000
-			MX25_PAD_FEC_RX_DV__FEC_RX_DV	0x80000000
-			MX25_PAD_FEC_TX_CLK__FEC_TX_CLK	0x80000000
+			MX25_PAD_D11__GPIO_4_9		0x00000021 /* FEC PHY power on pin */
+			MX25_PAD_D13__GPIO_4_7		0x000000a1 /* FEC reset */
+			MX25_PAD_FEC_MDC__FEC_MDC	0x00000060
+			MX25_PAD_FEC_MDIO__FEC_MDIO	0x000001f0
+			MX25_PAD_FEC_TDATA0__FEC_TDATA0	0x00000060
+			MX25_PAD_FEC_TDATA1__FEC_TDATA1	0x00000060
+			MX25_PAD_FEC_TX_EN__FEC_TX_EN	0x00000060
+			MX25_PAD_FEC_RDATA0__FEC_RDATA0	0x000000c1
+			MX25_PAD_FEC_RDATA1__FEC_RDATA1	0x000000c0
+			MX25_PAD_FEC_RX_DV__FEC_RX_DV	0x000000c0
+			MX25_PAD_FEC_TX_CLK__FEC_TX_CLK	0x000000c0
 		>;
 	};
 
 	pinctrl_nfc: nfcgrp {
 		fsl,pins = <
-			MX25_PAD_NF_CE0__NF_CE0		0x80000000
+			MX25_PAD_NF_CE0__NF_CE0		0x00000001
 			MX25_PAD_NFWE_B__NFWE_B		0x80000000
 			MX25_PAD_NFRE_B__NFRE_B		0x80000000
 			MX25_PAD_NFALE__NFALE		0x80000000
 			MX25_PAD_NFCLE__NFCLE		0x80000000
 			MX25_PAD_NFWP_B__NFWP_B		0x80000000
-			MX25_PAD_NFRB__NFRB		0x80000000
-			MX25_PAD_D7__D7			0x80000000
-			MX25_PAD_D6__D6			0x80000000
-			MX25_PAD_D5__D5			0x80000000
-			MX25_PAD_D4__D4			0x80000000
-			MX25_PAD_D3__D3			0x80000000
-			MX25_PAD_D2__D2			0x80000000
-			MX25_PAD_D1__D1			0x80000000
-			MX25_PAD_D0__D0			0x80000000
+			MX25_PAD_NFRB__NFRB		0x00000080
+			MX25_PAD_D7__D7			0x00000000
+			MX25_PAD_D6__D6			0x00000000
+			MX25_PAD_D5__D5			0x00000000
+			MX25_PAD_D4__D4			0x00000000
+			MX25_PAD_D3__D3			0x00000000
+			MX25_PAD_D2__D2			0x00000000
+			MX25_PAD_D1__D1			0x00000000
+			MX25_PAD_D0__D0			0x00000000
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index c823e45a7a01..643d083951ef 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -158,56 +158,56 @@
 		fsl,pins = <
 			MX25_PAD_GPIO_A__CAN1_TX		0x0
 			MX25_PAD_GPIO_B__CAN1_RX		0x0
-			MX25_PAD_D14__GPIO_4_6 			0x80000000
+			MX25_PAD_D14__GPIO_4_6 			0x000000a1
 		>;
 	};
 
 	pinctrl_esdhc1: esdhc1grp {
 		fsl,pins = <
-			MX25_PAD_SD1_CMD__SD1_CMD		0x80000000
-			MX25_PAD_SD1_CLK__SD1_CLK		0x80000000
-			MX25_PAD_SD1_DATA0__SD1_DATA0		0x80000000
-			MX25_PAD_SD1_DATA1__SD1_DATA1		0x80000000
-			MX25_PAD_SD1_DATA2__SD1_DATA2		0x80000000
-			MX25_PAD_SD1_DATA3__SD1_DATA3		0x80000000
-			MX25_PAD_A14__GPIO_2_0			0x80000000
-			MX25_PAD_A15__GPIO_2_1			0x80000000
+			MX25_PAD_SD1_CMD__SD1_CMD		0x000000d1
+			MX25_PAD_SD1_CLK__SD1_CLK		0x000000d1
+			MX25_PAD_SD1_DATA0__SD1_DATA0		0x000000d1
+			MX25_PAD_SD1_DATA1__SD1_DATA1		0x000000d1
+			MX25_PAD_SD1_DATA2__SD1_DATA2		0x000000d1
+			MX25_PAD_SD1_DATA3__SD1_DATA3		0x000000d1
+			MX25_PAD_A14__GPIO_2_0			0x00000080
+			MX25_PAD_A15__GPIO_2_1			0x00000080
 		>;
 	};
 
 	pinctrl_fec: fecgrp {
 		fsl,pins = <
-			MX25_PAD_FEC_MDC__FEC_MDC		0x80000000
+			MX25_PAD_FEC_MDC__FEC_MDC		0x00000060
 			MX25_PAD_FEC_MDIO__FEC_MDIO		0x400001e0
-			MX25_PAD_FEC_TDATA0__FEC_TDATA0		0x80000000
-			MX25_PAD_FEC_TDATA1__FEC_TDATA1		0x80000000
-			MX25_PAD_FEC_TX_EN__FEC_TX_EN		0x80000000
-			MX25_PAD_FEC_RDATA0__FEC_RDATA0		0x80000000
-			MX25_PAD_FEC_RDATA1__FEC_RDATA1		0x80000000
-			MX25_PAD_FEC_RX_DV__FEC_RX_DV		0x80000000
-			MX25_PAD_FEC_TX_CLK__FEC_TX_CLK		0x1c0
-			MX25_PAD_A17__GPIO_2_3			0x80000000
-			MX25_PAD_D12__GPIO_4_8			0x80000000
+			MX25_PAD_FEC_TDATA0__FEC_TDATA0		0x00000060
+			MX25_PAD_FEC_TDATA1__FEC_TDATA1		0x00000060
+			MX25_PAD_FEC_TX_EN__FEC_TX_EN		0x00000060
+			MX25_PAD_FEC_RDATA0__FEC_RDATA0		0x000000c1
+			MX25_PAD_FEC_RDATA1__FEC_RDATA1		0x000000c0
+			MX25_PAD_FEC_RX_DV__FEC_RX_DV		0x000000c0
+			MX25_PAD_FEC_TX_CLK__FEC_TX_CLK		0x000001c0
+			MX25_PAD_A17__GPIO_2_3			0x00000000
+			MX25_PAD_D12__GPIO_4_8			0x000000a1
 		>;
 	};
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
-			MX25_PAD_I2C1_CLK__I2C1_CLK		0x80000000
-			MX25_PAD_I2C1_DAT__I2C1_DAT		0x80000000
+			MX25_PAD_I2C1_CLK__I2C1_CLK		0x000000a8
+			MX25_PAD_I2C1_DAT__I2C1_DAT		0x000000a8
 		>;
 	};
 
 	pinctrl_kpp: kppgrp {
 		fsl,pins = <
-			MX25_PAD_KPP_ROW0__KPP_ROW0	0x80000000
-			MX25_PAD_KPP_ROW1__KPP_ROW1	0x80000000
-			MX25_PAD_KPP_ROW2__KPP_ROW2	0x80000000
-			MX25_PAD_KPP_ROW3__KPP_ROW3	0x80000000
-			MX25_PAD_KPP_COL0__KPP_COL0	0x80000000
-			MX25_PAD_KPP_COL1__KPP_COL1	0x80000000
-			MX25_PAD_KPP_COL2__KPP_COL2	0x80000000
-			MX25_PAD_KPP_COL3__KPP_COL3	0x80000000
+			MX25_PAD_KPP_ROW0__KPP_ROW0		0x000000a0
+			MX25_PAD_KPP_ROW1__KPP_ROW1		0x000000a0
+			MX25_PAD_KPP_ROW2__KPP_ROW2		0x000000e0
+			MX25_PAD_KPP_ROW3__KPP_ROW3		0x000000e0
+			MX25_PAD_KPP_COL0__KPP_COL0		0x000000a8
+			MX25_PAD_KPP_COL1__KPP_COL1		0x000000a8
+			MX25_PAD_KPP_COL2__KPP_COL2		0x000000a8
+			MX25_PAD_KPP_COL3__KPP_COL3		0x000000a8
 		>;
 	};
 
@@ -243,7 +243,7 @@
 		fsl,pins = <
 			MX25_PAD_UART1_RTS__UART1_RTS		0xe0
 			MX25_PAD_UART1_CTS__UART1_CTS		0xe0
-			MX25_PAD_UART1_TXD__UART1_TXD		0x80000000
+			MX25_PAD_UART1_TXD__UART1_TXD		0x00000020
 			MX25_PAD_UART1_RXD__UART1_RXD		0x80
 		>;
 	};
-- 
2.8.1
