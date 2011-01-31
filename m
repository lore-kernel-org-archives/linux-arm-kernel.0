From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 31 Jan 2011 10:32:27 -0200
Subject: [PATCH] ARM: mx5/board-mx53_smd.c: Make UART1 functional
Message-ID: <1296477147-7431-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix UART1 IOMUX settings and configure UART1 to work with only RX/TX pins.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/board-mx53_smd.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
index 06070c5..c7b45d4 100644
--- a/arch/arm/mach-mx5/board-mx53_smd.c
+++ b/arch/arm/mach-mx5/board-mx53_smd.c
@@ -41,8 +41,6 @@
 static iomux_v3_cfg_t mx53_smd_pads[] = {
 	MX53_PAD_CSI0_DAT10__UART1_TXD_MUX,
 	MX53_PAD_CSI0_DAT11__UART1_RXD_MUX,
-	MX53_PAD_PATA_DIOW__UART1_TXD_MUX,
-	MX53_PAD_PATA_DMACK__UART1_RXD_MUX,
 
 	MX53_PAD_PATA_BUFFER_EN__UART2_RXD_MUX,
 	MX53_PAD_PATA_DMARQ__UART2_TXD_MUX,
@@ -61,7 +59,7 @@ static const struct imxuart_platform_data mx53_smd_uart_data __initconst = {
 
 static inline void mx53_smd_init_uart(void)
 {
-	imx53_add_imx_uart(0, &mx53_smd_uart_data);
+	imx53_add_imx_uart(0, NULL);
 	imx53_add_imx_uart(1, &mx53_smd_uart_data);
 	imx53_add_imx_uart(2, &mx53_smd_uart_data);
 }
-- 
1.6.0.4
