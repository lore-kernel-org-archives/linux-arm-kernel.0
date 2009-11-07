From: tbm@cyrius.com (Martin Michlmayr)
Date: Sat, 7 Nov 2009 10:38:58 +0000
Subject: [PATCH] Orion/Kirkwood: Enable GPIO_SYSFS in defconfig
Message-ID: <20091107103858.GA7133@deprecation.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that Orion and Kirkwood have been converted to GPIOLIB, let's
enable GPIO_SYSFS which is useful for debugging.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -1023,6 +1023,12 @@ CONFIG_SPI_ORION=y
 #
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
+
+CONFIG_ARCH_REQUIRE_GPIOLIB=y
+CONFIG_GPIOLIB=y
+# CONFIG_DEBUG_GPIO is not set
+CONFIG_GPIO_SYSFS=y
+
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
--- a/arch/arm/configs/orion5x_defconfig
+++ b/arch/arm/configs/orion5x_defconfig
@@ -977,6 +977,12 @@ CONFIG_I2C_MV64XXX=y
 # CONFIG_I2C_DEBUG_BUS is not set
 # CONFIG_I2C_DEBUG_CHIP is not set
 # CONFIG_SPI is not set
+
+CONFIG_ARCH_REQUIRE_GPIOLIB=y
+CONFIG_GPIOLIB=y
+# CONFIG_DEBUG_GPIO is not set
+CONFIG_GPIO_SYSFS=y
+
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 CONFIG_HWMON=y

-- 
Martin Michlmayr
http://www.cyrius.com/
