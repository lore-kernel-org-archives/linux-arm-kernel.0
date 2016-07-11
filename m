From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Mon, 11 Jul 2016 16:39:00 -0600
Subject: [PATCH] media: s5p-mfc Fix misspelled error message and checkpatch
 errors
Message-ID: <1468276740-1591-1-git-send-email-shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix misspelled error message and existing checkpatch errors in the
error message conditional.

WARNING: suspect code indent for conditional statements (8, 24)
 	if (ctx->state != MFCINST_HEAD_PARSED &&
[...]
+               mfc_err("Can not get crop information\n");

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
index a01a373..06061c4 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
@@ -775,11 +775,11 @@ static int vidioc_g_crop(struct file *file, void *priv,
 	u32 left, right, top, bottom;
 
 	if (ctx->state != MFCINST_HEAD_PARSED &&
-	ctx->state != MFCINST_RUNNING && ctx->state != MFCINST_FINISHING
-					&& ctx->state != MFCINST_FINISHED) {
-			mfc_err("Cannont set crop\n");
-			return -EINVAL;
-		}
+	    ctx->state != MFCINST_RUNNING && ctx->state != MFCINST_FINISHING
+	    && ctx->state != MFCINST_FINISHED) {
+		mfc_err("Can not get crop information\n");
+		return -EINVAL;
+	}
 	if (ctx->src_fmt->fourcc == V4L2_PIX_FMT_H264) {
 		left = s5p_mfc_hw_call(dev->mfc_ops, get_crop_info_h, ctx);
 		right = left >> S5P_FIMV_SHARED_CROP_RIGHT_SHIFT;
-- 
2.7.4
