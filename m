From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 28 Jul 2014 00:49:43 -0300
Subject: [RFC 5/8] clk: sunxi: staticize structures and arrays
In-Reply-To: <1406519386-4902-1-git-send-email-emilio@elopez.com.ar>
References: <1406519386-4902-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1406519386-4902-6-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some structs and arrays on the driver that are not used
anywhere else. Let's mark them as static.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---

These are just non-critical fixes, they can wait until the next release
if desired, although I feel they're trivial enough to go on -rc1 as well.

 drivers/clk/sunxi/clk-sun6i-apb0-gates.c | 2 +-
 drivers/clk/sunxi/clk-sun6i-apb0.c       | 2 +-
 drivers/clk/sunxi/clk-sun6i-ar100.c      | 4 ++--
 drivers/clk/sunxi/clk-sun8i-apb0.c       | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
index ef5e419..e10d052 100644
--- a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
+++ b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
@@ -29,7 +29,7 @@ static const struct gates_data sun8i_a23_apb0_gates __initconst = {
 	.mask = {0x5D},
 };
 
-const struct of_device_id sun6i_a31_apb0_gates_clk_dt_ids[] = {
+static const struct of_device_id sun6i_a31_apb0_gates_clk_dt_ids[] = {
 	{ .compatible = "allwinner,sun6i-a31-apb0-gates-clk", .data = &sun6i_a31_apb0_gates },
 	{ .compatible = "allwinner,sun8i-a23-apb0-gates-clk", .data = &sun8i_a23_apb0_gates },
 	{ /* sentinel */ }
diff --git a/drivers/clk/sunxi/clk-sun6i-apb0.c b/drivers/clk/sunxi/clk-sun6i-apb0.c
index 11f17c3..1fa2337 100644
--- a/drivers/clk/sunxi/clk-sun6i-apb0.c
+++ b/drivers/clk/sunxi/clk-sun6i-apb0.c
@@ -57,7 +57,7 @@ static int sun6i_a31_apb0_clk_probe(struct platform_device *pdev)
 	return of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
 
-const struct of_device_id sun6i_a31_apb0_clk_dt_ids[] = {
+static const struct of_device_id sun6i_a31_apb0_clk_dt_ids[] = {
 	{ .compatible = "allwinner,sun6i-a31-apb0-clk" },
 	{ /* sentinel */ }
 };
diff --git a/drivers/clk/sunxi/clk-sun6i-ar100.c b/drivers/clk/sunxi/clk-sun6i-ar100.c
index f73cc05..eca8ca0 100644
--- a/drivers/clk/sunxi/clk-sun6i-ar100.c
+++ b/drivers/clk/sunxi/clk-sun6i-ar100.c
@@ -160,7 +160,7 @@ static int ar100_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
-struct clk_ops ar100_ops = {
+static struct clk_ops ar100_ops = {
 	.recalc_rate = ar100_recalc_rate,
 	.determine_rate = ar100_determine_rate,
 	.set_parent = ar100_set_parent,
@@ -213,7 +213,7 @@ static int sun6i_a31_ar100_clk_probe(struct platform_device *pdev)
 	return of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
 
-const struct of_device_id sun6i_a31_ar100_clk_dt_ids[] = {
+static const struct of_device_id sun6i_a31_ar100_clk_dt_ids[] = {
 	{ .compatible = "allwinner,sun6i-a31-ar100-clk" },
 	{ /* sentinel */ }
 };
diff --git a/drivers/clk/sunxi/clk-sun8i-apb0.c b/drivers/clk/sunxi/clk-sun8i-apb0.c
index 196a499..1f5ba9b 100644
--- a/drivers/clk/sunxi/clk-sun8i-apb0.c
+++ b/drivers/clk/sunxi/clk-sun8i-apb0.c
@@ -48,7 +48,7 @@ static int sun8i_a23_apb0_clk_probe(struct platform_device *pdev)
 	return of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
 
-const struct of_device_id sun8i_a23_apb0_clk_dt_ids[] = {
+static const struct of_device_id sun8i_a23_apb0_clk_dt_ids[] = {
 	{ .compatible = "allwinner,sun8i-a23-apb0-clk" },
 	{ /* sentinel */ }
 };
-- 
2.0.3
