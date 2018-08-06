From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Mon, 6 Aug 2018 19:58:15 +0800
Subject: [PATCH v3 08/13] drm/mediatek: add function to get layer number for
 component
In-Reply-To: <1533556700-26525-1-git-send-email-stu.hsieh@mediatek.com>
References: <1533556700-26525-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1533556700-26525-9-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add function to get layer number for component

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 7413ffeb3c9d..8399229e6ad2 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -78,6 +78,7 @@ struct mtk_ddp_comp_funcs {
 	void (*stop)(struct mtk_ddp_comp *comp);
 	void (*enable_vblank)(struct mtk_ddp_comp *comp, struct drm_crtc *crtc);
 	void (*disable_vblank)(struct mtk_ddp_comp *comp);
+	unsigned int (*layer_nr)(struct mtk_ddp_comp *comp);
 	void (*layer_on)(struct mtk_ddp_comp *comp, unsigned int idx);
 	void (*layer_off)(struct mtk_ddp_comp *comp, unsigned int idx);
 	void (*layer_config)(struct mtk_ddp_comp *comp, unsigned int idx,
@@ -128,6 +129,14 @@ static inline void mtk_ddp_comp_disable_vblank(struct mtk_ddp_comp *comp)
 		comp->funcs->disable_vblank(comp);
 }
 
+static inline unsigned int mtk_ddp_comp_layer_nr(struct mtk_ddp_comp *comp)
+{
+	if (comp->funcs && comp->funcs->layer_nr)
+		return comp->funcs->layer_nr(comp);
+
+	return 0;
+}
+
 static inline void mtk_ddp_comp_layer_on(struct mtk_ddp_comp *comp,
 					 unsigned int idx)
 {
-- 
2.12.5.2.gbdf23ab
