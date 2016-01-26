From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Jan 2016 15:10:00 +0100
Subject: [PATCH 6/7] [media] em28xx: add MEDIA_TUNER dependency
In-Reply-To: <1453817424-3080054-1-git-send-email-arnd@arndb.de>
References: <1453817424-3080054-1-git-send-email-arnd@arndb.de>
Message-ID: <1453817424-3080054-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

em28xx selects VIDEO_TUNER, which has a dependency on MEDIA_TUNER,
so we get a Kconfig warning if that is disabled:

warning: (VIDEO_PVRUSB2 && VIDEO_USBVISION && VIDEO_GO7007 && VIDEO_AU0828_V4L2 && VIDEO_CX231XX && VIDEO_TM6000 && VIDEO_EM28XX && VIDEO_IVTV && VIDEO_MXB && VIDEO_CX18 && VIDEO_CX23885 && VIDEO_CX88 && VIDEO_BT848 && VIDEO_SAA7134 && VIDEO_SAA7164) selects VIDEO_TUNER which has unmet direct dependencies (MEDIA_SUPPORT && MEDIA_TUNER)

This adds a dependency on MEDIA_TUNER to avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/usb/em28xx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/em28xx/Kconfig b/drivers/media/usb/em28xx/Kconfig
index 75323f5efd0f..cacc757e2254 100644
--- a/drivers/media/usb/em28xx/Kconfig
+++ b/drivers/media/usb/em28xx/Kconfig
@@ -1,6 +1,6 @@
 config VIDEO_EM28XX
 	tristate "Empia EM28xx USB devices support"
-	depends on VIDEO_DEV && I2C
+	depends on VIDEO_DEV && I2C && MEDIA_TUNER
 	select VIDEO_TUNER
 	select VIDEO_TVEEPROM
 
-- 
2.7.0
