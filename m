From: stefan@agner.ch (Stefan Agner)
Date: Thu,  5 May 2016 13:12:24 -0700
Subject: [PATCH] ARM: dts: imx7d-pinfunc: add input mux for UART2 RX DTE mode
Message-ID: <1462479144-2481-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add input mux for UART2 RX in DTE mode. This allows to use the pad
UART2_TX_DATA_ALT0 as UART2 RX. This particular input select seems
to be missing in current reference manuals (Rev. B), but when looking
at the tables and other UART input select registers (e.g. UART3) it
seems naturally that this input mux register also has a fourth pad
option for UART2_TX_DATA_ALT0. It has also been proven to be required
to use UART2 in DTE mode and the particular pads on the Colibri iMX7
platform.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx7d-pinfunc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7d-pinfunc.h b/arch/arm/boot/dts/imx7d-pinfunc.h
index eeda783..3f9f0d9 100644
--- a/arch/arm/boot/dts/imx7d-pinfunc.h
+++ b/arch/arm/boot/dts/imx7d-pinfunc.h
@@ -594,7 +594,7 @@
 #define MX7D_PAD_UART2_RX_DATA__GPIO4_IO2                         0x0130 0x03A0 0x0000 0x5 0x0
 #define MX7D_PAD_UART2_RX_DATA__ENET2_MDIO                        0x0130 0x03A0 0x0000 0x6 0x0
 #define MX7D_PAD_UART2_TX_DATA__UART2_DCE_TX                      0x0134 0x03A4 0x0000 0x0 0x0
-#define MX7D_PAD_UART2_TX_DATA__UART2_DTE_RX                      0x0134 0x03A4 0x0000 0x0 0x0
+#define MX7D_PAD_UART2_TX_DATA__UART2_DTE_RX                      0x0134 0x03A4 0x06FC 0x0 0x3
 #define MX7D_PAD_UART2_TX_DATA__I2C2_SDA                          0x0134 0x03A4 0x05E0 0x1 0x0
 #define MX7D_PAD_UART2_TX_DATA__SAI3_RX_DATA0                     0x0134 0x03A4 0x06C8 0x2 0x0
 #define MX7D_PAD_UART2_TX_DATA__ECSPI1_RDY                        0x0134 0x03A4 0x0000 0x3 0x0
-- 
2.8.2
