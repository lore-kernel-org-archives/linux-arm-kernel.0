From: bhumirks@gmail.com (Bhumika Goyal)
Date: Sat, 26 Aug 2017 15:50:07 +0530
Subject: [PATCH 05/10] [media]: s5p-g2d: make video_device const
In-Reply-To: <1503742812-16139-1-git-send-email-bhumirks@gmail.com>
References: <1503742812-16139-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1503742812-16139-6-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this const as it is only used in a copy operation.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/media/platform/s5p-g2d/g2d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-g2d/g2d.c b/drivers/media/platform/s5p-g2d/g2d.c
index bd655b5..66aa8cf 100644
--- a/drivers/media/platform/s5p-g2d/g2d.c
+++ b/drivers/media/platform/s5p-g2d/g2d.c
@@ -602,7 +602,7 @@ static irqreturn_t g2d_isr(int irq, void *prv)
 	.vidioc_cropcap			= vidioc_cropcap,
 };
 
-static struct video_device g2d_videodev = {
+static const struct video_device g2d_videodev = {
 	.name		= G2D_NAME,
 	.fops		= &g2d_fops,
 	.ioctl_ops	= &g2d_ioctl_ops,
-- 
1.9.1
