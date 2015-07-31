From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 31 Jul 2015 19:12:06 +0800
Subject: [PATCH 1/2] ARM: sunxi_defconfig: Enable DMA_SUN6I, P2WI, PWM,
 cryptodev, EXTCON, FHANDLE
In-Reply-To: <1438341127-7175-1-git-send-email-wens@csie.org>
References: <1438341127-7175-1-git-send-email-wens@csie.org>
Message-ID: <1438341127-7175-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable sun6i DMA engine, sun6i P2WI, PWM, and crypto engine (Security
System) drivers by default. EXTCON is needed by the updated sun4i USB
PHY driver.

While at it, enable FHANDLE, which is needed by systemd and newer
versions of udev.

And get rid of POWER_RESET, as the sun6i power reset driver has been
removed in favor of proper sun6i watchdog support.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/configs/sunxi_defconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 7ebc346bf9fa..52cc0686524f 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -1,3 +1,4 @@
+CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
@@ -72,12 +73,12 @@ CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MV64XXX=y
+CONFIG_I2C_SUN6I_P2WI=y
 CONFIG_SPI=y
 CONFIG_SPI_SUN4I=y
 CONFIG_SPI_SUN6I=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_SUPPLY=y
-CONFIG_POWER_RESET=y
 CONFIG_THERMAL=y
 CONFIG_CPU_THERMAL=y
 CONFIG_WATCHDOG=y
@@ -109,7 +110,12 @@ CONFIG_RTC_CLASS=y
 # CONFIG_RTC_INTF_PROC is not set
 CONFIG_RTC_DRV_SUN6I=y
 CONFIG_RTC_DRV_SUNXI=y
+CONFIG_DMADEVICES=y
+CONFIG_DMA_SUN6I=y
 # CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXTCON=y
+CONFIG_PWM=y
+CONFIG_PWM_SUN4I=y
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_PHY_SUN9I_USB=y
 CONFIG_EXT4_FS=y
@@ -123,3 +129,4 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
+CONFIG_CRYPTO_DEV_SUN4I_SS=y
-- 
2.5.0
