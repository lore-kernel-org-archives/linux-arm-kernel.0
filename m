From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 20 Mar 2012 00:09:58 -0300
Subject: [PATCH] ARM: mach-mx35_3ds: Fix build warning due to the lack of
 'const' annotation
Message-ID: <1332212998-6234-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following build warning:

arch/arm/mach-imx/mach-mx35_3ds.c: In function 'mx35_3ds_lcd_set_power':
arch/arm/mach-imx/mach-mx35_3ds.c:112: warning: passing argument 2 of 'gpiochip_find' from incompatible pointer type
include/asm-generic/gpio.h:145: note: expected 'int (*)(struct gpio_chip *, const void *)' but argument is of type 'int (*)(struct gpio_chip *, void *)'

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-mx35_3ds.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
index e14291d..6ae51c6 100644
--- a/arch/arm/mach-imx/mach-mx35_3ds.c
+++ b/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -97,7 +97,7 @@ static struct i2c_board_info __initdata i2c_devices_3ds[] = {
 static int lcd_power_gpio = -ENXIO;
 
 static int mc9s08dz60_gpiochip_match(struct gpio_chip *chip,
-						     void *data)
+						     const void *data)
 {
 	return !strcmp(chip->label, data);
 }
-- 
1.7.1
