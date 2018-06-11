From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Mon, 11 Jun 2018 11:26:18 +0800
Subject: [PATCH 26/28] drm/mediatek: add DPI1/DSI1/DSI2/DSI3 in comp_init
In-Reply-To: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
References: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1528687580-549-27-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add components DPI1/DSI1/DSI2/DSI3 in comp_init.
Because the some parameter for these components initialized
in their driver.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 22f4c72fa785..ff974d82a4a6 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -278,7 +278,11 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 
 	if (comp_id == DDP_COMPONENT_BLS ||
 	    comp_id == DDP_COMPONENT_DPI0 ||
+	    comp_id == DDP_COMPONENT_DPI1 ||
 	    comp_id == DDP_COMPONENT_DSI0 ||
+	    comp_id == DDP_COMPONENT_DSI1 ||
+	    comp_id == DDP_COMPONENT_DSI2 ||
+	    comp_id == DDP_COMPONENT_DSI3 ||
 	    comp_id == DDP_COMPONENT_PWM0) {
 		comp->regs = NULL;
 		comp->clk = NULL;
-- 
2.12.5
