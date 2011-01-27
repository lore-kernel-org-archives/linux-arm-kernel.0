From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 27 Jan 2011 14:00:30 +0100
Subject: [PATCH 10/13] ARM i.MX51 mx51 babbage: remove unnecessary
	CONFIG_SERIAL_IMX ifdefs
In-Reply-To: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
References: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296133233-1062-11-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx5/board-mx51_babbage.c |   19 +++++--------------
 1 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 1d231e8..d9d402e 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -161,23 +161,10 @@ static iomux_v3_cfg_t mx51babbage_pads[] = {
 };
 
 /* Serial ports */
-#if defined(CONFIG_SERIAL_IMX) || defined(CONFIG_SERIAL_IMX_MODULE)
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-static inline void mxc_init_imx_uart(void)
-{
-	imx51_add_imx_uart(0, &uart_pdata);
-	imx51_add_imx_uart(1, &uart_pdata);
-	imx51_add_imx_uart(2, &uart_pdata);
-}
-#else /* !SERIAL_IMX */
-static inline void mxc_init_imx_uart(void)
-{
-}
-#endif /* SERIAL_IMX */
-
 static const struct imxi2c_platform_data babbage_i2c_data __initconst = {
 	.bitrate = 100000,
 };
@@ -360,7 +347,11 @@ static void __init mxc_board_init(void)
 #endif
 	mxc_iomux_v3_setup_multiple_pads(mx51babbage_pads,
 					ARRAY_SIZE(mx51babbage_pads));
-	mxc_init_imx_uart();
+
+	imx51_add_imx_uart(0, &uart_pdata);
+	imx51_add_imx_uart(1, &uart_pdata);
+	imx51_add_imx_uart(2, &uart_pdata);
+
 	babbage_fec_reset();
 	imx51_add_fec(NULL);
 
-- 
1.7.2.3
