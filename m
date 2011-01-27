From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 27 Jan 2011 14:00:21 +0100
Subject: [PATCH 01/13] ARM i.MX35 pcm043: remove unnecessary CONFIG_I2C ifdefs
In-Reply-To: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
References: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296133233-1062-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/mach-pcm043.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index bcf83fc..a27022d 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -115,7 +115,6 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-#if defined CONFIG_I2C_IMX || defined CONFIG_I2C_IMX_MODULE
 static const struct imxi2c_platform_data pcm043_i2c0_data __initconst = {
 	.bitrate = 50000,
 };
@@ -134,7 +133,6 @@ static struct i2c_board_info pcm043_i2c_devices[] = {
 		I2C_BOARD_INFO("pcf8563", 0x51),
 	}
 };
-#endif
 
 static struct platform_device *devices[] __initdata = {
 	&pcm043_flash,
@@ -369,12 +367,10 @@ static void __init mxc_board_init(void)
 
 	imx35_add_imx_uart1(&uart_pdata);
 
-#if defined CONFIG_I2C_IMX || defined CONFIG_I2C_IMX_MODULE
 	i2c_register_board_info(0, pcm043_i2c_devices,
 			ARRAY_SIZE(pcm043_i2c_devices));
 
 	imx35_add_imx_i2c0(&pcm043_i2c0_data);
-#endif
 
 	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
 	mxc_register_device(&mx3_fb, &mx3fb_pdata);
-- 
1.7.2.3
