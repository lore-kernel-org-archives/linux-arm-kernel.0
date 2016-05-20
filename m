From: yt.shen@mediatek.com (yt.shen at mediatek.com)
Date: Fri, 20 May 2016 23:05:32 +0800
Subject: [RFC v2 1/5] drm/mediatek: rename macros, add chip suffix
In-Reply-To: <1463756736-46573-1-git-send-email-yt.shen@mediatek.com>
References: <1463756736-46573-1-git-send-email-yt.shen@mediatek.com>
Message-ID: <1463756736-46573-2-git-send-email-yt.shen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: YT Shen <yt.shen@mediatek.com>

Add MT8173 suffix for hardware related macros.

Signed-off-by: YT Shen <yt.shen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c |   62 ++++++++++++++++----------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 17ba935..d6aafd4 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -36,21 +36,21 @@
 #define DISP_REG_MUTEX_MOD(n)	(0x2c + 0x20 * (n))
 #define DISP_REG_MUTEX_SOF(n)	(0x30 + 0x20 * (n))
 
-#define MUTEX_MOD_DISP_OVL0		BIT(11)
-#define MUTEX_MOD_DISP_OVL1		BIT(12)
-#define MUTEX_MOD_DISP_RDMA0		BIT(13)
-#define MUTEX_MOD_DISP_RDMA1		BIT(14)
-#define MUTEX_MOD_DISP_RDMA2		BIT(15)
-#define MUTEX_MOD_DISP_WDMA0		BIT(16)
-#define MUTEX_MOD_DISP_WDMA1		BIT(17)
-#define MUTEX_MOD_DISP_COLOR0		BIT(18)
-#define MUTEX_MOD_DISP_COLOR1		BIT(19)
-#define MUTEX_MOD_DISP_AAL		BIT(20)
-#define MUTEX_MOD_DISP_GAMMA		BIT(21)
-#define MUTEX_MOD_DISP_UFOE		BIT(22)
-#define MUTEX_MOD_DISP_PWM0		BIT(23)
-#define MUTEX_MOD_DISP_PWM1		BIT(24)
-#define MUTEX_MOD_DISP_OD		BIT(25)
+#define MUTEX_MOD_DISP_OVL0_MT8173		BIT(11)
+#define MUTEX_MOD_DISP_OVL1_MT8173		BIT(12)
+#define MUTEX_MOD_DISP_RDMA0_MT8173		BIT(13)
+#define MUTEX_MOD_DISP_RDMA1_MT8173		BIT(14)
+#define MUTEX_MOD_DISP_RDMA2_MT8173		BIT(15)
+#define MUTEX_MOD_DISP_WDMA0_MT8173		BIT(16)
+#define MUTEX_MOD_DISP_WDMA1_MT8173		BIT(17)
+#define MUTEX_MOD_DISP_COLOR0_MT8173		BIT(18)
+#define MUTEX_MOD_DISP_COLOR1_MT8173		BIT(19)
+#define MUTEX_MOD_DISP_AAL_MT8173		BIT(20)
+#define MUTEX_MOD_DISP_GAMMA_MT8173		BIT(21)
+#define MUTEX_MOD_DISP_UFOE_MT8173		BIT(22)
+#define MUTEX_MOD_DISP_PWM0_MT8173		BIT(23)
+#define MUTEX_MOD_DISP_PWM1_MT8173		BIT(24)
+#define MUTEX_MOD_DISP_OD_MT8173		BIT(25)
 
 #define MUTEX_SOF_SINGLE_MODE		0
 #define MUTEX_SOF_DSI0			1
@@ -79,22 +79,22 @@ struct mtk_ddp {
 	struct mtk_disp_mutex		mutex[10];
 };
 
-static const unsigned int mutex_mod[DDP_COMPONENT_ID_MAX] = {
-	[DDP_COMPONENT_AAL] = MUTEX_MOD_DISP_AAL,
-	[DDP_COMPONENT_COLOR0] = MUTEX_MOD_DISP_COLOR0,
-	[DDP_COMPONENT_COLOR1] = MUTEX_MOD_DISP_COLOR1,
-	[DDP_COMPONENT_GAMMA] = MUTEX_MOD_DISP_GAMMA,
-	[DDP_COMPONENT_OD] = MUTEX_MOD_DISP_OD,
-	[DDP_COMPONENT_OVL0] = MUTEX_MOD_DISP_OVL0,
-	[DDP_COMPONENT_OVL1] = MUTEX_MOD_DISP_OVL1,
-	[DDP_COMPONENT_PWM0] = MUTEX_MOD_DISP_PWM0,
-	[DDP_COMPONENT_PWM1] = MUTEX_MOD_DISP_PWM1,
-	[DDP_COMPONENT_RDMA0] = MUTEX_MOD_DISP_RDMA0,
-	[DDP_COMPONENT_RDMA1] = MUTEX_MOD_DISP_RDMA1,
-	[DDP_COMPONENT_RDMA2] = MUTEX_MOD_DISP_RDMA2,
-	[DDP_COMPONENT_UFOE] = MUTEX_MOD_DISP_UFOE,
-	[DDP_COMPONENT_WDMA0] = MUTEX_MOD_DISP_WDMA0,
-	[DDP_COMPONENT_WDMA1] = MUTEX_MOD_DISP_WDMA1,
+static const unsigned int mutex_mod_mt8173[DDP_COMPONENT_ID_MAX] = {
+	[DDP_COMPONENT_AAL] = MUTEX_MOD_DISP_AAL_MT8173,
+	[DDP_COMPONENT_COLOR0] = MUTEX_MOD_DISP_COLOR0_MT8173,
+	[DDP_COMPONENT_COLOR1] = MUTEX_MOD_DISP_COLOR1_MT8173,
+	[DDP_COMPONENT_GAMMA] = MUTEX_MOD_DISP_GAMMA_MT8173,
+	[DDP_COMPONENT_OD] = MUTEX_MOD_DISP_OD_MT8173,
+	[DDP_COMPONENT_OVL0] = MUTEX_MOD_DISP_OVL0_MT8173,
+	[DDP_COMPONENT_OVL1] = MUTEX_MOD_DISP_OVL1_MT8173,
+	[DDP_COMPONENT_PWM0] = MUTEX_MOD_DISP_PWM0_MT8173,
+	[DDP_COMPONENT_PWM1] = MUTEX_MOD_DISP_PWM1_MT8173,
+	[DDP_COMPONENT_RDMA0] = MUTEX_MOD_DISP_RDMA0_MT8173,
+	[DDP_COMPONENT_RDMA1] = MUTEX_MOD_DISP_RDMA1_MT8173,
+	[DDP_COMPONENT_RDMA2] = MUTEX_MOD_DISP_RDMA2_MT8173,
+	[DDP_COMPONENT_UFOE] = MUTEX_MOD_DISP_UFOE_MT8173,
+	[DDP_COMPONENT_WDMA0] = MUTEX_MOD_DISP_WDMA0_MT8173,
+	[DDP_COMPONENT_WDMA1] = MUTEX_MOD_DISP_WDMA1_MT8173,
 };
 
 static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
-- 
1.7.9.5
