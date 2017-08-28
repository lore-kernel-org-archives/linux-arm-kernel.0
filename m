From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon, 28 Aug 2017 12:32:39 +0530
Subject: [PATCH 1/3] clk: ux500: prcmu: constify clk_ops.
In-Reply-To: <1503903761-21730-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503903761-21730-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1503903761-21730-2-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_ops are not supposed to change at runtime. All functions
working with clk_ops provided by <linux/clk-provider.h> work
with const clk_ops. So mark the non-const clk_ops as const.

Here, Function "clk_reg_prcmu" is used to initialized clk_init_data.
clk_init_data is working with const clk_ops. So make clk_reg_prcmu
non-const clk_ops argument as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/clk/ux500/clk-prcmu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/ux500/clk-prcmu.c b/drivers/clk/ux500/clk-prcmu.c
index 7f34382..6e3e16b 100644
--- a/drivers/clk/ux500/clk-prcmu.c
+++ b/drivers/clk/ux500/clk-prcmu.c
@@ -186,7 +186,7 @@ static void clk_prcmu_opp_volt_unprepare(struct clk_hw *hw)
 	clk->is_prepared = 0;
 }
 
-static struct clk_ops clk_prcmu_scalable_ops = {
+static const struct clk_ops clk_prcmu_scalable_ops = {
 	.prepare = clk_prcmu_prepare,
 	.unprepare = clk_prcmu_unprepare,
 	.is_prepared = clk_prcmu_is_prepared,
@@ -198,7 +198,7 @@ static void clk_prcmu_opp_volt_unprepare(struct clk_hw *hw)
 	.set_rate = clk_prcmu_set_rate,
 };
 
-static struct clk_ops clk_prcmu_gate_ops = {
+static const struct clk_ops clk_prcmu_gate_ops = {
 	.prepare = clk_prcmu_prepare,
 	.unprepare = clk_prcmu_unprepare,
 	.is_prepared = clk_prcmu_is_prepared,
@@ -208,19 +208,19 @@ static void clk_prcmu_opp_volt_unprepare(struct clk_hw *hw)
 	.recalc_rate = clk_prcmu_recalc_rate,
 };
 
-static struct clk_ops clk_prcmu_scalable_rate_ops = {
+static const struct clk_ops clk_prcmu_scalable_rate_ops = {
 	.is_enabled = clk_prcmu_is_enabled,
 	.recalc_rate = clk_prcmu_recalc_rate,
 	.round_rate = clk_prcmu_round_rate,
 	.set_rate = clk_prcmu_set_rate,
 };
 
-static struct clk_ops clk_prcmu_rate_ops = {
+static const struct clk_ops clk_prcmu_rate_ops = {
 	.is_enabled = clk_prcmu_is_enabled,
 	.recalc_rate = clk_prcmu_recalc_rate,
 };
 
-static struct clk_ops clk_prcmu_opp_gate_ops = {
+static const struct clk_ops clk_prcmu_opp_gate_ops = {
 	.prepare = clk_prcmu_opp_prepare,
 	.unprepare = clk_prcmu_opp_unprepare,
 	.is_prepared = clk_prcmu_is_prepared,
@@ -230,7 +230,7 @@ static void clk_prcmu_opp_volt_unprepare(struct clk_hw *hw)
 	.recalc_rate = clk_prcmu_recalc_rate,
 };
 
-static struct clk_ops clk_prcmu_opp_volt_scalable_ops = {
+static const struct clk_ops clk_prcmu_opp_volt_scalable_ops = {
 	.prepare = clk_prcmu_opp_volt_prepare,
 	.unprepare = clk_prcmu_opp_volt_unprepare,
 	.is_prepared = clk_prcmu_is_prepared,
@@ -247,7 +247,7 @@ static struct clk *clk_reg_prcmu(const char *name,
 				 u8 cg_sel,
 				 unsigned long rate,
 				 unsigned long flags,
-				 struct clk_ops *clk_prcmu_ops)
+				 const struct clk_ops *clk_prcmu_ops)
 {
 	struct clk_prcmu *clk;
 	struct clk_init_data clk_prcmu_init;
-- 
1.9.1
