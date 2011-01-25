From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 25 Jan 2011 13:08:34 -0200
Subject: [PATCH 2/3] ARM: mach-mx5/board-mx53_loco: Make UART1 functional
In-Reply-To: <1295968115-11447-1-git-send-email-fabio.estevam@freescale.com>
References: <1295968115-11447-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1295968115-11447-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix IOMUX settings for UART1 and make UART1 functional.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/board-mx53_loco.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index dadc856..cba4cd5 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -41,8 +41,6 @@
 static iomux_v3_cfg_t mx53_loco_pads[] = {
 	MX53_PAD_CSI0_DAT10__UART1_TXD_MUX,
 	MX53_PAD_CSI0_DAT11__UART1_RXD_MUX,
-	MX53_PAD_PATA_DIOW__UART1_TXD_MUX,
-	MX53_PAD_PATA_DMACK__UART1_RXD_MUX,
 
 	MX53_PAD_PATA_BUFFER_EN__UART2_RXD_MUX,
 	MX53_PAD_PATA_DMARQ__UART2_TXD_MUX,
@@ -62,7 +60,7 @@ static const struct imxuart_platform_data mx53_loco_uart_data __initconst = {
 
 static inline void mx53_loco_init_uart(void)
 {
-	imx53_add_imx_uart(0, &mx53_loco_uart_data);
+	imx53_add_imx_uart(0, NULL);
 	imx53_add_imx_uart(1, &mx53_loco_uart_data);
 	imx53_add_imx_uart(2, &mx53_loco_uart_data);
 }
-- 
1.6.0.4
