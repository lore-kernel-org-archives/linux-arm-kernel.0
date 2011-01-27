From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 27 Jan 2011 17:19:03 +0800
Subject: [PATCH 1/2] ARM: imx53_loco: remove inavailable uart device and
	remove rts/cts support
Message-ID: <1296119944-30485-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx53_loco board only have one uart and the uart don't export rts/cts lines.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/mach-mx5/board-mx53_loco.c |   20 +-------------------
 1 files changed, 1 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index d1348e0..d0ca65b 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -41,29 +41,11 @@
 static iomux_v3_cfg_t mx53_loco_pads[] = {
 	MX53_PAD_CSI0_D10__UART1_TXD,
 	MX53_PAD_CSI0_D11__UART1_RXD,
-	MX53_PAD_ATA_DIOW__UART1_TXD,
-	MX53_PAD_ATA_DMACK__UART1_RXD,
-
-	MX53_PAD_ATA_BUFFER_EN__UART2_RXD,
-	MX53_PAD_ATA_DMARQ__UART2_TXD,
-	MX53_PAD_ATA_DIOR__UART2_RTS,
-	MX53_PAD_ATA_INTRQ__UART2_CTS,
-
-	MX53_PAD_ATA_CS_0__UART3_TXD,
-	MX53_PAD_ATA_CS_1__UART3_RXD,
-	MX53_PAD_ATA_DA_1__UART3_CTS,
-	MX53_PAD_ATA_DA_2__UART3_RTS,
-};
-
-static const struct imxuart_platform_data mx53_loco_uart_data __initconst = {
-	.flags = IMXUART_HAVE_RTSCTS,
 };
 
 static inline void mx53_loco_init_uart(void)
 {
-	imx53_add_imx_uart(0, &mx53_loco_uart_data);
-	imx53_add_imx_uart(1, &mx53_loco_uart_data);
-	imx53_add_imx_uart(2, &mx53_loco_uart_data);
+	imx53_add_imx_uart(0, NULL);
 }
 
 static inline void mx53_loco_fec_reset(void)
-- 
1.6.3.3
