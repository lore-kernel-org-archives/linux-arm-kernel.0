From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Wed, 28 Feb 2018 18:53:51 +0100
Subject: [PATCH 1/2] drm/sun4i: increase lvds dclk max divisor
Message-ID: <1519840432-61489-1-git-send-email-giulio.benetti@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the moment both min and max dclk div are set to 7.
This doesn't allow to have lower frequencies.

Increase dclk_max_div to 18 to achieve 30Mhz.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 029d2ce..bb35f41 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -278,7 +278,7 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
 	u32 reg, val = 0;
 
 	tcon->dclk_min_div = 7;
-	tcon->dclk_max_div = 7;
+	tcon->dclk_max_div = 18;
 	sun4i_tcon0_mode_set_common(tcon, mode);
 
 	/* Adjust clock delay */
-- 
2.7.4
