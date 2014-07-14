From: panpan1.liu@samsung.com (panpan liu)
Date: Mon, 14 Jul 2014 15:22:27 +0800
Subject: [PATCH] s5p-mfc: limit the size of the CPB
Message-ID: <1405322547-3216-1-git-send-email-panpan1.liu@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The register of the CPB limits the size. The max size is 4M, so it
is more reasonable.

Signed-off-by: panpan liu <panpan1.liu@samsung.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
old mode 100644
new mode 100755
index 0bae907..889cb06
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
@@ -466,7 +466,8 @@ static int vidioc_s_fmt(struct file *file, void *priv, struct v4l2_format *f)
 	mfc_debug(2, "The codec number is: %d\n", ctx->codec_mode);
 	pix_mp->height = 0;
 	pix_mp->width = 0;
-	if (pix_mp->plane_fmt[0].sizeimage)
+	if (pix_mp->plane_fmt[0].sizeimage &&
+			pix_mp->plane_fmt[0].sizeimage <= MAX_CPB_SIZE)
 		ctx->dec_src_buf_size = pix_mp->plane_fmt[0].sizeimage;
 	else
 		pix_mp->plane_fmt[0].sizeimage = ctx->dec_src_buf_size =
--
1.7.9.5
