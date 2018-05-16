From: peda@axentia.se (Peter Rosin)
Date: Wed, 16 May 2018 12:15:04 +0200
Subject: [PATCH v3 20/26] drm/mediatek: hdmi: provide an owner .odev device
 for the bridge
In-Reply-To: <20180516101510.13215-1-peda@axentia.se>
References: <20180516101510.13215-1-peda@axentia.se>
Message-ID: <20180516101510.13215-21-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 59a11026dceb..d8c7d93d0a87 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1694,8 +1694,8 @@ static int mtk_drm_hdmi_probe(struct platform_device *pdev)
 
 	mtk_hdmi_register_audio_driver(dev);
 
+	hdmi->bridge.odev = &pdev->dev;
 	hdmi->bridge.funcs = &mtk_hdmi_bridge_funcs;
-	hdmi->bridge.of_node = pdev->dev.of_node;
 	drm_bridge_add(&hdmi->bridge);
 
 	ret = mtk_hdmi_clk_enable_audio(hdmi);
-- 
2.11.0
