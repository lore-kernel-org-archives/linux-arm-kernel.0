From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  9 Oct 2013 00:10:39 -0300
Subject: [PATCH] ARM: mxs_defconfig: Turn off CONFIG_DEBUG_GPIO
Message-ID: <1381288239-21678-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Having CONFIG_DEBUG_GPIO=y leads to several debug messages polluting kernel log:

[    0.580325] of_get_named_gpio_flags: can't parse gpios property of node '/regulators/3p3v[0]'
[    0.581185] 3P3V: 3300 mV 
[    0.584827] of_get_named_gpio_flags exited with status 124
[    0.585852] vddio-sd0: 3300 mV 
[    0.590023] of_get_named_gpio_flags exited with status 79
[    0.590770] fec-3v3: 3300 mV 
[    0.594805] of_get_named_gpio_flags exited with status 105
[    0.595491] usb0_vbus: 5000 mV 
[    0.599687] of_get_named_gpio_flags exited with status 104
[    0.600380] usb1_vbus: 5000 mV 
[    0.604463] of_get_named_gpio_flags exited with status 126
[    0.605153] lcd-3v3: 3300 mV 
[    0.608970] of_get_named_gpio_flags exited with status 77

Turn this option off, as these messages are not really useful for normal usage.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/mxs_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 2d0c369..6150108 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -90,7 +90,6 @@ CONFIG_I2C_MXS=y
 CONFIG_SPI=y
 CONFIG_SPI_GPIO=m
 CONFIG_SPI_MXS=y
-CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
-- 
1.8.1.2
