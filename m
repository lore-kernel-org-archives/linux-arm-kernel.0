From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 27 Jan 2011 14:00:29 +0100
Subject: [PATCH 09/13] ARM i.MX51 mx51 3ds: remove unnecessary
	CONFIG_SERIAL_IMX ifdefs
In-Reply-To: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
References: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296133233-1062-10-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx5/board-mx51_3ds.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index 8a0619b..feb2800 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -71,22 +71,13 @@ static iomux_v3_cfg_t mx51_3ds_pads[] = {
 };
 
 /* Serial ports */
-#if defined(CONFIG_SERIAL_IMX) || defined(CONFIG_SERIAL_IMX_MODULE)
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
 static inline void mxc_init_imx_uart(void)
 {
-	imx51_add_imx_uart(0, &uart_pdata);
-	imx51_add_imx_uart(1, &uart_pdata);
-	imx51_add_imx_uart(2, &uart_pdata);
-}
-#else /* !SERIAL_IMX */
-static inline void mxc_init_imx_uart(void)
-{
 }
-#endif /* SERIAL_IMX */
 
 #if defined(CONFIG_KEYBOARD_IMX) || defined(CONFIG_KEYBOARD_IMX_MODULE)
 static int mx51_3ds_board_keymap[] = {
@@ -161,7 +152,10 @@ static void __init mxc_board_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx51_3ds_pads,
 					ARRAY_SIZE(mx51_3ds_pads));
-	mxc_init_imx_uart();
+
+	imx51_add_imx_uart(0, &uart_pdata);
+	imx51_add_imx_uart(1, &uart_pdata);
+	imx51_add_imx_uart(2, &uart_pdata);
 
 	imx51_add_ecspi(1, &mx51_3ds_ecspi2_pdata);
 	spi_register_board_info(mx51_3ds_spi_nor_device,
-- 
1.7.2.3
