From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sat, 21 Feb 2015 15:31:22 +0100
Subject: [PATCH 1/2] ARM: imx25: fix some wrong iomux definitions
Message-ID: <1424529083-25159-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Noticed while looking over the pad definitions. None of the bogus
definitions is used in-tree.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/imx25-pinfunc.h | 12 ++++++------
 arch/arm/mach-imx/iomux-mx25.h    | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-pinfunc.h b/arch/arm/boot/dts/imx25-pinfunc.h
index 88eebb15da6a..957cf506e066 100644
--- a/arch/arm/boot/dts/imx25-pinfunc.h
+++ b/arch/arm/boot/dts/imx25-pinfunc.h
@@ -40,7 +40,7 @@
 #define MX25_PAD_A18__FEC_COL			0x020 0x23c 0x504 0x17 0x000
 
 #define MX25_PAD_A19__A19			0x024 0x240 0x000 0x10 0x000
-#define MX25_PAD_A19__FEC_RX_ER			0x024 0x240 0x518 0x17 0x000
+#define MX25_PAD_A19__FEC_RX_ERR		0x024 0x240 0x518 0x17 0x000
 #define MX25_PAD_A19__GPIO_2_5			0x024 0x240 0x000 0x15 0x000
 
 #define MX25_PAD_A20__A20			0x028 0x244 0x000 0x10 0x000
@@ -217,7 +217,7 @@
 #define MX25_PAD_LD9__FEC_COL			0x0ec 0x2e4 0x504 0x15 0x001
 
 #define MX25_PAD_LD10__LD10			0x0f0 0x2e8 0x000 0x10 0x000
-#define MX25_PAD_LD10__FEC_RX_ER		0x0f0 0x2e8 0x518 0x15 0x001
+#define MX25_PAD_LD10__FEC_RX_ERR		0x0f0 0x2e8 0x518 0x15 0x001
 
 #define MX25_PAD_LD11__LD11			0x0f4 0x2ec 0x000 0x10 0x000
 #define MX25_PAD_LD11__FEC_RDATA2		0x0f4 0x2ec 0x50c 0x15 0x001
@@ -369,7 +369,7 @@
 #define MX25_PAD_UART2_RTS__CC1			0x188 0x380 0x000 0x13 0x000
 #define MX25_PAD_UART2_RTS__GPIO_4_28		0x188 0x380 0x000 0x15 0x000
 
-#define MX25_PAD_UART2_CTS__FEC_RX_ER		0x18c 0x384 0x518 0x12 0x002
+#define MX25_PAD_UART2_CTS__FEC_RX_ERR		0x18c 0x384 0x518 0x12 0x002
 #define MX25_PAD_UART2_CTS__UART2_CTS		0x18c 0x384 0x000 0x10 0x000
 #define MX25_PAD_UART2_CTS__GPIO_4_29		0x18c 0x384 0x000 0x15 0x000
 
@@ -392,11 +392,11 @@
 #define MX25_PAD_SD1_DATA1__GPIO_2_26		0x19c 0x394 0x000 0x15 0x000
 
 #define MX25_PAD_SD1_DATA2__SD1_DATA2		0x1a0 0x398 0x000 0x10 0x000
-#define MX25_PAD_SD1_DATA2__FEC_RX_CLK		0x1a0 0x398 0x514 0x15 0x002
+#define MX25_PAD_SD1_DATA2__FEC_RX_CLK		0x1a0 0x398 0x514 0x12 0x002
 #define MX25_PAD_SD1_DATA2__GPIO_2_27		0x1a0 0x398 0x000 0x15 0x000
 
 #define MX25_PAD_SD1_DATA3__SD1_DATA3		0x1a4 0x39c 0x000 0x10 0x000
-#define MX25_PAD_SD1_DATA3__FEC_CRS		0x1a4 0x39c 0x508 0x10 0x002
+#define MX25_PAD_SD1_DATA3__FEC_CRS		0x1a4 0x39c 0x508 0x12 0x002
 #define MX25_PAD_SD1_DATA3__GPIO_2_28		0x1a4 0x39c 0x000 0x15 0x000
 
 #define MX25_PAD_KPP_ROW0__KPP_ROW0		0x1a8 0x3a0 0x000 0x10 0x000
@@ -410,7 +410,7 @@
 #define MX25_PAD_KPP_ROW2__GPIO_2_31		0x1b0 0x3a8 0x000 0x15 0x000
 
 #define MX25_PAD_KPP_ROW3__KPP_ROW3		0x1b4 0x3ac 0x000 0x10 0x000
-#define MX25_PAD_KPP_ROW3__CSI_LD1		0x1b4 0x3ac 0x48c 0x13 0x002
+#define MX25_PAD_KPP_ROW3__CSI_D1		0x1b4 0x3ac 0x48c 0x13 0x002
 #define MX25_PAD_KPP_ROW3__GPIO_3_0		0x1b4 0x3ac 0x000 0x15 0x000
 
 #define MX25_PAD_KPP_COL0__KPP_COL0		0x1b8 0x3b0 0x000 0x10 0x000
diff --git a/arch/arm/mach-imx/iomux-mx25.h b/arch/arm/mach-imx/iomux-mx25.h
index be51e838375c..12764fc3ecc4 100644
--- a/arch/arm/mach-imx/iomux-mx25.h
+++ b/arch/arm/mach-imx/iomux-mx25.h
@@ -48,7 +48,7 @@
 #define MX25_PAD_A18__FEC_COL		IOMUX_PAD(0x23c, 0x020, 0x17, 0x504, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_A19__A19		IOMUX_PAD(0x240, 0x024, 0x10, 0, 0, NO_PAD_CTRL)
-#define MX25_PAD_A19__FEC_RX_ER		IOMUX_PAD(0x240, 0x024, 0x17, 0x518, 0, NO_PAD_CTRL)
+#define MX25_PAD_A19__FEC_RX_ERR	IOMUX_PAD(0x240, 0x024, 0x17, 0x518, 0, NO_PAD_CTRL)
 #define MX25_PAD_A19__GPIO_2_5		IOMUX_PAD(0x240, 0x024, 0x15, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_A20__A20		IOMUX_PAD(0x244, 0x028, 0x10, 0, 0, NO_PAD_CTRL)
@@ -225,7 +225,7 @@
 #define MX25_PAD_LD9__FEC_COL		IOMUX_PAD(0x2e4, 0x0ec, 0x15, 0x504, 1, NO_PAD_CTRL)
 
 #define MX25_PAD_LD10__LD10		IOMUX_PAD(0x2e8, 0x0f0, 0x10, 0, 0, PAD_CTL_SRE_FAST)
-#define MX25_PAD_LD10__FEC_RX_ER	IOMUX_PAD(0x2e8, 0x0f0, 0x15, 0x518, 1, NO_PAD_CTRL)
+#define MX25_PAD_LD10__FEC_RX_ERR	IOMUX_PAD(0x2e8, 0x0f0, 0x15, 0x518, 1, NO_PAD_CTRL)
 
 #define MX25_PAD_LD11__LD11		IOMUX_PAD(0x2ec, 0x0f4, 0x10, 0, 0, PAD_CTL_SRE_FAST)
 #define MX25_PAD_LD11__FEC_RDATA2	IOMUX_PAD(0x2ec, 0x0f4, 0x15, 0x50c, 1, NO_PAD_CTRL)
@@ -352,7 +352,7 @@
 #define MX25_PAD_UART2_RTS__FEC_COL	IOMUX_PAD(0x380, 0x188, 0x12, 0x504, 2, NO_PAD_CTRL)
 #define MX25_PAD_UART2_RTS__GPIO_4_28	IOMUX_PAD(0x380, 0x188, 0x15, 0, 0, NO_PAD_CTRL)
 
-#define MX25_PAD_UART2_CTS__FEC_RX_ER	IOMUX_PAD(0x384, 0x18c, 0x12, 0x518, 2, NO_PAD_CTRL)
+#define MX25_PAD_UART2_CTS__FEC_RX_ERR	IOMUX_PAD(0x384, 0x18c, 0x12, 0x518, 2, NO_PAD_CTRL)
 #define MX25_PAD_UART2_CTS__UART2_CTS	IOMUX_PAD(0x384, 0x18c, 0x10, 0, 0, NO_PAD_CTRL)
 #define MX25_PAD_UART2_CTS__GPIO_4_29	IOMUX_PAD(0x384, 0x18c, 0x15, 0, 0, NO_PAD_CTRL)
 
@@ -372,11 +372,11 @@
 #define MX25_PAD_SD1_DATA1__GPIO_2_26	IOMUX_PAD(0x394, 0x19c, 0x15, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_SD1_DATA2__SD1_DATA2	IOMUX_PAD(0x398, 0x1a0, 0x10, 0, 0, PAD_CTL_PUS_47K_UP)
-#define MX25_PAD_SD1_DATA2__FEC_RX_CLK	IOMUX_PAD(0x398, 0x1a0, 0x15, 0x514, 2, NO_PAD_CTRL)
+#define MX25_PAD_SD1_DATA2__FEC_RX_CLK	IOMUX_PAD(0x398, 0x1a0, 0x12, 0x514, 2, NO_PAD_CTRL)
 #define MX25_PAD_SD1_DATA2__GPIO_2_27	IOMUX_PAD(0x398, 0x1a0, 0x15, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_SD1_DATA3__SD1_DATA3	IOMUX_PAD(0x39c, 0x1a4, 0x10, 0, 0, PAD_CTL_PUS_47K_UP)
-#define MX25_PAD_SD1_DATA3__FEC_CRS	IOMUX_PAD(0x39c, 0x1a4, 0x10, 0x508, 2, NO_PAD_CTRL)
+#define MX25_PAD_SD1_DATA3__FEC_CRS	IOMUX_PAD(0x39c, 0x1a4, 0x12, 0x508, 2, NO_PAD_CTRL)
 #define MX25_PAD_SD1_DATA3__GPIO_2_28	IOMUX_PAD(0x39c, 0x1a4, 0x15, 0, 0, NO_PAD_CTRL)
 
 #define KPP_CTL_ROW	(PAD_CTL_PKE | PAD_CTL_PUE | PAD_CTL_PUS_100K_UP)
@@ -393,7 +393,7 @@
 #define MX25_PAD_KPP_ROW2__GPIO_2_31	IOMUX_PAD(0x3a8, 0x1b0, 0x15, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_KPP_ROW3__KPP_ROW3	IOMUX_PAD(0x3ac, 0x1b4, 0x10, 0, 0, KPP_CTL_ROW)
-#define MX25_PAD_KPP_ROW3__CSI_LD1	IOMUX_PAD(0x3ac, 0x1b4, 0x13, 0x48c, 2, NO_PAD_CTRL)
+#define MX25_PAD_KPP_ROW3__CSI_D1	IOMUX_PAD(0x3ac, 0x1b4, 0x13, 0x48c, 2, NO_PAD_CTRL)
 #define MX25_PAD_KPP_ROW3__GPIO_3_0	IOMUX_PAD(0x3ac, 0x1b4, 0x15, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_KPP_COL0__KPP_COL0	IOMUX_PAD(0x3b0, 0x1b8, 0x10, 0, 0, KPP_CTL_COL)
-- 
2.1.4
