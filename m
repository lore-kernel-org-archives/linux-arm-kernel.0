From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Tue, 12 Jul 2016 11:28:30 -0600
Subject: [PATCH v2] media: s5p-mfc Fix misspelled error message and checkpatch
 errors
Message-ID: <1468344510-32411-1-git-send-email-shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix misspelled error message and existing checkpatch errors in the
error message conditional.

WARNING: suspect code indent for conditional statements (8, 24)
        if (ctx->state != MFCINST_HEAD_PARSED &&
[...]
        mfc_err("Can not get crop information\n");

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
Changes since v1:
- Addressed review comments from Joe Perches
- Added reviewed by tag from Javier Martinez Canillas

 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
index a01a373..0a9e8d1 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
@@ -775,11 +775,12 @@ static int vidioc_g_crop(struct file *file, void *priv,
 	u32 left, right, top, bottom;
 
 	if (ctx->state != MFCINST_HEAD_PARSED &&
-	ctx->state != MFCINST_RUNNING && ctx->state != MFCINST_FINISHING
-					&& ctx->state != MFCINST_FINISHED) {
-			mfc_err("Cannont set crop\n");
-			return -EINVAL;
-		}
+	    ctx->state != MFCINST_RUNNING &&
+	    ctx->state != MFCINST_FINISHING &&
+	    ctx->state != MFCINST_FINISHED) {
+		mfc_err("Can not get crop information\n");
+		return -EINVAL;
+	}
 	if (ctx->src_fmt->fourcc == V4L2_PIX_FMT_H264) {
 		left = s5p_mfc_hw_call(dev->mfc_ops, get_crop_info_h, ctx);
 		right = left >> S5P_FIMV_SHARED_CROP_RIGHT_SHIFT;
-- 
2.7.4
