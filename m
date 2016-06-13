From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 13 Jun 2016 12:17:54 +0200
Subject: [PATCH 1/2] ARM: imx25-pinfunc: document SION being important for
 MX25_PAD_SD1_CMD__SD1_CMD
In-Reply-To: <20160613101616.GK26768@pengutronix.de>
References: <20160613101616.GK26768@pengutronix.de>
Message-ID: <1465813075-13071-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/imx25-pinfunc.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx25-pinfunc.h b/arch/arm/boot/dts/imx25-pinfunc.h
index f96fa2df8f11..953e646f3ea1 100644
--- a/arch/arm/boot/dts/imx25-pinfunc.h
+++ b/arch/arm/boot/dts/imx25-pinfunc.h
@@ -421,6 +421,15 @@
 #define MX25_PAD_UART2_CTS__FEC_RX_ERR		0x18c 0x384 0x518 0x12 0x002
 #define MX25_PAD_UART2_CTS__GPIO_4_29		0x18c 0x384 0x000 0x15 0x000
 
+/*
+ * Removing the SION bit from MX25_PAD_SD1_CMD__SD1_CMD breaks detecting an SD
+ * card. According to the i.MX25 reference manual (e.g. Figure 23-2 in IMX25RM
+ * Rev. 2 from 01/2011) this pin is bidirectional. So it seems to be a silicon
+ * bug that configuring the SD1_CMD function doesn't enable the input path for
+ * this pin.
+ * This might have side effects for other hardware units that are connected to
+ * that pin and use the respective function as input.
+ */
 #define MX25_PAD_SD1_CMD__SD1_CMD		0x190 0x388 0x000 0x10 0x000
 #define MX25_PAD_SD1_CMD__CSPI2_MOSI		0x190 0x388 0x4a0 0x11 0x001
 #define MX25_PAD_SD1_CMD__FEC_RDATA2		0x190 0x388 0x50c 0x12 0x002
-- 
2.8.1
