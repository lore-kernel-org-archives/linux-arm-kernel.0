From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Mar 2017 10:47:54 +0100
Subject: [PATCH 1/2] [media] vcodec: mediatek: add missing linux/slab.h include
Message-ID: <20170320094812.1365229-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the newly added driver, I have run into randconfig failures like:

drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c: In function 'mtk_jpeg_open':
drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c:1017:8: error: implicit declaration of function 'kzalloc';did you mean 'kvzalloc'? [-Werror=implicit-function-declaration]

Including the header with the declaration solves the problem.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
index b10183f7942b..f9bd58ce7d32 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
@@ -22,6 +22,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <media/v4l2-event.h>
 #include <media/v4l2-mem2mem.h>
-- 
2.9.0
