From: jtzhou@marvell.com (Jett.Zhou)
Date: Sun, 9 Jun 2013 16:44:21 +0800
Subject: [V1 3/7] video: mmp: fix graphics/video layer enable/mask swap issue
Message-ID: <1370767461-11523-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jing Xiang <jxiang@marvell.com>

There is bug when switch dma of graphic layer and video layer, it
configured opposite bit, fix it.

Signed-off-by: Jing Xiang <jxiang@marvell.com>
Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
---
 drivers/video/mmp/hw/mmp_ctrl.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/mmp/hw/mmp_ctrl.c b/drivers/video/mmp/hw/mmp_ctrl.c
index 3a8c2a3..8836053 100644
--- a/drivers/video/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/mmp/hw/mmp_ctrl.c
@@ -160,9 +160,9 @@ static void overlay_set_win(struct mmp_overlay *overlay, struct mmp_win *win)
 
 static void dmafetch_onoff(struct mmp_overlay *overlay, int on)
 {
-	u32 mask = overlay_is_vid(overlay) ? CFG_GRA_ENA_MASK :
-		   CFG_DMA_ENA_MASK;
-	u32 enable = overlay_is_vid(overlay) ? CFG_GRA_ENA(1) : CFG_DMA_ENA(1);
+	u32 mask = overlay_is_vid(overlay) ? CFG_DMA_ENA_MASK :
+		   CFG_GRA_ENA_MASK;
+	u32 enable = overlay_is_vid(overlay) ? CFG_DMA_ENA(1) : CFG_GRA_ENA(1);
 	u32 tmp;
 	struct mmp_path *path = overlay->path;
 
-- 
1.7.0.4
