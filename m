From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 20 Jan 2016 14:35:47 +0800
Subject: [PATCH v4 6/6] reset: mediatek: Add MT2701 reset driver
In-Reply-To: <1453271747-57397-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1453271747-57397-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1453271747-57397-7-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shunli Wang <shunli.wang@mediatek.com>

In infrasys and perifsys, there are many reset
control bits for kinds of modules. These bits are
used as actual reset controllers to be registered
into kernel's generic reset controller framework.

Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
Tested-by: John Crispin <blogic@openwrt.org>
---
 drivers/clk/mediatek/clk-mt2701.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 82f9c1c..4e5b51f 100644
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
 
@@ -996,6 +1000,8 @@ static void __init mtk_hifsys_init(struct device_node *node)
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
+
+	mtk_register_reset_controller(node, 1, 0x34);
 }
 CLK_OF_DECLARE(mtk_hifsys, "mediatek,mt2701-hifsys", mtk_hifsys_init);
 
-- 
1.9.1
