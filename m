From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 03 Aug 2010 09:44:03 +0900
Subject: [PATCH] ARM: S5PC210: GPIO I2C devices support on universal board
Message-ID: <20100803004403.GA5300@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Universal board has several GPIO i2c devices.

Note that this patch depends on previous patch "ARM: S5PC210: Define more GPIOs to use the MP pins".

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv310/mach-universal.c |   92 ++++++++++++++++++++++++++++++++
 1 files changed, 92 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/mach-universal.c b/arch/arm/mach-s5pv310/mach-universal.c
index d584028..29a2516 100644
--- a/arch/arm/mach-s5pv310/mach-universal.c
+++ b/arch/arm/mach-s5pv310/mach-universal.c
@@ -12,6 +12,7 @@
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
 #include <linux/gpio.h>
+#include <linux/i2c-gpio.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -115,8 +116,99 @@ static struct platform_device universal_gpio_keys = {
 	},
 };
 
+/* GPIO I2C devices */
+#define I2C_GPIO_BUS_9		9
+static struct i2c_gpio_platform_data universal_i2c_gpio_fuelgauge_data = {
+	.sda_pin		= S5PV310_MP04(0),	/* XM0ADDR_8 */
+	.scl_pin		= S5PV310_MP04(1),	/* XM0ADDR_9 */
+};
+
+static struct platform_device universal_i2c_gpio_fuelgauge = {
+	.name			= "i2c-gpio",
+	.id			= I2C_GPIO_BUS_9,
+	.dev			= {
+		.platform_data	= &universal_i2c_gpio_fuelgauge_data,
+	},
+};
+
+#define I2C_GPIO_BUS_10		10
+static struct i2c_gpio_platform_data universal_i2c_gpio_microusb_data = {
+	.sda_pin		= S5PV310_GPE1(0),	/* XMDMADDR_0 */
+	.scl_pin		= S5PV310_GPE1(1),	/* XMDMADDR_1 */
+};
+
+static struct platform_device universal_i2c_gpio_microusb = {
+	.name			= "i2c-gpio",
+	.id			= I2C_GPIO_BUS_10,
+	.dev			= {
+		.platform_data	= &universal_i2c_gpio_microusb_data,
+	},
+};
+
+#define I2C_GPIO_BUS_11		11
+static struct i2c_gpio_platform_data universal_i2c_gpio_fm_data = {
+	.sda_pin		= S5PV310_GPE1(2),	/* XMDMADDR_2 */
+	.scl_pin		= S5PV310_GPE1(3),	/* XMDMADDR_3 */
+};
+
+static struct platform_device universal_i2c_gpio_fm = {
+	.name			= "i2c-gpio",
+	.id			= I2C_GPIO_BUS_11,
+	.dev			= {
+		.platform_data	= &universal_i2c_gpio_fm_data,
+	},
+};
+
+#define I2C_GPIO_BUS_12		12
+static struct i2c_gpio_platform_data universal_i2c_gpio_3touch_data = {
+	.sda_pin		= S5PV310_GPE4(0),	/* XMDMDATA_8 */
+	.scl_pin		= S5PV310_GPE4(1),	/* XMDMDATA_9 */
+};
+
+static struct platform_device universal_i2c_gpio_3touch = {
+	.name			= "i2c-gpio",
+	.id			= I2C_GPIO_BUS_12,
+	.dev			= {
+		.platform_data	= &universal_i2c_gpio_3touch_data,
+	},
+};
+
+#define I2C_GPIO_BUS_13		13
+static struct i2c_gpio_platform_data universal_i2c_gpio_hdmiddc_data = {
+	.sda_pin		= S5PV310_GPE4(2),	/* XMDMDATA_10 */
+	.scl_pin		= S5PV310_GPE4(3),	/* XMDMDATA_11 */
+};
+
+static struct platform_device universal_i2c_gpio_hdmiddc = {
+	.name			= "i2c-gpio",
+	.id			= I2C_GPIO_BUS_13,
+	.dev			= {
+		.platform_data	= &universal_i2c_gpio_hdmiddc_data,
+	},
+};
+
+#define I2C_GPIO_BUS_14		14
+static struct i2c_gpio_platform_data universal_i2c_gpio_light_data = {
+	.sda_pin		= S5PV310_GPK2(2),	/* XMMC2CDN */
+	.scl_pin		= S5PV310_GPK0(2),	/* XMMC0CDN */
+};
+
+static struct platform_device universal_i2c_gpio_light = {
+	.name			= "i2c-gpio",
+	.id			= I2C_GPIO_BUS_14,
+	.dev			= {
+		.platform_data	= &universal_i2c_gpio_light_data,
+	},
+};
+
 static struct platform_device *universal_devices[] __initdata = {
 	&universal_gpio_keys,
+	&universal_i2c_gpio_fuelgauge,
+	&universal_i2c_gpio_microusb,
+	&universal_i2c_gpio_fm,
+	&universal_i2c_gpio_3touch,
+	&universal_i2c_gpio_hdmiddc,
+	&universal_i2c_gpio_light,
 };
 
 static void __init universal_map_io(void)
-- 
1.5.3.3
