From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Tue, 19 Jun 2018 15:34:28 +0800
Subject: [PATCH v6 27/29] drm/mediatek: add DSI3 support for mutex
In-Reply-To: <1529393670-26862-1-git-send-email-stu.hsieh@mediatek.com>
References: <1529393670-26862-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1529393670-26862-28-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the DSI3 support for mutex

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index a0b526b16da1..15e436d4e8a0 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -78,6 +78,7 @@
 #define MUTEX_SOF_DPI0			3
 #define MUTEX_SOF_DPI1			4
 #define MUTEX_SOF_DSI2			5
+#define MUTEX_SOF_DSI3			6
 
 #define OVL0_MOUT_EN_COLOR0		0x1
 #define OD_MOUT_EN_RDMA0		0x1
@@ -387,6 +388,9 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
 	case DDP_COMPONENT_DSI2:
 		reg = MUTEX_SOF_DSI2;
 		break;
+	case DDP_COMPONENT_DSI3:
+		reg = MUTEX_SOF_DSI3;
+		break;
 	case DDP_COMPONENT_DPI0:
 		reg = MUTEX_SOF_DPI0;
 		break;
@@ -425,6 +429,7 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
 	case DDP_COMPONENT_DSI0:
 	case DDP_COMPONENT_DSI1:
 	case DDP_COMPONENT_DSI2:
+	case DDP_COMPONENT_DSI3:
 	case DDP_COMPONENT_DPI0:
 	case DDP_COMPONENT_DPI1:
 		writel_relaxed(MUTEX_SOF_SINGLE_MODE,
-- 
2.12.5
