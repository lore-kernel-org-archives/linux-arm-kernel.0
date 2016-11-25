From: yt.shen@mediatek.com (YT Shen)
Date: Fri, 25 Nov 2016 18:34:33 +0800
Subject: [PATCH v10 10/13] drm/mediatek: add dsi ulp mode control
In-Reply-To: <1480070076-6196-1-git-send-email-yt.shen@mediatek.com>
References: <1480070076-6196-1-git-send-email-yt.shen@mediatek.com>
Message-ID: <1480070076-6196-11-git-send-email-yt.shen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

modify dsi enter ultra low power mode method

Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
Signed-off-by: YT Shen <yt.shen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index d03a0f1..01df829 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -289,7 +289,7 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 static void mtk_dsi_clk_ulp_mode_enter(struct mtk_dsi *dsi)
 {
 	mtk_dsi_mask(dsi, DSI_PHY_LCCON, LC_HS_TX_EN, 0);
-	mtk_dsi_mask(dsi, DSI_PHY_LCCON, LC_ULPM_EN, 0);
+	mtk_dsi_mask(dsi, DSI_PHY_LCCON, LC_ULPM_EN, LC_ULPM_EN);
 }
 
 static void mtk_dsi_clk_ulp_mode_leave(struct mtk_dsi *dsi)
@@ -302,7 +302,7 @@ static void mtk_dsi_clk_ulp_mode_leave(struct mtk_dsi *dsi)
 static void mtk_dsi_lane0_ulp_mode_enter(struct mtk_dsi *dsi)
 {
 	mtk_dsi_mask(dsi, DSI_PHY_LD0CON, LD0_HS_TX_EN, 0);
-	mtk_dsi_mask(dsi, DSI_PHY_LD0CON, LD0_ULPM_EN, 0);
+	mtk_dsi_mask(dsi, DSI_PHY_LD0CON, LD0_ULPM_EN, LD0_ULPM_EN);
 }
 
 static void mtk_dsi_lane0_ulp_mode_leave(struct mtk_dsi *dsi)
-- 
1.9.1
