From: bhumirks@gmail.com (Bhumika Goyal)
Date: Sat, 26 Aug 2017 15:50:05 +0530
Subject: [PATCH 03/10] [media]: marvell-ccic: make video_device const
In-Reply-To: <1503742812-16139-1-git-send-email-bhumirks@gmail.com>
References: <1503742812-16139-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1503742812-16139-4-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this const as it is only used in a copy operation.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/media/platform/marvell-ccic/mcam-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/marvell-ccic/mcam-core.c b/drivers/media/platform/marvell-ccic/mcam-core.c
index 8cac2f2..b07a251 100644
--- a/drivers/media/platform/marvell-ccic/mcam-core.c
+++ b/drivers/media/platform/marvell-ccic/mcam-core.c
@@ -1639,7 +1639,7 @@ static int mcam_v4l_release(struct file *filp)
  * This template device holds all of those v4l2 methods; we
  * clone it for specific real devices.
  */
-static struct video_device mcam_v4l_template = {
+static const struct video_device mcam_v4l_template = {
 	.name = "mcam",
 	.fops = &mcam_v4l_fops,
 	.ioctl_ops = &mcam_v4l_ioctl_ops,
-- 
1.9.1
