From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  3 Apr 2013 00:18:51 -0600
Subject: [PATCH 2/2] ARM: bcm235: defconfig updates for dumb framebuffer
In-Reply-To: <1364969931-6574-1-git-send-email-swarren@wwwdotorg.org>
References: <1364969931-6574-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1364969931-6574-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the dumb framebuffer driver, fbconsole, and VT support.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/configs/bcm2835_defconfig |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 1fa601e..0b2b1ac 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -57,7 +57,6 @@ CONFIG_ENC28J60_WRITEVERIFY=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
-# CONFIG_VT is not set
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_AMBA_PL011=y
@@ -72,6 +71,11 @@ CONFIG_SPI_DEBUG=y
 CONFIG_SPI_BCM2835=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
+CONFIG_FB=y
+CONFIG_FB_DUMB=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
+CONFIG_LOGO=y
 CONFIG_USB=y
 CONFIG_USB_DEBUG=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
-- 
1.7.10.4
