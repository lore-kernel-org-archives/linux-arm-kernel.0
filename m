From: ulrich.hecht+renesas@gmail.com (Ulrich Hecht)
Date: Mon, 16 Oct 2017 17:31:40 +0200
Subject: [RFC v2 8/8] drm: mediatek: Fix drm_of_find_panel_or_bridge conversion
In-Reply-To: <1508167900-27415-1-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1508167900-27415-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <1508167900-27415-9-git-send-email-ulrich.hecht+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The port value should be 1 instead of 0; fixes DSI initialization on
MT8173 "Elm".

Fixes: ebc944613567 ("drm: convert drivers to use drm_of_find_panel_or_bridge")
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 7e5e24c..e5ec581 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -1105,7 +1105,7 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 	dsi->host.ops = &mtk_dsi_ops;
 	dsi->host.dev = dev;
 
-	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
+	ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0,
 					  &dsi->panel, &dsi->bridge);
 	if (ret)
 		return ret;
-- 
2.7.4
