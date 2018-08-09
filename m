From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Thu, 9 Aug 2018 10:15:45 +0800
Subject: [PATCH v4 10/14] drm/mediatek: add function to return OVL layer number
In-Reply-To: <1533780949-30141-1-git-send-email-stu.hsieh@mediatek.com>
References: <1533780949-30141-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1533780949-30141-11-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add function to return OVL layer number

For now, MT8173, MT2712, MT2701 OVL all has 4 layer.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 0facd823c552..28d191192945 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -132,6 +132,11 @@ static void mtk_ovl_config(struct mtk_ddp_comp *comp, unsigned int w,
 	writel(0x0, comp->regs + DISP_REG_OVL_RST);
 }
 
+static unsigned int mtk_ovl_layer_nr(struct mtk_ddp_comp *comp)
+{
+	return 4;
+}
+
 static void mtk_ovl_layer_on(struct mtk_ddp_comp *comp, unsigned int idx)
 {
 	unsigned int reg;
@@ -226,6 +231,7 @@ static const struct mtk_ddp_comp_funcs mtk_disp_ovl_funcs = {
 	.stop = mtk_ovl_stop,
 	.enable_vblank = mtk_ovl_enable_vblank,
 	.disable_vblank = mtk_ovl_disable_vblank,
+	.layer_nr = mtk_ovl_layer_nr,
 	.layer_on = mtk_ovl_layer_on,
 	.layer_off = mtk_ovl_layer_off,
 	.layer_config = mtk_ovl_layer_config,
-- 
2.12.5.2.gbdf23ab
