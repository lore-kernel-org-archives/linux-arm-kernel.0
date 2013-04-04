From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  3 Apr 2013 20:40:57 -0600
Subject: [PATCH V2 2/2] ARM: bcm2835: defconfig updates for simple framebuffer
In-Reply-To: <1365043257-29296-1-git-send-email-swarren@wwwdotorg.org>
References: <1365043257-29296-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1365043257-29296-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the simple framebuffer driver, fbconsole, and VT support.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
v2: s/dumb/simple/
---
 arch/arm/configs/bcm2835_defconfig |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 32b2c84..22242eb 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -55,7 +55,6 @@ CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
-# CONFIG_VT is not set
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_AMBA_PL011=y
@@ -69,6 +68,10 @@ CONFIG_SPI=y
 CONFIG_SPI_BCM2835=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
+CONFIG_FB=y
+CONFIG_FB_SIMPLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
-- 
1.7.10.4
