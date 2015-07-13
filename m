From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Mon, 13 Jul 2015 17:32:48 +0800
Subject: [PATCH 4/5] clk: mediatek: add 13mhz clock for MT8173
In-Reply-To: <1436779969-18610-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1436779969-18610-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1436779969-18610-5-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 13mhz clock used by GPT timer in infracfg.

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mt8173.c      | 5 +++++
 include/dt-bindings/clock/mt8173-clk.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 4b9e04c..540c5c3 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -618,6 +618,10 @@ static const struct mtk_gate infra_clks[] __initconst = {
 	GATE_ICG(CLK_INFRA_PMICWRAP, "infra_pmicwrap", "axi_sel", 23),
 };
 
+static const struct mtk_fixed_factor infra_divs[] __initconst = {
+	FACTOR(CLK_INFRA_CLK_13M, "clk13m", "clk26m", 1, 2),
+};
+
 static const struct mtk_gate_regs peri0_cg_regs = {
 	.set_ofs = 0x0008,
 	.clr_ofs = 0x0010,
@@ -737,6 +741,7 @@ static void __init mtk_infrasys_init(struct device_node *node)
 
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
 						clk_data);
+	mtk_clk_register_factors(infra_divs, ARRAY_SIZE(infra_divs), clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 	if (r)
diff --git a/include/dt-bindings/clock/mt8173-clk.h b/include/dt-bindings/clock/mt8173-clk.h
index 4ad76ed..fa2a2bb 100644
--- a/include/dt-bindings/clock/mt8173-clk.h
+++ b/include/dt-bindings/clock/mt8173-clk.h
@@ -187,7 +187,8 @@
 #define CLK_INFRA_CEC			9
 #define CLK_INFRA_PMICSPI		10
 #define CLK_INFRA_PMICWRAP		11
-#define CLK_INFRA_NR_CLK		12
+#define CLK_INFRA_CLK_13M		12
+#define CLK_INFRA_NR_CLK		13
 
 /* PERI_SYS */
 
-- 
1.8.1.1.dirty
