From: keescook@chromium.org (Kees Cook)
Date: Fri, 16 Dec 2016 17:00:31 -0800
Subject: [PATCH] mtk-vcodec: use designated initializers
Message-ID: <20161217010031.GA140323@beast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare to mark sensitive kernel structures for randomization by making
sure they're using designated initializers. These were identified during
allyesconfig builds of x86, arm, and arm64, with most initializer fixes
extracted from grsecurity.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c | 8 ++++----
 drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c  | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c b/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
index b76c80bdf30b..4eb3be37ba14 100644
--- a/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
+++ b/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
@@ -665,10 +665,10 @@ static int h264_enc_deinit(unsigned long handle)
 }
 
 static const struct venc_common_if venc_h264_if = {
-	h264_enc_init,
-	h264_enc_encode,
-	h264_enc_set_param,
-	h264_enc_deinit,
+	.init = h264_enc_init,
+	.encode = h264_enc_encode,
+	.set_param = h264_enc_set_param,
+	.deinit = h264_enc_deinit,
 };
 
 const struct venc_common_if *get_h264_enc_comm_if(void);
diff --git a/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c b/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c
index 544f57186243..a6fa145f2c54 100644
--- a/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c
+++ b/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c
@@ -470,10 +470,10 @@ static int vp8_enc_deinit(unsigned long handle)
 }
 
 static const struct venc_common_if venc_vp8_if = {
-	vp8_enc_init,
-	vp8_enc_encode,
-	vp8_enc_set_param,
-	vp8_enc_deinit,
+	.init = vp8_enc_init,
+	.encode = vp8_enc_encode,
+	.set_param = vp8_enc_set_param,
+	.deinit = vp8_enc_deinit,
 };
 
 const struct venc_common_if *get_vp8_enc_comm_if(void);
-- 
2.7.4


-- 
Kees Cook
Nexus Security
