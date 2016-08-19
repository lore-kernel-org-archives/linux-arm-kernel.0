From: erin.lo@mediatek.com (Erin Lo)
Date: Fri, 19 Aug 2016 13:34:48 +0800
Subject: [PATCH v11 1/9] clk: mediatek: remove __init from clk registration
 functions
In-Reply-To: <1471584896-9986-1-git-send-email-erin.lo@mediatek.com>
References: <1471584896-9986-1-git-send-email-erin.lo@mediatek.com>
Message-ID: <1471584896-9986-2-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Liao <jamesjj.liao@mediatek.com>

Remove __init from functions that will be used by init functions
that support probe deferral.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 drivers/clk/mediatek/clk-gate.c |  2 +-
 drivers/clk/mediatek/clk-mtk.c  | 12 ++++++------
 drivers/clk/mediatek/clk-pll.c  |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index 2a76901..d8787bf 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -97,7 +97,7 @@ const struct clk_ops mtk_clk_gate_ops_setclr_inv = {
 	.disable	= mtk_cg_disable_inv,
 };
 
-struct clk * __init mtk_clk_register_gate(
+struct clk *mtk_clk_register_gate(
 		const char *name,
 		const char *parent_name,
 		struct regmap *regmap,
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 5ada644..bb30f70 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -24,7 +24,7 @@
 #include "clk-mtk.h"
 #include "clk-gate.h"
 
-struct clk_onecell_data * __init mtk_alloc_clk_data(unsigned int clk_num)
+struct clk_onecell_data *mtk_alloc_clk_data(unsigned int clk_num)
 {
 	int i;
 	struct clk_onecell_data *clk_data;
@@ -49,7 +49,7 @@ err_out:
 	return NULL;
 }
 
-void __init mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks,
+void mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks,
 		int num, struct clk_onecell_data *clk_data)
 {
 	int i;
@@ -72,7 +72,7 @@ void __init mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks,
 	}
 }
 
-void __init mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
+void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
 		int num, struct clk_onecell_data *clk_data)
 {
 	int i;
@@ -95,7 +95,7 @@ void __init mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
 	}
 }
 
-int __init mtk_clk_register_gates(struct device_node *node,
+int mtk_clk_register_gates(struct device_node *node,
 		const struct mtk_gate *clks,
 		int num, struct clk_onecell_data *clk_data)
 {
@@ -135,7 +135,7 @@ int __init mtk_clk_register_gates(struct device_node *node,
 	return 0;
 }
 
-struct clk * __init mtk_clk_register_composite(const struct mtk_composite *mc,
+struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
 		void __iomem *base, spinlock_t *lock)
 {
 	struct clk *clk;
@@ -222,7 +222,7 @@ err_out:
 	return ERR_PTR(ret);
 }
 
-void __init mtk_clk_register_composites(const struct mtk_composite *mcs,
+void mtk_clk_register_composites(const struct mtk_composite *mcs,
 		int num, void __iomem *base, spinlock_t *lock,
 		struct clk_onecell_data *clk_data)
 {
diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 966cab1..0c2deac 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -313,7 +313,7 @@ static struct clk *mtk_clk_register_pll(const struct mtk_pll_data *data,
 	return clk;
 }
 
-void __init mtk_clk_register_plls(struct device_node *node,
+void mtk_clk_register_plls(struct device_node *node,
 		const struct mtk_pll_data *plls, int num_plls, struct clk_onecell_data *clk_data)
 {
 	void __iomem *base;
-- 
1.9.1
