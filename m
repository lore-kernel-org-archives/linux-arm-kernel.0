From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 15 Jan 2014 11:13:25 +0530
Subject: [PATCH 1/2] clk: tegra: Staticize tegra_clk_periph_no_gate_ops
Message-ID: <1389764606-14102-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tegra_clk_periph_no_gate_ops is a local symbol.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/tegra/clk-periph.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-periph.c b/drivers/clk/tegra/clk-periph.c
index 356e9b804421..9e899c18af86 100644
--- a/drivers/clk/tegra/clk-periph.c
+++ b/drivers/clk/tegra/clk-periph.c
@@ -130,7 +130,7 @@ static const struct clk_ops tegra_clk_periph_nodiv_ops = {
 	.disable = clk_periph_disable,
 };
 
-const struct clk_ops tegra_clk_periph_no_gate_ops = {
+static const struct clk_ops tegra_clk_periph_no_gate_ops = {
 	.get_parent = clk_periph_get_parent,
 	.set_parent = clk_periph_set_parent,
 	.recalc_rate = clk_periph_recalc_rate,
-- 
1.7.9.5
