From: vincent.stehle@laposte.net (=?UTF-8?q?Vincent=20Stehl=C3=A9?=)
Date: Thu, 27 Oct 2016 22:23:25 +0200
Subject: [PATCH next 2/2] media: mtk-mdp: NULL-terminate mtk_mdp_comp_dt_ids
In-Reply-To: <20161027202325.20680-1-vincent.stehle@laposte.net>
References: <1473340146-6598-4-git-send-email-minghsiu.tsai@mediatek.com>
 <20161027202325.20680-1-vincent.stehle@laposte.net>
Message-ID: <20161027202325.20680-2-vincent.stehle@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mtk_mdp_comp_dt_ids[] array should be NULL-terminated; add therefore an
empty entry in the end.

Fixes: c8eb2d7e8202fd9c ("[media] media: Add Mediatek MDP Driver")
Signed-off-by: Vincent Stehl? <vincent.stehle@laposte.net>
Cc: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
index 40a229d..53296e2 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
@@ -50,7 +50,8 @@ static const struct of_device_id mtk_mdp_comp_dt_ids[] = {
 	}, {
 		.compatible = "mediatek,mt8173-mdp-wrot",
 		.data = (void *)MTK_MDP_WROT
-	}
+	},
+	{ },
 };
 
 static const struct of_device_id mtk_mdp_of_ids[] = {
-- 
2.9.3
