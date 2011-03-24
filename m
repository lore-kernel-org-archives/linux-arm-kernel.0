From: julien.boibessot@free.fr (julien.boibessot at free.fr)
Date: Thu, 24 Mar 2011 17:41:02 +0100
Subject: [PATCH] Activates LCD logic before powering on backlight.
Message-ID: <1300984862-31066-1-git-send-email-julien.boibessot@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julien Boibessot <julien.boibessot@armadeus.com>

Otherwise initialisation artefacts may be seen on some LCDs.

Signed-off-by: Julien Boibessot <julien.boibessot@armadeus.com>
---
 drivers/video/imxfb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 69bd4a5..7d2d74f 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -539,10 +539,10 @@ static void imxfb_enable_controller(struct imxfb_info *fbi)
 
 	clk_enable(fbi->clk);
 
-	if (fbi->backlight_power)
-		fbi->backlight_power(1);
 	if (fbi->lcd_power)
 		fbi->lcd_power(1);
+	if (fbi->backlight_power)
+		fbi->backlight_power(1);
 }
 
 static void imxfb_disable_controller(struct imxfb_info *fbi)
-- 
1.6.0.4
