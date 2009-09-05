From: jsgood.yang@samsung.com (=?UTF-8?B?7JaR7KeE7ISx?=)
Date: Sat, 05 Sep 2009 22:30:14 +0900
Subject: [PATCH 11/12] [ARM][S3C6410] Add support platform data of keypad
	device
Message-ID: <00a501ca2e2d$00106180$00312480$%yang@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch supports platform data of keypad device.
This is available for only SMDK6410 evaluation board.

Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
---
 arch/arm/mach-s3c6410/mach-smdk6410.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
index fb2b138..95e130d 100644
--- a/arch/arm/mach-s3c6410/mach-smdk6410.c
+++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
@@ -50,6 +50,7 @@
 #include <plat/regs-sys.h>
 #include <plat/iic.h>
 #include <plat/fb.h>
+#include <plat/keypad.h>
 #include <plat/gpio-cfg.h>
 
 #include <plat/s3c6410.h>
@@ -338,6 +339,14 @@ static struct i2c_board_info i2c_devs1[] __initdata = {
 	{ I2C_BOARD_INFO("24c128", 0x57), },	/* Samsung S524AD0XD1 */
 };
 
+static struct s3c_platform_keypad keypad_data __initdata = {
+	.nr_rows = 8,
+	.nr_cols = 8,
+	.max_keys = 64,
+	.max_masks = 32,
+	.delay = 50,
+};
+
 static void __init smdk6410_map_io(void)
 {
 	u32 tmp;
@@ -372,6 +381,8 @@ static void __init smdk6410_machine_init(void)
 	i2c_register_board_info(0, i2c_devs0, ARRAY_SIZE(i2c_devs0));
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
 
+	s3c_keypad_set_platdata(&keypad_data);
+
 	platform_add_devices(smdk6410_devices, ARRAY_SIZE(smdk6410_devices));
 }
 
-- 
1.6.2.5
