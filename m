From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Wed, 20 Jun 2018 16:19:15 +0800
Subject: [PATCH v7 13/29] drm/mediatek: add connection from RDMA0 to DPI0
In-Reply-To: <1529482771-2153-1-git-send-email-stu.hsieh@mediatek.com>
References: <1529482771-2153-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1529482771-2153-14-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the connection from RDMA0 to DPI0

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 977df8facb79..3a3f37f523f2 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -29,6 +29,7 @@
 #define DISP_REG_CONFIG_DISP_COLOR0_SEL_IN	0x084
 #define DISP_REG_CONFIG_DISP_COLOR1_SEL_IN	0x088
 #define DISP_REG_CONFIG_DPI_SEL_IN		0x0ac
+#define DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN	0x0c4
 #define DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN	0x0c8
 #define DISP_REG_CONFIG_MMSYS_CG_CON0		0x100
 
@@ -80,6 +81,7 @@
 #define COLOR0_SEL_IN_OVL0		0x1
 #define OVL1_MOUT_EN_COLOR1		0x1
 #define GAMMA_MOUT_EN_RDMA1		0x1
+#define RDMA0_SOUT_DPI0			0x2
 #define RDMA1_SOUT_DPI0			0x2
 #define DPI0_SEL_IN_RDMA1		0x1
 #define COLOR1_SEL_IN_OVL1		0x1
@@ -155,6 +157,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
 	} else if (cur == DDP_COMPONENT_OD1 && next == DDP_COMPONENT_RDMA1) {
 		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
 		value = OD1_MOUT_EN_RDMA1;
+	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DPI0) {
+		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
+		value = RDMA0_SOUT_DPI0;
 	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
 		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
 		value = RDMA1_SOUT_DPI0;
-- 
2.12.5
