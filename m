From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Thu,  9 Feb 2017 15:11:17 -0700
Subject: [PATCH] media: s5p_mfc - remove unneeded io_modes initialzation in
 s5p_mfc_open()
Message-ID: <20170209221117.26381-1-shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unneeded io_modes initialzation in s5p_mfc_open(). It gets done
right below in vdev == dev->vfd_dec conditional.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index bb0a588..20beaa2 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -866,7 +866,6 @@ static int s5p_mfc_open(struct file *file)
 	/* Init videobuf2 queue for OUTPUT */
 	q = &ctx->vq_src;
 	q->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
-	q->io_modes = VB2_MMAP;
 	q->drv_priv = &ctx->fh;
 	q->lock = &dev->mfc_mutex;
 	if (vdev == dev->vfd_dec) {
-- 
2.7.4
