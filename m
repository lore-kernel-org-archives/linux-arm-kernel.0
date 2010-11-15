From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Mon, 15 Nov 2010 10:33:07 -0800 (PST)
Subject: [PATCH] mx51_babbage: Register audio codec in the I2C bus
Message-ID: <64705.71981.qm@web51005.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MX51 Babbage has a SGTL5000 codec connected to I2C2.

Register the codec.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/board-mx51_babbage.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 66b07d8..a0e5a3e 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -342,6 +342,12 @@ static const struct spi_imx_master mx51_babbage_spi_pdata __initconst = {
 	.num_chipselect = ARRAY_SIZE(mx51_babbage_spi_cs),
 };
 
+static struct i2c_board_info mx51_babbage_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("sgtl5000-i2c", 0x0a),
+	},
+};
+
 /*
  * Board specific initialization.
  */
@@ -365,6 +371,8 @@ static void __init mxc_board_init(void)
 	imx51_add_gpio_keys(&imx_button_data);
 
 	imx51_add_imx_i2c(0, &babbage_i2c_data);
+	i2c_register_board_info(1, mx51_babbage_i2c_devices,
+		ARRAY_SIZE(mx51_babbage_i2c_devices));
 	imx51_add_imx_i2c(1, &babbage_i2c_data);
 	mxc_register_device(&mxc_hsi2c_device, &babbage_hsi2c_data);
 
-- 
1.6.0.4



      
