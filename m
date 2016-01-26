From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Jan 2016 15:10:01 +0100
Subject: [PATCH 7/7] [media] go7007: add MEDIA_CAMERA_SUPPORT dependency
In-Reply-To: <1453817424-3080054-1-git-send-email-arnd@arndb.de>
References: <1453817424-3080054-1-git-send-email-arnd@arndb.de>
Message-ID: <1453817424-3080054-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If MEDIA_SUBDRV_AUTOSELECT and VIDEO_GO7007 are both set, we
automatically select VIDEO_OV7640, but that depends on MEDIA_CAMERA_SUPPORT,
so we get a Kconfig warning if that is disabled:

warning: (VIDEO_GO7007) selects VIDEO_OV7640 which has unmet direct dependencies (MEDIA_SUPPORT && I2C && VIDEO_V4L2 && MEDIA_CAMERA_SUPPORT)

This adds another dependency so we don't accidentally select
it when it is unavailable.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/usb/go7007/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/go7007/Kconfig b/drivers/media/usb/go7007/Kconfig
index 95a3af644a92..af1d02430931 100644
--- a/drivers/media/usb/go7007/Kconfig
+++ b/drivers/media/usb/go7007/Kconfig
@@ -11,7 +11,7 @@ config VIDEO_GO7007
 	select VIDEO_TW2804 if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_TW9903 if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_TW9906 if MEDIA_SUBDRV_AUTOSELECT
-	select VIDEO_OV7640 if MEDIA_SUBDRV_AUTOSELECT
+	select VIDEO_OV7640 if MEDIA_SUBDRV_AUTOSELECT && MEDIA_CAMERA_SUPPORT
 	select VIDEO_UDA1342 if MEDIA_SUBDRV_AUTOSELECT
 	---help---
 	  This is a video4linux driver for the WIS GO7007 MPEG
-- 
2.7.0
