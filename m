From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 28 Jul 2014 00:49:42 -0300
Subject: [RFC 4/8] clk: sunxi: add __iomem markings to MMIO pointers
In-Reply-To: <1406519386-4902-1-git-send-email-emilio@elopez.com.ar>
References: <1406519386-4902-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1406519386-4902-5-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds __iomem thoughout the sunxi clock driver, in places
where it was ommited. This cleans most of the sparse warnings we
are getting here.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---

These are just non-critical fixes, they can wait until the next release
if desired, although I feel they're trivial enough to go on -rc1 as well.

 drivers/clk/sunxi/clk-a20-gmac.c |  2 +-
 drivers/clk/sunxi/clk-sunxi.c    | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/sunxi/clk-a20-gmac.c b/drivers/clk/sunxi/clk-a20-gmac.c
index 633ddc4..5296fd6 100644
--- a/drivers/clk/sunxi/clk-a20-gmac.c
+++ b/drivers/clk/sunxi/clk-a20-gmac.c
@@ -60,7 +60,7 @@ static void __init sun7i_a20_gmac_clk_setup(struct device_node *node)
 	struct clk_gate *gate;
 	const char *clk_name = node->name;
 	const char *parents[SUN7I_A20_GMAC_PARENTS];
-	void *reg;
+	void __iomem *reg;
 
 	if (of_property_read_string(node, "clock-output-names", &clk_name))
 		return;
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 8975972..b654b7b 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -593,7 +593,7 @@ static struct clk * __init sunxi_factors_clk_setup(struct device_node *node,
 	struct clk_hw *mux_hw = NULL;
 	const char *clk_name = node->name;
 	const char *parents[SUNXI_MAX_PARENTS];
-	void *reg;
+	void __iomem *reg;
 	int i = 0;
 
 	reg = of_iomap(node, 0);
@@ -698,7 +698,7 @@ static void __init sunxi_mux_clk_setup(struct device_node *node,
 	struct clk *clk;
 	const char *clk_name = node->name;
 	const char *parents[SUNXI_MAX_PARENTS];
-	void *reg;
+	void __iomem *reg;
 	int i = 0;
 
 	reg = of_iomap(node, 0);
@@ -780,7 +780,7 @@ static void __init sunxi_divider_clk_setup(struct device_node *node,
 	struct clk *clk;
 	const char *clk_name = node->name;
 	const char *clk_parent;
-	void *reg;
+	void __iomem *reg;
 
 	reg = of_iomap(node, 0);
 
@@ -962,7 +962,7 @@ static void __init sunxi_gates_clk_setup(struct device_node *node,
 	struct gates_reset_data *reset_data;
 	const char *clk_parent;
 	const char *clk_name;
-	void *reg;
+	void __iomem *reg;
 	int qty;
 	int i = 0;
 	int j = 0;
@@ -1084,7 +1084,7 @@ static void __init sunxi_divs_clk_setup(struct device_node *node,
 	struct clk_gate *gate = NULL;
 	struct clk_fixed_factor *fix_factor;
 	struct clk_divider *divider;
-	void *reg;
+	void __iomem *reg;
 	int i = 0;
 	int flags, clkflags;
 
-- 
2.0.3
