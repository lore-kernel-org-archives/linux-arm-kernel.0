From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Fri, 3 Aug 2018 11:10:57 +0800
Subject: [PATCH v2 04/15] drm/mediatek: add connection from RDMA2 to DSI0
In-Reply-To: <1533265868-28110-1-git-send-email-stu.hsieh@mediatek.com>
References: <1533265868-28110-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1533265868-28110-5-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add connection from RDMA2 to DSI0

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 31189fad8d4e..3239f22785fd 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -125,6 +125,7 @@
 #define DPI1_SEL_IN_RDMA1		(0x1 << 8)
 #define DPI1_SEL_IN_RDMA2		(0x3 << 8)
 #define DSI0_SEL_IN_RDMA1		0x1
+#define DSI0_SEL_IN_RDMA2		0x4
 #define DSI1_SEL_IN_RDMA1		0x1
 #define DSI1_SEL_IN_RDMA2		0x4
 #define DSI2_SEL_IN_RDMA1		(0x1 << 16)
@@ -309,6 +310,9 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
 	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI1) {
 		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
 		value = DPI1_SEL_IN_RDMA2;
+	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI0) {
+		*addr = DISP_REG_CONFIG_DSIE_SEL_IN;
+		value = DSI0_SEL_IN_RDMA2;
 	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI1) {
 		*addr = DISP_REG_CONFIG_DSIE_SEL_IN;
 		value = DSI1_SEL_IN_RDMA2;
-- 
2.12.5.2.gbdf23ab
