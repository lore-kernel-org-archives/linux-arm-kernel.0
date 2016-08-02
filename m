From: baolex.ni@intel.com (Baole Ni)
Date: Tue,  2 Aug 2016 20:08:36 +0800
Subject: [PATCH 1016/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802120836.17828-1-baolex.ni@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/video/fbdev/s3c2410fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/s3c2410fb.c b/drivers/video/fbdev/s3c2410fb.c
index 0dd86be..9f955a2 100644
--- a/drivers/video/fbdev/s3c2410fb.c
+++ b/drivers/video/fbdev/s3c2410fb.c
@@ -616,7 +616,7 @@ static int s3c2410fb_debug_store(struct device *dev,
 	return len;
 }
 
-static DEVICE_ATTR(debug, 0664, s3c2410fb_debug_show, s3c2410fb_debug_store);
+static DEVICE_ATTR(debug, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, s3c2410fb_debug_show, s3c2410fb_debug_store);
 
 static struct fb_ops s3c2410fb_ops = {
 	.owner		= THIS_MODULE,
-- 
2.9.2
