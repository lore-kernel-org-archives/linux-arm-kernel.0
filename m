From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue,  8 Oct 2013 16:47:40 +0530
Subject: [PATCH 02/10] clk: SPEAr: Staticize clk_frac_ops
In-Reply-To: <1381231068-6053-1-git-send-email-sachin.kamat@linaro.org>
References: <1381231068-6053-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1381231068-6053-2-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_frac_ops is local to this file. Make it static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clk/spear/clk-frac-synth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/spear/clk-frac-synth.c b/drivers/clk/spear/clk-frac-synth.c
index 958aa3a..dffd4ce 100644
--- a/drivers/clk/spear/clk-frac-synth.c
+++ b/drivers/clk/spear/clk-frac-synth.c
@@ -116,7 +116,7 @@ static int clk_frac_set_rate(struct clk_hw *hw, unsigned long drate,
 	return 0;
 }
 
-struct clk_ops clk_frac_ops = {
+static struct clk_ops clk_frac_ops = {
 	.recalc_rate = clk_frac_recalc_rate,
 	.round_rate = clk_frac_round_rate,
 	.set_rate = clk_frac_set_rate,
-- 
1.7.9.5
