From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Sat,  2 Oct 2010 17:15:26 +0200
Subject: [PATCH 1/4] mach-cpuimx35: remove unecessary tsc2007 functions +
	style cleanup
In-Reply-To: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
References: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1286032529-26509-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- remove functions which are no more necessary for tsc2007
- indent platform_data for better readability

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx3/mach-cpuimx35.c |   32 +++++---------------------------
 1 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-cpuimx35.c b/arch/arm/mach-mx3/mach-cpuimx35.c
index 2a4f8b7..ea0a85f 100644
--- a/arch/arm/mach-mx3/mach-cpuimx35.c
+++ b/arch/arm/mach-mx3/mach-cpuimx35.c
@@ -31,6 +31,7 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 #include <linux/fsl_devices.h>
+#include <linux/i2c-gpio.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -53,39 +54,16 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
 };
 
 static const struct imxi2c_platform_data
-eukrea_cpuimx35_i2c0_data __initconst = {
-	.bitrate = 50000,
+		eukrea_cpuimx35_i2c0_data __initconst = {
+	.bitrate =		100000,
 };
 
-#define TSC2007_IRQGPIO		(2 * 32 + 2)
-static int ts_get_pendown_state(void)
-{
-	int val = 0;
-	gpio_free(TSC2007_IRQGPIO);
-	gpio_request(TSC2007_IRQGPIO, NULL);
-	gpio_direction_input(TSC2007_IRQGPIO);
-
-	val = gpio_get_value(TSC2007_IRQGPIO);
-
-	gpio_free(TSC2007_IRQGPIO);
-	gpio_request(TSC2007_IRQGPIO, NULL);
-
-	return val ? 0 : 1;
-}
-
-static int ts_init(void)
-{
-	gpio_request(TSC2007_IRQGPIO, NULL);
-	return 0;
-}
-
 static struct tsc2007_platform_data tsc2007_info = {
 	.model			= 2007,
 	.x_plate_ohms		= 180,
-	.get_pendown_state	= ts_get_pendown_state,
-	.init_platform_hw	= ts_init,
 };
 
+#define TSC2007_IRQGPIO		(2 * 32 + 2)
 static struct i2c_board_info eukrea_cpuimx35_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("pcf8563", 0x51),
@@ -135,7 +113,7 @@ static struct pad_desc eukrea_cpuimx35_pads[] = {
 };
 
 static const struct mxc_nand_platform_data
-eukrea_cpuimx35_nand_board_info __initconst = {
+		eukrea_cpuimx35_nand_board_info __initconst = {
 	.width		= 1,
 	.hw_ecc		= 1,
 	.flash_bbt	= 1,
-- 
1.7.0.4
