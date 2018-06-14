From: ilia.lin@gmail.com (ilia.lin at gmail.com)
Date: Thu, 14 Jun 2018 23:53:49 +0200
Subject: [PATCH v13 2/8] clk: qcom: Make clk_alpha_pll_configure available to
 modules
In-Reply-To: <20180614215358.11264-1-ilia.lin@gmail.com>
References: <20180614215358.11264-1-ilia.lin@gmail.com>
Message-ID: <20180614215358.11264-3-ilia.lin@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@codeaurora.org>

Allow clk_alpha_pll_configure to be called from loadable
kernel modules.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 3c49a60072f1..a43f80ac94a4 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -228,6 +228,7 @@ void clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 	if (pll->flags & SUPPORTS_FSM_MODE)
 		qcom_pll_set_fsm_mode(regmap, PLL_MODE(pll), 6, 0);
 }
+EXPORT_SYMBOL_GPL(clk_alpha_pll_configure);
 
 static int clk_alpha_pll_hwfsm_enable(struct clk_hw *hw)
 {
-- 
2.11.0
