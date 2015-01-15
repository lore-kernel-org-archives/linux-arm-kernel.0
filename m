From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 15 Jan 2015 21:29:10 +0100
Subject: [PATCH] ARM: efm32: update defconfig
Message-ID: <1421353750-8525-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable i2c driver for efm32. The other two changes are just results from
oldconfig after commits
 - 08b964ff3c51 (ARM: 8198/1: make kuser helpers depend on MMU)
 - 8357041a69b3 (of: remove /proc/device-tree)

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/configs/efm32_defconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/efm32_defconfig b/arch/arm/configs/efm32_defconfig
index f59fffb3d0c6..c4c17e3a8e1a 100644
--- a/arch/arm/configs/efm32_defconfig
+++ b/arch/arm/configs/efm32_defconfig
@@ -17,7 +17,6 @@ CONFIG_EMBEDDED=y
 # CONFIG_IOSCHED_CFQ is not set
 # CONFIG_MMU is not set
 CONFIG_ARCH_EFM32=y
-# CONFIG_KUSER_HELPERS is not set
 CONFIG_SET_MEM_PARAM=y
 CONFIG_DRAM_BASE=0x88000000
 CONFIG_DRAM_SIZE=0x00400000
@@ -49,7 +48,6 @@ CONFIG_MTD=y
 CONFIG_MTD_BLOCK_RO=y
 CONFIG_MTD_ROM=y
 CONFIG_MTD_UCLINUX=y
-CONFIG_PROC_DEVICETREE=y
 # CONFIG_BLK_DEV is not set
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_ARC is not set
@@ -78,6 +76,9 @@ CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_SERIAL_EFM32_UART=y
 CONFIG_SERIAL_EFM32_UART_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+# CONFIG_I2C_COMPAT is not set
+CONFIG_I2C_EFM32=y
 CONFIG_SPI=y
 CONFIG_SPI_EFM32=y
 CONFIG_GPIO_SYSFS=y
-- 
2.1.4
