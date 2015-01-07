From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Wed,  7 Jan 2015 11:05:48 +0530
Subject: [PATCH v2] video: vt8500lcdfb: remove unneeded continue
Message-ID: <1420608948-4550-1-git-send-email-sudipm.mukherjee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

continue is not needed at the end of a for loop, also removed the
braces which were no longer required.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

v2: removed braces

 drivers/video/fbdev/vt8500lcdfb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/vt8500lcdfb.c b/drivers/video/fbdev/vt8500lcdfb.c
index ffaf29e..1a1176b 100644
--- a/drivers/video/fbdev/vt8500lcdfb.c
+++ b/drivers/video/fbdev/vt8500lcdfb.c
@@ -113,10 +113,8 @@ static int vt8500lcd_set_par(struct fb_info *info)
 	}
 
 	for (i = 0; i < 8; i++) {
-		if (bpp_values[i] == info->var.bits_per_pixel) {
+		if (bpp_values[i] == info->var.bits_per_pixel)
 			reg_bpp = i;
-			continue;
-		}
 	}
 
 	control0 = readl(fbi->regbase) & ~0xf;
-- 
1.8.1.2
