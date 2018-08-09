From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Thu, 9 Aug 2018 10:15:49 +0800
Subject: [PATCH v4 14/14] drm/mediatek: fix connection from RDMA2 to DSI1
In-Reply-To: <1533780949-30141-1-git-send-email-stu.hsieh@mediatek.com>
References: <1533780949-30141-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1533780949-30141-15-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix connection from RDMA2 to DSI1

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 3239f22785fd..546b3e3b300b 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -314,7 +314,7 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
 		*addr = DISP_REG_CONFIG_DSIE_SEL_IN;
 		value = DSI0_SEL_IN_RDMA2;
 	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI1) {
-		*addr = DISP_REG_CONFIG_DSIE_SEL_IN;
+		*addr = DISP_REG_CONFIG_DSIO_SEL_IN;
 		value = DSI1_SEL_IN_RDMA2;
 	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI2) {
 		*addr = DISP_REG_CONFIG_DSIE_SEL_IN;
-- 
2.12.5.2.gbdf23ab
