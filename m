From: ilialin@codeaurora.org (Ilia Lin)
Date: Thu, 24 May 2018 10:50:12 +0300
Subject: [PATCH v12 2/8] clk: qcom: Make clk_alpha_pll_configure available to
 modules
In-Reply-To: <1527148218-16540-1-git-send-email-ilialin@codeaurora.org>
References: <1527148218-16540-1-git-send-email-ilialin@codeaurora.org>
Message-ID: <1527148218-16540-3-git-send-email-ilialin@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@codeaurora.org>

Allow clk_alpha_pll_configure to be called from loadable
kernel modules.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 9722b70..57f2084 100644
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
1.9.1
