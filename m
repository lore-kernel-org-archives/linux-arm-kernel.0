From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Tue, 19 Jun 2018 15:34:16 +0800
Subject: [PATCH v6 15/29] drm/mediatek: add connection from RDMA0 to DSI3
In-Reply-To: <1529393670-26862-1-git-send-email-stu.hsieh@mediatek.com>
References: <1529393670-26862-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1529393670-26862-16-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the connection from RDMA0 to DSI3

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index f985bad61d83..463ed7830d17 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -83,6 +83,7 @@
 #define GAMMA_MOUT_EN_RDMA1		0x1
 #define RDMA0_SOUT_DPI0			0x2
 #define RDMA0_SOUT_DSI2			0x4
+#define RDMA0_SOUT_DSI3			0x5
 #define RDMA1_SOUT_DPI0			0x2
 #define DPI0_SEL_IN_RDMA1		0x1
 #define COLOR1_SEL_IN_OVL1		0x1
@@ -164,6 +165,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
 	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI2) {
 		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
 		value = RDMA0_SOUT_DSI2;
+	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI3) {
+		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
+		value = RDMA0_SOUT_DSI3;
 	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
 		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
 		value = RDMA1_SOUT_DPI0;
-- 
2.12.5
