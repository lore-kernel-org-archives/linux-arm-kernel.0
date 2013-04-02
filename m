From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed,  3 Apr 2013 07:20:37 +1300
Subject: [PATCHv3 5/6] video: vt8500: Adjust contrast in wm8505 framebuffer
 driver.
In-Reply-To: <1364926838-6721-1-git-send-email-linux@prisktech.co.nz>
References: <1364926838-6721-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1364926838-6721-6-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The contrast value was typo'd on the original commit (0x80 instead of
0x08). Following feedback from an enduser, a value of 0x10 seems more
suitable due to the default backlight being <100%.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
Reviewed-by: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
---
 drivers/video/wm8505fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/wm8505fb.c b/drivers/video/wm8505fb.c
index 020df1d..e3be1e3 100644
--- a/drivers/video/wm8505fb.c
+++ b/drivers/video/wm8505fb.c
@@ -358,7 +358,7 @@ static int wm8505fb_probe(struct platform_device *pdev)
 	fbi->fb.screen_base		= fb_mem_virt;
 	fbi->fb.screen_size		= fb_mem_len;
 
-	fbi->contrast = 0x80;
+	fbi->contrast = 0x10;
 	ret = wm8505fb_set_par(&fbi->fb);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to set parameters\n");
-- 
1.7.9.5
