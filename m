From: ayaka@soulik.info (ayaka)
Date: Sat,  7 May 2016 13:05:25 +0800
Subject: [PATCH 2/3] [media] s5p-mfc: remove unnecessary check in try_fmt
In-Reply-To: <1462597526-31559-1-git-send-email-ayaka@soulik.info>
References: <1462597526-31559-1-git-send-email-ayaka@soulik.info>
Message-ID: <1462597526-31559-3-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need to request the sizeimage or num_planes
in try_fmt.

Signed-off-by: ayaka <ayaka@soulik.info>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_enc.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
index a66a9f9..2f76aba 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
@@ -1043,10 +1043,6 @@ static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f)
 			mfc_err("failed to try output format\n");
 			return -EINVAL;
 		}
-		if (pix_fmt_mp->plane_fmt[0].sizeimage == 0) {
-			mfc_err("must be set encoding output size\n");
-			return -EINVAL;
-		}
 		if ((dev->variant->version_bit & fmt->versions) == 0) {
 			mfc_err("Unsupported format by this MFC version.\n");
 			return -EINVAL;
@@ -1060,11 +1056,6 @@ static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f)
 			mfc_err("failed to try output format\n");
 			return -EINVAL;
 		}
-
-		if (fmt->num_planes != pix_fmt_mp->num_planes) {
-			mfc_err("failed to try output format\n");
-			return -EINVAL;
-		}
 		if ((dev->variant->version_bit & fmt->versions) == 0) {
 			mfc_err("Unsupported format by this MFC version.\n");
 			return -EINVAL;
-- 
2.5.5
