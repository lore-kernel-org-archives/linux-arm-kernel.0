From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Thu, 9 Aug 2018 10:15:46 +0800
Subject: [PATCH v4 11/14] drm/mediatek: add function to return RDMA layer
 number
In-Reply-To: <1533780949-30141-1-git-send-email-stu.hsieh@mediatek.com>
References: <1533780949-30141-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1533780949-30141-12-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add function to return RDMA layer number

RDMA always has one layer.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 8b015c2d4418..9da0fa6c6806 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -193,6 +193,11 @@ static unsigned int rdma_fmt_convert(struct mtk_disp_rdma *rdma,
 	}
 }
 
+static unsigned int mtk_rdma_layer_nr(struct mtk_ddp_comp *comp)
+{
+	return 1;
+}
+
 static void mtk_rdma_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
 				  struct mtk_plane_state *state)
 {
@@ -230,6 +235,7 @@ static const struct mtk_ddp_comp_funcs mtk_disp_rdma_funcs = {
 	.stop = mtk_rdma_stop,
 	.enable_vblank = mtk_rdma_enable_vblank,
 	.disable_vblank = mtk_rdma_disable_vblank,
+	.layer_nr = mtk_rdma_layer_nr,
 	.layer_config = mtk_rdma_layer_config,
 };
 
-- 
2.12.5.2.gbdf23ab
