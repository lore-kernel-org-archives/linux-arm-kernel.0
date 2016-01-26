From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Jan 2016 22:46:02 +0100
Subject: [PATCH] [media] v4l: remove MEDIA_TUNER dependency for VIDEO_TUNER
Message-ID: <1453844772-3395901-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

em28xx selects VIDEO_TUNER, which has a dependency on MEDIA_TUNER,
so we get a Kconfig warning if that is disabled:

warning: (VIDEO_PVRUSB2 && VIDEO_USBVISION && VIDEO_GO7007 && VIDEO_AU0828_V4L2 && VIDEO_CX231XX && VIDEO_TM6000 && VIDEO_EM28XX && VIDEO_IVTV && VIDEO_MXB && VIDEO_CX18 && VIDEO_CX23885 && VIDEO_CX88 && VIDEO_BT848 && VIDEO_SAA7134 && VIDEO_SAA7164) selects VIDEO_TUNER which has unmet direct dependencies (MEDIA_SUPPORT && MEDIA_TUNER)

VIDEO_TUNER does not actually depend on MEDIA_TUNER, and the
dependency does nothing except cause the above warning, so let's
remove it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/v4l2-core/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/v4l2-core/Kconfig b/drivers/media/v4l2-core/Kconfig
index 9beece00869b..29b3436d0910 100644
--- a/drivers/media/v4l2-core/Kconfig
+++ b/drivers/media/v4l2-core/Kconfig
@@ -37,7 +37,6 @@ config VIDEO_PCI_SKELETON
 # Used by drivers that need tuner.ko
 config VIDEO_TUNER
 	tristate
-	depends on MEDIA_TUNER
 
 # Used by drivers that need v4l2-mem2mem.ko
 config V4L2_MEM2MEM_DEV
-- 
2.7.0
