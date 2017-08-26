From: bhumirks@gmail.com (Bhumika Goyal)
Date: Sat, 26 Aug 2017 15:50:10 +0530
Subject: [PATCH 08/10] [media]: fsl-viu: make video_device const
In-Reply-To: <1503742812-16139-1-git-send-email-bhumirks@gmail.com>
References: <1503742812-16139-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1503742812-16139-9-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this const as it is only used in a copy operation.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/media/platform/fsl-viu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/fsl-viu.c b/drivers/media/platform/fsl-viu.c
index f7b88e5..b3b91cb 100644
--- a/drivers/media/platform/fsl-viu.c
+++ b/drivers/media/platform/fsl-viu.c
@@ -1380,7 +1380,7 @@ static int viu_mmap(struct file *file, struct vm_area_struct *vma)
 	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
 };
 
-static struct video_device viu_template = {
+static const struct video_device viu_template = {
 	.name		= "FSL viu",
 	.fops		= &viu_fops,
 	.minor		= -1,
-- 
1.9.1
