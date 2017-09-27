From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 27 Sep 2017 18:15:26 +0200
Subject: [PATCH] clk/spear: Delete five error messages for a failed memory
 allocation
Message-ID: <4283fdab-7005-f774-9594-821582c5a9fb@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Sep 2017 18:00:21 +0200

Omit extra messages for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/clk/spear/clk-aux-synth.c  | 4 +---
 drivers/clk/spear/clk-frac-synth.c | 4 +---
 drivers/clk/spear/clk-gpt-synth.c  | 4 +---
 drivers/clk/spear/clk-vco-pll.c    | 8 ++------
 4 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/spear/clk-aux-synth.c b/drivers/clk/spear/clk-aux-synth.c
index f271c350ef94..ee7a7c043e3b 100644
--- a/drivers/clk/spear/clk-aux-synth.c
+++ b/drivers/clk/spear/clk-aux-synth.c
@@ -149,10 +149,8 @@ struct clk *clk_register_aux(const char *aux_name, const char *gate_name,
 	}
 
 	aux = kzalloc(sizeof(*aux), GFP_KERNEL);
-	if (!aux) {
-		pr_err("could not allocate aux clk\n");
+	if (!aux)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	/* struct clk_aux assignments */
 	if (!masks)
diff --git a/drivers/clk/spear/clk-frac-synth.c b/drivers/clk/spear/clk-frac-synth.c
index 58d678b5b40a..c48f3ed2d570 100644
--- a/drivers/clk/spear/clk-frac-synth.c
+++ b/drivers/clk/spear/clk-frac-synth.c
@@ -136,10 +136,8 @@ struct clk *clk_register_frac(const char *name, const char *parent_name,
 	}
 
 	frac = kzalloc(sizeof(*frac), GFP_KERNEL);
-	if (!frac) {
-		pr_err("could not allocate frac clk\n");
+	if (!frac)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	/* struct clk_frac assignments */
 	frac->reg = reg;
diff --git a/drivers/clk/spear/clk-gpt-synth.c b/drivers/clk/spear/clk-gpt-synth.c
index 1a722e99e76e..6e95d7f3ade9 100644
--- a/drivers/clk/spear/clk-gpt-synth.c
+++ b/drivers/clk/spear/clk-gpt-synth.c
@@ -125,10 +125,8 @@ struct clk *clk_register_gpt(const char *name, const char *parent_name, unsigned
 	}
 
 	gpt = kzalloc(sizeof(*gpt), GFP_KERNEL);
-	if (!gpt) {
-		pr_err("could not allocate gpt clk\n");
+	if (!gpt)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	/* struct clk_gpt assignments */
 	gpt->reg = reg;
diff --git a/drivers/clk/spear/clk-vco-pll.c b/drivers/clk/spear/clk-vco-pll.c
index dc21ca4601aa..e06b821fa60e 100644
--- a/drivers/clk/spear/clk-vco-pll.c
+++ b/drivers/clk/spear/clk-vco-pll.c
@@ -292,16 +292,12 @@ struct clk *clk_register_vco_pll(const char *vco_name, const char *pll_name,
 	}
 
 	vco = kzalloc(sizeof(*vco), GFP_KERNEL);
-	if (!vco) {
-		pr_err("could not allocate vco clk\n");
+	if (!vco)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
-	if (!pll) {
-		pr_err("could not allocate pll clk\n");
+	if (!pll)
 		goto free_vco;
-	}
 
 	/* struct clk_vco assignments */
 	vco->mode_reg = mode_reg;
-- 
2.14.2
