From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 2 Mar 2011 13:30:52 -0300
Subject: [PATCH 1/2] ARM: mx5/mx53_smd: Fix IOMUX for UART2
Message-ID: <1299083453-29431-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On mx53_smd board only RX/TX pins are used on UART2.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/board-mx53_smd.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
index 5eb1638..31e1732 100644
--- a/arch/arm/mach-mx5/board-mx53_smd.c
+++ b/arch/arm/mach-mx5/board-mx53_smd.c
@@ -44,8 +44,6 @@ static iomux_v3_cfg_t mx53_smd_pads[] = {
 
 	MX53_PAD_PATA_BUFFER_EN__UART2_RXD_MUX,
 	MX53_PAD_PATA_DMARQ__UART2_TXD_MUX,
-	MX53_PAD_PATA_DIOR__UART2_RTS,
-	MX53_PAD_PATA_INTRQ__UART2_CTS,
 
 	MX53_PAD_PATA_CS_0__UART3_TXD_MUX,
 	MX53_PAD_PATA_CS_1__UART3_RXD_MUX,
@@ -63,7 +61,7 @@ static const struct imxuart_platform_data mx53_smd_uart_data __initconst = {
 static inline void mx53_smd_init_uart(void)
 {
 	imx53_add_imx_uart(0, NULL);
-	imx53_add_imx_uart(1, &mx53_smd_uart_data);
+	imx53_add_imx_uart(1, NULL);
 	imx53_add_imx_uart(2, &mx53_smd_uart_data);
 }
 
-- 
1.6.0.4
