From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  5 Jan 2016 09:59:20 +0100
Subject: [PATCH 1/2] ARM: versatile: select some defaults in defconfig
Message-ID: <1451984360-16885-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the Versatile defconfig to:
- Use NO_HZ_IDLE and HIGH_RES_TIMERS
- Enable the I2C driver
- Enable the SPI driver
- Enable the RTC driver for DS1338 as found on the Versatile
  boards
- Compile in the MMCI MMC driver, which is good if you
  want to mount a root FS on the MMC card without having
  to first load this module from an initramfs

Patch tested on the Versatile AB, QEMU for Versatile AB
and QEMU for Versatile PB.

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly to wherever this goes
for the next merge window.
---
 arch/arm/configs/versatile_defconfig | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/versatile_defconfig b/arch/arm/configs/versatile_defconfig
index 64bef9775bb6..75ef20462030 100644
--- a/arch/arm/configs/versatile_defconfig
+++ b/arch/arm/configs/versatile_defconfig
@@ -1,5 +1,7 @@
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_SLAB=y
@@ -47,6 +49,8 @@ CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=m
+CONFIG_I2C_VERSATILE=y
+CONFIG_SPI=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_PL061=y
 # CONFIG_HWMON is not set
@@ -59,13 +63,15 @@ CONFIG_SND_MIXER_OSS=m
 CONFIG_SND_PCM_OSS=m
 CONFIG_SND_ARMAACI=m
 CONFIG_MMC=y
-CONFIG_MMC_ARMMMCI=m
+CONFIG_MMC_ARMMMCI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_VERSATILE=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_CPU=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1307=y
 CONFIG_EXT2_FS=y
 CONFIG_VFAT_FS=m
 CONFIG_JFFS2_FS=y
-- 
2.4.3
