From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 2 Mar 2011 13:30:53 -0300
Subject: [PATCH 2/2] ARM: mx5/mx53_evk: Fix IOMUX for UART3
In-Reply-To: <1299083453-29431-1-git-send-email-fabio.estevam@freescale.com>
References: <1299083453-29431-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1299083453-29431-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On mx53_evk board only RX/TX pins are used on UART3.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/board-mx53_evk.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index 652e1e0..7b5735c 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -52,8 +52,6 @@ static iomux_v3_cfg_t mx53_evk_pads[] = {
 
 	MX53_PAD_PATA_CS_0__UART3_TXD_MUX,
 	MX53_PAD_PATA_CS_1__UART3_RXD_MUX,
-	MX53_PAD_PATA_DA_1__UART3_CTS,
-	MX53_PAD_PATA_DA_2__UART3_RTS,
 
 	MX53_PAD_EIM_D16__ECSPI1_SCLK,
 	MX53_PAD_EIM_D17__ECSPI1_MISO,
@@ -72,7 +70,7 @@ static inline void mx53_evk_init_uart(void)
 {
 	imx53_add_imx_uart(0, NULL);
 	imx53_add_imx_uart(1, &mx53_evk_uart_pdata);
-	imx53_add_imx_uart(2, &mx53_evk_uart_pdata);
+	imx53_add_imx_uart(2, NULL);
 }
 
 static const struct imxi2c_platform_data mx53_evk_i2c_data __initconst = {
-- 
1.6.0.4
