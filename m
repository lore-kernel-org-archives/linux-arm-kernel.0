From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 22:17:43 +0100
Subject: [PATCH 3/7] [media] staging/davinci/vpfe/dm365: add missing
 dependencies
In-Reply-To: <1422479867-3370921-1-git-send-email-arnd@arndb.de>
References: <1422479867-3370921-1-git-send-email-arnd@arndb.de>
Message-ID: <1422479867-3370921-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver can only be built when VIDEO_V4L2_SUBDEV_API
and VIDEO_DAVINCI_VPBE_DISPLAY are also provided by the
kernel.

drivers/staging/media/davinci_vpfe/dm365_isif.c: In function '__isif_get_format':
drivers/staging/media/davinci_vpfe/dm365_isif.c:1410:3: error: implicit declaration of function 'v4l2_subdev_get_try_format' [-Werror=implicit-function-declaration]
   return v4l2_subdev_get_try_format(fh, pad);
   ^

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/media/davinci_vpfe/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/media/davinci_vpfe/Kconfig b/drivers/staging/media/davinci_vpfe/Kconfig
index 4de2f082491d..f40a06954a92 100644
--- a/drivers/staging/media/davinci_vpfe/Kconfig
+++ b/drivers/staging/media/davinci_vpfe/Kconfig
@@ -2,6 +2,8 @@ config VIDEO_DM365_VPFE
 	tristate "DM365 VPFE Media Controller Capture Driver"
 	depends on VIDEO_V4L2 && ARCH_DAVINCI_DM365 && !VIDEO_DM365_ISIF
 	depends on HAS_DMA
+	depends on VIDEO_V4L2_SUBDEV_API
+	depends on VIDEO_DAVINCI_VPBE_DISPLAY
 	select VIDEOBUF2_DMA_CONTIG
 	help
 	  Support for DM365 VPFE based Media Controller Capture driver.
-- 
2.1.0.rc2
