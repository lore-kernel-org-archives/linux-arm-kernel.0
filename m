From: erin.lo@mediatek.com (Erin Lo)
Date: Tue, 17 May 2016 13:05:09 +0800
Subject: [PATCH v8 08/10] reset: mediatek: Add MT2701 reset driver
In-Reply-To: <1463461511-25019-1-git-send-email-erin.lo@mediatek.com>
References: <1463461511-25019-1-git-send-email-erin.lo@mediatek.com>
Message-ID: <1463461511-25019-9-git-send-email-erin.lo@mediatek.com>
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
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/clk/mediatek/clk-mt2701-hif.c | 2 ++
 drivers/clk/mediatek/clk-mt2701.c     | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index 3f6cea2..28014bf 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -55,6 +55,8 @@ static void mtk_hifsys_init(struct device_node *node)
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
+
+	mtk_register_reset_controller(node, 1, 0x34);
 }
 
 static const struct of_device_id of_match_clk_mt2701_hif[] = {
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 08a2954..b3cde20 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -791,6 +791,8 @@ static void mtk_infrasys_init(struct device_node *node)
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
+
+	mtk_register_reset_controller(node, 2, 0x30);
 }
 
 static const struct mtk_gate_regs peri0_cg_regs = {
@@ -911,6 +913,8 @@ static void mtk_pericfg_init(struct device_node *node)
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
+
+	mtk_register_reset_controller(node, 2, 0x0);
 }
 
 #define MT8590_PLL_FMAX		(2000 * MHZ)
-- 
1.9.1
