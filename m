From: bhumirks@gmail.com (Bhumika Goyal)
Date: Sat, 26 Aug 2017 15:50:09 +0530
Subject: [PATCH 07/10] [media] via-camera: make video_device const
In-Reply-To: <1503742812-16139-1-git-send-email-bhumirks@gmail.com>
References: <1503742812-16139-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1503742812-16139-8-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this const as it is only used in a copy operation.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/media/platform/via-camera.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/via-camera.c b/drivers/media/platform/via-camera.c
index e16f70a..805d4a8 100644
--- a/drivers/media/platform/via-camera.c
+++ b/drivers/media/platform/via-camera.c
@@ -1259,7 +1259,7 @@ static int viacam_resume(void *priv)
  * Setup stuff.
  */
 
-static struct video_device viacam_v4l_template = {
+static const struct video_device viacam_v4l_template = {
 	.name		= "via-camera",
 	.minor		= -1,
 	.tvnorms	= V4L2_STD_NTSC_M,
-- 
1.9.1
