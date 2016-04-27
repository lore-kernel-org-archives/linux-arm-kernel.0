From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 27 Apr 2016 10:51:26 +0200
Subject: [PATCH] memory: mtk-smi: export mtk_smi_larb_get/put
Message-ID: <1461747086-26286-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To allow building mediatek-drm.ko as a module, the
mtk_smi_larb_get and mtk_smi_larb_put symbols have
to be exported.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/memory/mtk-smi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 089091f..f6b5757 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -91,6 +91,7 @@ int mtk_smi_larb_get(struct device *larbdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtk_smi_larb_get);
 
 void mtk_smi_larb_put(struct device *larbdev)
 {
@@ -106,6 +107,7 @@ void mtk_smi_larb_put(struct device *larbdev)
 	mtk_smi_disable(&larb->smi);
 	mtk_smi_disable(common);
 }
+EXPORT_SYMBOL_GPL(mtk_smi_larb_put);
 
 static int
 mtk_smi_larb_bind(struct device *dev, struct device *master, void *data)
-- 
2.8.0.rc3
