From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Tue, 19 Jun 2018 15:34:10 +0800
Subject: [PATCH v6 09/29] drm/mediatek: add component DSI3
In-Reply-To: <1529393670-26862-1-git-send-email-stu.hsieh@mediatek.com>
References: <1529393670-26862-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1529393670-26862-10-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the component DSI3

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 2 ++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 071f9f5aefea..17b681686471 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -228,6 +228,7 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_DSI0]	= { MTK_DSI,		0, NULL },
 	[DDP_COMPONENT_DSI1]	= { MTK_DSI,		1, NULL },
 	[DDP_COMPONENT_DSI2]	= { MTK_DSI,		2, NULL },
+	[DDP_COMPONENT_DSI3]	= { MTK_DSI,		3, NULL },
 	[DDP_COMPONENT_GAMMA]	= { MTK_DISP_GAMMA,	0, &ddp_gamma },
 	[DDP_COMPONENT_OD0]	= { MTK_DISP_OD,	0, &ddp_od },
 	[DDP_COMPONENT_OD1]	= { MTK_DISP_OD,	1, &ddp_od },
@@ -280,6 +281,7 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 	    comp_id == DDP_COMPONENT_DPI1 ||
 	    comp_id == DDP_COMPONENT_DSI0 ||
 	    comp_id == DDP_COMPONENT_DSI2 ||
+	    comp_id == DDP_COMPONENT_DSI3 ||
 	    comp_id == DDP_COMPONENT_PWM0) {
 		comp->regs = NULL;
 		comp->clk = NULL;
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 8d152b337f15..7413ffeb3c9d 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -51,6 +51,7 @@ enum mtk_ddp_comp_id {
 	DDP_COMPONENT_DSI0,
 	DDP_COMPONENT_DSI1,
 	DDP_COMPONENT_DSI2,
+	DDP_COMPONENT_DSI3,
 	DDP_COMPONENT_GAMMA,
 	DDP_COMPONENT_OD0,
 	DDP_COMPONENT_OD1,
-- 
2.12.5
