From: bhumirks@gmail.com (Bhumika Goyal)
Date: Sat, 26 Aug 2017 15:50:11 +0530
Subject: [PATCH 09/10] [media] m2m-deinterlace: make video_device const
In-Reply-To: <1503742812-16139-1-git-send-email-bhumirks@gmail.com>
References: <1503742812-16139-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1503742812-16139-10-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this const as it is only used in a copy operation.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/media/platform/m2m-deinterlace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/m2m-deinterlace.c b/drivers/media/platform/m2m-deinterlace.c
index 98f6db2..c8a1249 100644
--- a/drivers/media/platform/m2m-deinterlace.c
+++ b/drivers/media/platform/m2m-deinterlace.c
@@ -979,7 +979,7 @@ static int deinterlace_mmap(struct file *file, struct vm_area_struct *vma)
 	.mmap		= deinterlace_mmap,
 };
 
-static struct video_device deinterlace_videodev = {
+static const struct video_device deinterlace_videodev = {
 	.name		= MEM2MEM_NAME,
 	.fops		= &deinterlace_fops,
 	.ioctl_ops	= &deinterlace_ioctl_ops,
-- 
1.9.1
