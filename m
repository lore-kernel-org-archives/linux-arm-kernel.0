From: bhumirks@gmail.com (Bhumika Goyal)
Date: Sat, 26 Aug 2017 15:50:03 +0530
Subject: [PATCH 01/10] [media] cx88: make video_device const
In-Reply-To: <1503742812-16139-1-git-send-email-bhumirks@gmail.com>
References: <1503742812-16139-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1503742812-16139-2-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this const as it is only passed to the const argument of the
function cx88_vdev_init.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/media/pci/cx88/cx88-blackbird.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx88/cx88-blackbird.c b/drivers/media/pci/cx88/cx88-blackbird.c
index aa49c95..e3101f0 100644
--- a/drivers/media/pci/cx88/cx88-blackbird.c
+++ b/drivers/media/pci/cx88/cx88-blackbird.c
@@ -1075,7 +1075,7 @@ static int vidioc_s_std(struct file *file, void *priv, v4l2_std_id id)
 	.vidioc_unsubscribe_event    = v4l2_event_unsubscribe,
 };
 
-static struct video_device cx8802_mpeg_template = {
+static const struct video_device cx8802_mpeg_template = {
 	.name                 = "cx8802",
 	.fops                 = &mpeg_fops,
 	.ioctl_ops	      = &mpeg_ioctl_ops,
-- 
1.9.1
