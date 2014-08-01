From: panpan1.liu@samsung.com (panpan liu)
Date: Fri, 01 Aug 2014 17:15:14 +0800
Subject: [PATCH] media: s5p_mfc_dec: delete the redundant code
Message-ID: <1406884515-3250-1-git-send-email-panpan1.liu@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because the api s5p_mfc_queue_setup has already realized the same function

Signed-off-by: panpan liu <panpan1.liu@samsung.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c

--- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
@@ -544,14 +544,7 @@ static int vidioc_reqbufs(struct file *file, void *priv,
 			mfc_err("vb2_reqbufs on capture failed\n");
 			return ret;
 		}
-		if (reqbufs->count < ctx->pb_count) {
-			mfc_err("Not enough buffers allocated\n");
-			reqbufs->count = 0;
-			s5p_mfc_clock_on();
-			ret = vb2_reqbufs(&ctx->vq_dst, reqbufs);
-			s5p_mfc_clock_off();
-			return -ENOMEM;
-		}
+
 		ctx->total_dpb_count = reqbufs->count;
 		ret = s5p_mfc_hw_call(dev->mfc_ops, alloc_codec_buffers, ctx);
 		if (ret) {
--
1.7.9.5
