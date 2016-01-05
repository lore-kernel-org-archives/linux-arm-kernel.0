From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 5 Jan 2016 14:30:22 +0800
Subject: [PATCH v2 6/6] reset: mediatek: mt2701 reset driver
In-Reply-To: <1451975422-31174-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1451975422-31174-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1451975422-31174-7-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shunli Wang <shunli.wang@mediatek.com>

In infrasys and perifsys, there are many reset
control bits for kinds of modules. These bits are
used as actual reset controllers to be registered
into kernel's generic reset controller framework.

Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
---
 drivers/clk/mediatek/clk-mt2701.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 2f521f4..39472e4 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -665,6 +665,8 @@ static void __init mtk_infrasys_init(struct device_node *node)
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
+
+	mtk_register_reset_controller(node, 2, 0x30);
 }
 CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt2701-infracfg", mtk_infrasys_init);
 
@@ -782,6 +784,8 @@ static void __init mtk_pericfg_init(struct device_node *node)
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
+
+	mtk_register_reset_controller(node, 2, 0x0);
 }
 CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt2701-pericfg", mtk_pericfg_init);
 
-- 
1.9.1
