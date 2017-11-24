From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 24 Nov 2017 20:30:04 +0100
Subject: [PATCH] video/fbdev/wm8505fb: Delete an error message for a failed
 memory allocation in wm8505fb_probe()
Message-ID: <8f4f12ca-f2b3-6b3b-5f4c-5519f13c474f@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 24 Nov 2017 20:22:10 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/wm8505fb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/wm8505fb.c b/drivers/video/fbdev/wm8505fb.c
index 253ffe9baab2..8f0d5379861d 100644
--- a/drivers/video/fbdev/wm8505fb.c
+++ b/drivers/video/fbdev/wm8505fb.c
@@ -276,10 +276,8 @@ static int wm8505fb_probe(struct platform_device *pdev)
 
 	fbi = devm_kzalloc(&pdev->dev, sizeof(struct wm8505fb_info) +
 			sizeof(u32) * 16, GFP_KERNEL);
-	if (!fbi) {
-		dev_err(&pdev->dev, "Failed to initialize framebuffer device\n");
+	if (!fbi)
 		return -ENOMEM;
-	}
 
 	strcpy(fbi->fb.fix.id, DRIVER_NAME);
 
-- 
2.15.0
