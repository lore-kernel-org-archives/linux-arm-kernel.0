From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Mon, 11 Jun 2018 11:26:13 +0800
Subject: [PATCH 21/28] drm/mediatek: add connection from RDMA2 to DSI2
In-Reply-To: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
References: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1528687580-549-22-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the connection from RDMA2 to DSI2

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index ae10f8f1e140..ce89a1d86b93 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -95,6 +95,7 @@
 #define RDMA2_MOUT_DPI0			0x2
 #define RDMA2_MOUT_DPI1			0x3
 #define RDMA2_MOUT_DSI1			0x1
+#define RDMA2_MOUT_DSI2			0x4
 #define DPI0_SEL_IN_RDMA1		0x1
 #define DPI0_SEL_IN_RDMA2		0x3
 #define DPI1_SEL_IN_RDMA1		(0x1 << 8)
@@ -102,6 +103,7 @@
 #define DSI1_SEL_IN_RDMA1		0x1
 #define DSI1_SEL_IN_RDMA2		0x4
 #define DSI2_SEL_IN_RDMA1		(0x1 << 16)
+#define DSI2_SEL_IN_RDMA2		(0x4 << 16)
 #define DSI3_SEL_IN_RDMA1		(0x1 << 16)
 #define COLOR1_SEL_IN_OVL1		0x1
 
@@ -209,6 +211,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
 	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI1) {
 		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
 		value = RDMA2_MOUT_DPI1;
+	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI2) {
+		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
+		value = RDMA2_MOUT_DSI2;
 	} else {
 		value = 0;
 	}
@@ -249,6 +254,9 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
 	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI1) {
 		*addr = DISP_REG_CONFIG_DSIE_SEL_IN;
 		value = DSI1_SEL_IN_RDMA2;
+	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI2) {
+		*addr = DISP_REG_CONFIG_DSIE_SEL_IN;
+		value = DSI2_SEL_IN_RDMA2;
 	} else if (cur == DDP_COMPONENT_OVL1 && next == DDP_COMPONENT_COLOR1) {
 		*addr = DISP_REG_CONFIG_DISP_COLOR1_SEL_IN;
 		value = COLOR1_SEL_IN_OVL1;
-- 
2.12.5
