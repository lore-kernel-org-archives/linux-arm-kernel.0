From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 4 Aug 2015 16:16:51 +0800
Subject: [PATCH v6 2/9] clk: mediatek: Remove unused code from MT8173.
In-Reply-To: <1438676218-11310-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1438676218-11310-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1438676218-11310-3-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unused header files from MT8173, and remove unused
keywords from function declaration.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 drivers/clk/mediatek/clk-mt8173.c | 2 --
 drivers/clk/mediatek/clk-mtk.h    | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 80871e2..13aa432 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -14,8 +14,6 @@
 
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/slab.h>
-#include <linux/mfd/syscon.h>
 
 #include "clk-mtk.h"
 #include "clk-gate.h"
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 9dda9d8..740fe5e 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -41,7 +41,7 @@ struct mtk_fixed_factor {
 		.div = _div,				\
 	}
 
-extern void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
+void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
 		int num, struct clk_onecell_data *clk_data);
 
 struct mtk_composite {
@@ -152,7 +152,7 @@ struct mtk_pll_data {
 	int pcw_shift;
 };
 
-void __init mtk_clk_register_plls(struct device_node *node,
+void mtk_clk_register_plls(struct device_node *node,
 		const struct mtk_pll_data *plls, int num_plls,
 		struct clk_onecell_data *clk_data);
 
-- 
1.8.1.1.dirty
