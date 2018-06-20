From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Wed, 20 Jun 2018 16:19:23 +0800
Subject: [PATCH v7 21/29] drm/mediatek: add connection from RDMA2 to DPI1
In-Reply-To: <1529482771-2153-1-git-send-email-stu.hsieh@mediatek.com>
References: <1529482771-2153-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1529482771-2153-22-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the connection from RDMA2 to DPI1

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index c88742a6c2b9..a4b418302f32 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -93,9 +93,11 @@
 #define RDMA1_SOUT_DSI2			0x4
 #define RDMA1_SOUT_DSI3			0x5
 #define RDMA2_SOUT_DPI0			0x2
+#define RDMA2_SOUT_DPI1			0x3
 #define DPI0_SEL_IN_RDMA1		0x1
 #define DPI0_SEL_IN_RDMA2		0x3
 #define DPI1_SEL_IN_RDMA1		(0x1 << 8)
+#define DPI1_SEL_IN_RDMA2		(0x3 << 8)
 #define DSI1_SEL_IN_RDMA1		0x1
 #define DSI2_SEL_IN_RDMA1		(0x1 << 16)
 #define DSI3_SEL_IN_RDMA1		(0x1 << 16)
@@ -199,6 +201,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
 	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI0) {
 		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
 		value = RDMA2_SOUT_DPI0;
+	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI1) {
+		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
+		value = RDMA2_SOUT_DPI1;
 	} else {
 		value = 0;
 	}
@@ -233,6 +238,9 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
 	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI0) {
 		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
 		value = DPI0_SEL_IN_RDMA2;
+	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI1) {
+		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
+		value = DPI1_SEL_IN_RDMA2;
 	} else if (cur == DDP_COMPONENT_OVL1 && next == DDP_COMPONENT_COLOR1) {
 		*addr = DISP_REG_CONFIG_DISP_COLOR1_SEL_IN;
 		value = COLOR1_SEL_IN_OVL1;
-- 
2.12.5
