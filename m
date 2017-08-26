From: bhumirks@gmail.com (Bhumika Goyal)
Date: Sat, 26 Aug 2017 15:50:06 +0530
Subject: [PATCH 04/10] [media] mx2-emmaprp: make video_device const
In-Reply-To: <1503742812-16139-1-git-send-email-bhumirks@gmail.com>
References: <1503742812-16139-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1503742812-16139-5-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this const as it is only used in a copy operation.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/media/platform/mx2_emmaprp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mx2_emmaprp.c b/drivers/media/platform/mx2_emmaprp.c
index 7fd209e..3493d40 100644
--- a/drivers/media/platform/mx2_emmaprp.c
+++ b/drivers/media/platform/mx2_emmaprp.c
@@ -873,7 +873,7 @@ static int emmaprp_mmap(struct file *file, struct vm_area_struct *vma)
 	.mmap		= emmaprp_mmap,
 };
 
-static struct video_device emmaprp_videodev = {
+static const struct video_device emmaprp_videodev = {
 	.name		= MEM2MEM_NAME,
 	.fops		= &emmaprp_fops,
 	.ioctl_ops	= &emmaprp_ioctl_ops,
-- 
1.9.1
