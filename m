From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 14 Apr 2016 17:49:53 -0700
Subject: [PATCH] ARM: davinci_all_defconfig: enable SPI and NOR as modules
Message-ID: <1460681393-15000-1-git-send-email-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable SPI driver and SPI NOR flash support as modules.

Tested with SPI NOR flash on DA850-EVM.  Basic boot test only to confirm
NOR flash device detection.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
Also boot tested on dm365-evm.

Tested on top of Sekhar's master branch, based on v4.6-rc1

 arch/arm/configs/davinci_all_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index c5bccd9d010e..961246199898 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -70,8 +70,10 @@ CONFIG_MTD_CFI=m
 CONFIG_MTD_CFI_INTELEXT=m
 CONFIG_MTD_CFI_AMDSTD=m
 CONFIG_MTD_PHYSMAP=m
+CONFIG_MTD_M25P80=m
 CONFIG_MTD_NAND=m
 CONFIG_MTD_NAND_DAVINCI=m
+CONFIG_MTD_SPI_NOR=m
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_RAM=y
@@ -117,6 +119,8 @@ CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_DAVINCI=y
+CONFIG_SPI=y
+CONFIG_SPI_DAVINCI=m
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_PCF857X=y
-- 
2.7.4
