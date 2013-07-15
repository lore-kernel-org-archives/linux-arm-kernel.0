From: denis@eukrea.com (Denis Carikli)
Date: Mon, 15 Jul 2013 16:56:49 +0200
Subject: [PATCH 04/22] arm/dts: imx25.dtsi: Add some pinmux pins.
In-Reply-To: <1373900227-341-1-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
Message-ID: <1373900227-341-5-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uart1, fec, i2c1,esdhc1 and audmux were added.

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/boot/dts/imx25.dtsi |   56 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index f098603..b318106 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -177,6 +177,62 @@
 			iomuxc at 43fac000{
 				compatible = "fsl,imx25-iomuxc";
 				reg = <0x43fac000 0x4000>;
+				audmux {
+					pinctrl_audmux_1: audmuxgrp-1 {
+						fsl,pins = <
+							MX25_PAD_KPP_COL3__AUD5_TXFS 0xe0
+							MX25_PAD_KPP_COL2__AUD5_TXC  0xe0
+							MX25_PAD_KPP_COL1__AUD5_RXD  0xe0
+							MX25_PAD_KPP_COL0__AUD5_TXD  0xe0
+						>;
+					};
+				};
+				uart1 {
+					pinctrl_uart1_1: uartgrp-1 {
+						fsl,pins = <
+							MX25_PAD_UART1_RTS__UART1_RTS 0xe0
+							MX25_PAD_UART1_CTS__UART1_CTS 0xe0
+							MX25_PAD_UART1_TXD__UART1_TXD 0x10000
+							MX25_PAD_UART1_RXD__UART1_RXD 0xc0
+						>;
+					};
+				};
+				fec {
+					pinctrl_fec_1: fecgrp-1 {
+						fsl,pins = <
+							MX25_PAD_FEC_MDC__FEC_MDC       0x10000
+							MX25_PAD_FEC_MDIO__FEC_MDIO     0x1f0
+							MX25_PAD_FEC_TDATA0__FEC_TDATA0 0x10000
+							MX25_PAD_FEC_TDATA1__FEC_TDATA1 0x10000
+							MX25_PAD_FEC_TX_EN__FEC_TX_EN   0x10000
+							MX25_PAD_FEC_RDATA0__FEC_RDATA0 0x100c0
+							MX25_PAD_FEC_RDATA1__FEC_RDATA1 0x100c0
+							MX25_PAD_FEC_RX_DV__FEC_RX_DV   0x100c0
+							MX25_PAD_FEC_TX_CLK__FEC_TX_CLK 0x1c0
+						>;
+					};
+
+				};
+				i2c1 {
+					pinctrl_i2c1_1: i2c1grp-1 {
+						fsl,pins = <
+							MX25_PAD_I2C1_CLK__I2C1_CLK 0x10000
+							MX25_PAD_I2C1_DAT__I2C1_DAT 0x10000
+						>;
+					};
+				};
+				esdhc1 {
+					pinctrl_esdhc1_1: esdhc1grp-1 {
+						fsl,pins = <
+							MX25_PAD_SD1_CMD__SD1_CMD      0xd0
+							MX25_PAD_SD1_CLK__SD1_CLK      0xd0
+							MX25_PAD_SD1_DATA0__SD1_DATA0  0xd0
+							MX25_PAD_SD1_DATA1__SD1_DATA1  0xd0
+							MX25_PAD_SD1_DATA2__SD1_DATA2  0xd0
+							MX25_PAD_SD1_DATA3__SD1_DATA3  0xd0
+						>;
+					};
+				};
 			};
 
 			audmux at 43fb0000 {
-- 
1.7.9.5
