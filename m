From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  5 Jun 2014 22:48:13 +0200
Subject: [PATCH 3/5] staging: sn9c102 depends on USB
In-Reply-To: <1402001295-1980118-1-git-send-email-arnd@arndb.de>
References: <1402001295-1980118-1-git-send-email-arnd@arndb.de>
Message-ID: <1402001295-1980118-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the USB code is a loadable module, this driver cannot
be built-in. This adds an explicit dependency on CONFIG_USB
so that Kconfig can force sn9c102 to be a module in this case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Luca Risolia <luca.risolia@studio.unibo.it>
Cc: Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: linux-media at vger.kernel.org
Cc: linux-usb at vger.kernel.org
---
 drivers/staging/media/sn9c102/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/sn9c102/Kconfig b/drivers/staging/media/sn9c102/Kconfig
index c9aba59..10f586b 100644
--- a/drivers/staging/media/sn9c102/Kconfig
+++ b/drivers/staging/media/sn9c102/Kconfig
@@ -1,6 +1,6 @@
 config USB_SN9C102
 	tristate "USB SN9C1xx PC Camera Controller support (DEPRECATED)"
-	depends on VIDEO_V4L2 && MEDIA_USB_SUPPORT
+	depends on VIDEO_V4L2 && MEDIA_USB_SUPPORT && USB
 	---help---
 	  This driver is DEPRECATED, please use the gspca sonixb and
 	  sonixj modules instead.
-- 
1.8.3.2
