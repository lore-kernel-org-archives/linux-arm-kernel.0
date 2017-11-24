From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 24 Nov 2017 20:53:02 +0100
Subject: [PATCH] video/fbdev/vt8500lcdfb: Delete an error message for a failed
 memory allocation in vt8500lcd_probe()
Message-ID: <d229eccd-ab20-d594-caa1-55fb464357ac@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 24 Nov 2017 20:42:08 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/vt8500lcdfb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/vt8500lcdfb.c b/drivers/video/fbdev/vt8500lcdfb.c
index 1a1176bf0906..5c5cd2923041 100644
--- a/drivers/video/fbdev/vt8500lcdfb.c
+++ b/drivers/video/fbdev/vt8500lcdfb.c
@@ -289,10 +289,8 @@ static int vt8500lcd_probe(struct platform_device *pdev)
 
 	fbi = devm_kzalloc(&pdev->dev, sizeof(struct vt8500lcd_info)
 			+ sizeof(u32) * 16, GFP_KERNEL);
-	if (!fbi) {
-		dev_err(&pdev->dev, "Failed to initialize framebuffer device\n");
+	if (!fbi)
 		return -ENOMEM;
-	}
 
 	strcpy(fbi->fb.fix.id, "VT8500 LCD");
 
-- 
2.15.0
