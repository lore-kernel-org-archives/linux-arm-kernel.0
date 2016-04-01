From: eric@anholt.net (Eric Anholt)
Date: Thu, 31 Mar 2016 17:30:42 -0700
Subject: [PATCH 3/4] ARM: bcm2835: Enable the VC4 graphics driver in the
 defconfig
In-Reply-To: <1459470643-9070-1-git-send-email-eric@anholt.net>
References: <1459470643-9070-1-git-send-email-eric@anholt.net>
Message-ID: <1459470643-9070-3-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Combined with the queued DT changes, we now get HDMI and 3D support.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/configs/bcm2835_defconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 1192a6f..896500f 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -64,7 +64,6 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_TTY_PRINTK=y
-CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_BCM2835=y
 CONFIG_SPI=y
@@ -74,10 +73,10 @@ CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_BCM2835_WDT=y
-CONFIG_FB=y
+CONFIG_DRM=y
+CONFIG_DRM_VC4=y
 CONFIG_FB_SIMPLE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
-- 
2.7.0
