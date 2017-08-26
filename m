From: bhumirks@gmail.com (Bhumika Goyal)
Date: Sat, 26 Aug 2017 17:00:36 +0530
Subject: [PATCH] staging: bcm2835-camera: make video_device const
Message-ID: <1503747036-19068-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this const as it is only used in a copy operation.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 5af758a..be936b8 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -1456,7 +1456,7 @@ static int vidioc_s_parm(struct file *file, void *priv,
 	.mmap = vb2_fop_mmap,
 };
 
-static struct video_device vdev_template = {
+static const struct video_device vdev_template = {
 	.name = "camera0",
 	.fops = &camera0_fops,
 	.ioctl_ops = &camera0_ioctl_ops,
-- 
1.9.1
