From: bhumirks@gmail.com (Bhumika Goyal)
Date: Tue, 22 Aug 2017 18:44:50 +0530
Subject: [PATCH] clk: spear: make clk_ops const
Message-ID: <1503407690-13541-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make these const as they are only stored in the const field of a
clk_init_data structure.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/clk/spear/clk-aux-synth.c  | 2 +-
 drivers/clk/spear/clk-frac-synth.c | 2 +-
 drivers/clk/spear/clk-gpt-synth.c  | 2 +-
 drivers/clk/spear/clk-vco-pll.c    | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/spear/clk-aux-synth.c b/drivers/clk/spear/clk-aux-synth.c
index f271c35..3bd00c8 100644
--- a/drivers/clk/spear/clk-aux-synth.c
+++ b/drivers/clk/spear/clk-aux-synth.c
@@ -128,7 +128,7 @@ static int clk_aux_set_rate(struct clk_hw *hw, unsigned long drate,
 	return 0;
 }
 
-static struct clk_ops clk_aux_ops = {
+static const struct clk_ops clk_aux_ops = {
 	.recalc_rate = clk_aux_recalc_rate,
 	.round_rate = clk_aux_round_rate,
 	.set_rate = clk_aux_set_rate,
diff --git a/drivers/clk/spear/clk-frac-synth.c b/drivers/clk/spear/clk-frac-synth.c
index 58d678b..eaf970b 100644
--- a/drivers/clk/spear/clk-frac-synth.c
+++ b/drivers/clk/spear/clk-frac-synth.c
@@ -116,7 +116,7 @@ static int clk_frac_set_rate(struct clk_hw *hw, unsigned long drate,
 	return 0;
 }
 
-static struct clk_ops clk_frac_ops = {
+static const struct clk_ops clk_frac_ops = {
 	.recalc_rate = clk_frac_recalc_rate,
 	.round_rate = clk_frac_round_rate,
 	.set_rate = clk_frac_set_rate,
diff --git a/drivers/clk/spear/clk-gpt-synth.c b/drivers/clk/spear/clk-gpt-synth.c
index 1a722e9..3641799 100644
--- a/drivers/clk/spear/clk-gpt-synth.c
+++ b/drivers/clk/spear/clk-gpt-synth.c
@@ -105,7 +105,7 @@ static int clk_gpt_set_rate(struct clk_hw *hw, unsigned long drate,
 	return 0;
 }
 
-static struct clk_ops clk_gpt_ops = {
+static const struct clk_ops clk_gpt_ops = {
 	.recalc_rate = clk_gpt_recalc_rate,
 	.round_rate = clk_gpt_round_rate,
 	.set_rate = clk_gpt_set_rate,
diff --git a/drivers/clk/spear/clk-vco-pll.c b/drivers/clk/spear/clk-vco-pll.c
index dc21ca4..069b48a 100644
--- a/drivers/clk/spear/clk-vco-pll.c
+++ b/drivers/clk/spear/clk-vco-pll.c
@@ -165,7 +165,7 @@ static int clk_pll_set_rate(struct clk_hw *hw, unsigned long drate,
 	return 0;
 }
 
-static struct clk_ops clk_pll_ops = {
+static const struct clk_ops clk_pll_ops = {
 	.recalc_rate = clk_pll_recalc_rate,
 	.round_rate = clk_pll_round_rate,
 	.set_rate = clk_pll_set_rate,
@@ -266,7 +266,7 @@ static int clk_vco_set_rate(struct clk_hw *hw, unsigned long drate,
 	return 0;
 }
 
-static struct clk_ops clk_vco_ops = {
+static const struct clk_ops clk_vco_ops = {
 	.recalc_rate = clk_vco_recalc_rate,
 	.round_rate = clk_vco_round_rate,
 	.set_rate = clk_vco_set_rate,
-- 
1.9.1
