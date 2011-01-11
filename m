From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Jan 2011 13:10:26 +0000
Subject: [PATCH] ux500: Add Rohm BH1780GLI Light Sensor to i2c_board_info
Message-ID: <1294751426-3472-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 2635bb7..ff67408 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -134,6 +134,15 @@ static struct i2c_board_info mop500_i2c0_devices[] = {
 	},
 };
 
+static struct i2c_board_info mop500_i2c2_devices[] = {
+#if defined(CONFIG_SENSORS_BH1780)
+	{
+		/* Light sensor Rohm BH1780GLI */
+		I2C_BOARD_INFO("bh1780", 0x29),
+	},
+#endif
+};
+
 #define U8500_I2C_CONTROLLER(id, _slsu, _tft, _rft, clk, _sm) \
 static struct nmk_i2c_controller u8500_i2c##id##_data = { \
 	/*				\
@@ -322,6 +331,8 @@ static void __init u8500_init_machine(void)
 
 	i2c_register_board_info(0, mop500_i2c0_devices,
 				ARRAY_SIZE(mop500_i2c0_devices));
+	i2c_register_board_info(2, mop500_i2c2_devices,
+				ARRAY_SIZE(mop500_i2c0_devices));
 }
 
 MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
-- 
1.7.1
