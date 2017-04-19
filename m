From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Wed, 19 Apr 2017 07:56:34 -0300
Subject: [PATCH] [media] mtk-vcodec: avoid warnings because of empty macros
Message-ID: <5bc3ebc3c6f57c2b30126f113bc35ec95c6f5b5d.1492599391.git.mchehab@s-opensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove those gcc warnings:

	drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c: In function 'mtk_vcodec_dec_pw_on':
	drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c:114:51: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
	   mtk_v4l2_err("pm_runtime_get_sync fail %d", ret);
	                                                   ^

By adding braces.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
index 12480837ff2e..237e144c194f 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
@@ -66,15 +66,15 @@ extern bool mtk_vcodec_dbg;
 
 #else
 
-#define mtk_v4l2_debug(level, fmt, args...)
-#define mtk_v4l2_err(fmt, args...)
-#define mtk_v4l2_debug_enter()
-#define mtk_v4l2_debug_leave()
+#define mtk_v4l2_debug(level, fmt, args...) {}
+#define mtk_v4l2_err(fmt, args...) {}
+#define mtk_v4l2_debug_enter() {}
+#define mtk_v4l2_debug_leave() {}
 
-#define mtk_vcodec_debug(h, fmt, args...)
-#define mtk_vcodec_err(h, fmt, args...)
-#define mtk_vcodec_debug_enter(h)
-#define mtk_vcodec_debug_leave(h)
+#define mtk_vcodec_debug(h, fmt, args...) {}
+#define mtk_vcodec_err(h, fmt, args...) {}
+#define mtk_vcodec_debug_enter(h) {}
+#define mtk_vcodec_debug_leave(h) {}
 
 #endif
 
-- 
2.9.3
