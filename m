From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  5 Jul 2016 22:19:52 +0200
Subject: [PATCH 2/3] ARM: dts: imx25: don't configure reserved pad settings
In-Reply-To: <1467749993-14533-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1467749993-14533-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1467749993-14533-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two dts files specified reserved bits in their pad setting value for
some pins. This commit just unsets the reserved bits, which matches the
hardware behaviour when writing a 1 to a reserved bit.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 .../boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts  | 24 +++++++++++-----------
 arch/arm/boot/dts/imx25-pdk.dts                    | 16 +++++++--------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
index 9efcdad20e73..1a4b08df061c 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
@@ -78,10 +78,10 @@
 &iomuxc {
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
-			MX25_PAD_KPP_COL3__AUD5_TXFS		0xe0
-			MX25_PAD_KPP_COL2__AUD5_TXC		0xe0
-			MX25_PAD_KPP_COL1__AUD5_RXD		0xe0
-			MX25_PAD_KPP_COL0__AUD5_TXD		0xe0
+			MX25_PAD_KPP_COL3__AUD5_TXFS		0x000000a0
+			MX25_PAD_KPP_COL2__AUD5_TXC		0x000000a0
+			MX25_PAD_KPP_COL1__AUD5_RXD		0x000000a0
+			MX25_PAD_KPP_COL0__AUD5_TXD		0x000000a0
 		>;
 	};
 
@@ -106,10 +106,10 @@
 
 	pinctrl_lcdc: lcdcgrp {
 		fsl,pins = <
-			MX25_PAD_LD0__LD0			0x1
-			MX25_PAD_LD1__LD1			0x1
+			MX25_PAD_LD0__LD0			0x0
+			MX25_PAD_LD1__LD1			0x0
 			MX25_PAD_LD2__LD2			0x1
-			MX25_PAD_LD3__LD3			0x1
+			MX25_PAD_LD3__LD3			0x0
 			MX25_PAD_LD4__LD4			0x1
 			MX25_PAD_LD5__LD5			0x1
 			MX25_PAD_LD6__LD6			0x1
@@ -120,10 +120,10 @@
 			MX25_PAD_LD11__LD11			0x1
 			MX25_PAD_LD12__LD12			0x1
 			MX25_PAD_LD13__LD13			0x1
-			MX25_PAD_LD14__LD14			0x1
-			MX25_PAD_LD15__LD15			0x1
-			MX25_PAD_GPIO_E__LD16			0x1
-			MX25_PAD_GPIO_F__LD17			0x1
+			MX25_PAD_LD14__LD14			0x0
+			MX25_PAD_LD15__LD15			0x0
+			MX25_PAD_GPIO_E__LD16			0x0
+			MX25_PAD_GPIO_F__LD17			0x0
 			MX25_PAD_HSYNC__HSYNC			0x80000000
 			MX25_PAD_VSYNC__VSYNC			0x80000000
 			MX25_PAD_LSCLK__LSCLK			0x80000000
@@ -137,7 +137,7 @@
 			MX25_PAD_UART1_RTS__UART1_RTS		0xe0
 			MX25_PAD_UART1_CTS__UART1_CTS		0xe0
 			MX25_PAD_UART1_TXD__UART1_TXD		0x80000000
-			MX25_PAD_UART1_RXD__UART1_RXD		0xc0
+			MX25_PAD_UART1_RXD__UART1_RXD		0x00000080
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index 8b00cfca18ea..c823e45a7a01 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -147,10 +147,10 @@
 &iomuxc {
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
-			MX25_PAD_RW__AUD4_TXFS			0xe0
-			MX25_PAD_OE__AUD4_TXC			0xe0
-			MX25_PAD_EB0__AUD4_TXD			0xe0
-			MX25_PAD_EB1__AUD4_RXD			0xe0
+			MX25_PAD_RW__AUD4_TXFS			0x80
+			MX25_PAD_OE__AUD4_TXC			0x80
+			MX25_PAD_EB0__AUD4_TXD			0x80
+			MX25_PAD_EB1__AUD4_RXD			0x80
 		>;
 	};
 
@@ -227,10 +227,10 @@
 			MX25_PAD_LD11__LD11		0xe0
 			MX25_PAD_LD12__LD12		0xe0
 			MX25_PAD_LD13__LD13		0xe0
-			MX25_PAD_LD14__LD14		0xe0
+			MX25_PAD_LD14__LD14		0xa0
 			MX25_PAD_LD15__LD15		0xe0
-			MX25_PAD_GPIO_E__LD16		0xe0
-			MX25_PAD_GPIO_F__LD17		0xe0
+			MX25_PAD_GPIO_E__LD16		0xa0
+			MX25_PAD_GPIO_F__LD17		0xa0
 			MX25_PAD_HSYNC__HSYNC		0xe0
 			MX25_PAD_VSYNC__VSYNC		0xe0
 			MX25_PAD_LSCLK__LSCLK		0xe0
@@ -244,7 +244,7 @@
 			MX25_PAD_UART1_RTS__UART1_RTS		0xe0
 			MX25_PAD_UART1_CTS__UART1_CTS		0xe0
 			MX25_PAD_UART1_TXD__UART1_TXD		0x80000000
-			MX25_PAD_UART1_RXD__UART1_RXD		0xc0
+			MX25_PAD_UART1_RXD__UART1_RXD		0x80
 		>;
 	};
 };
-- 
2.8.1
