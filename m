From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue,  8 Oct 2013 16:47:46 +0530
Subject: [PATCH 08/10] clk: vt8500: Staticize vtwm_pll_ops
In-Reply-To: <1381231068-6053-1-git-send-email-sachin.kamat@linaro.org>
References: <1381231068-6053-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1381231068-6053-8-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'vtwm_pll_ops' is local to this file. Make it static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/clk/clk-vt8500.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-vt8500.c b/drivers/clk/clk-vt8500.c
index 82306f5..a45e7a6 100644
--- a/drivers/clk/clk-vt8500.c
+++ b/drivers/clk/clk-vt8500.c
@@ -620,7 +620,7 @@ static unsigned long vtwm_pll_recalc_rate(struct clk_hw *hw,
 	return pll_freq;
 }
 
-const struct clk_ops vtwm_pll_ops = {
+static const struct clk_ops vtwm_pll_ops = {
 	.round_rate = vtwm_pll_round_rate,
 	.set_rate = vtwm_pll_set_rate,
 	.recalc_rate = vtwm_pll_recalc_rate,
-- 
1.7.9.5
