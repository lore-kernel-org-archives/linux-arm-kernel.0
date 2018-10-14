From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sun, 14 Oct 2018 08:08:13 +0000
Subject: [PATCH V4 10/11] clk: imx: add imx_check_clk_hws helper function
In-Reply-To: <1539504194-28289-1-git-send-email-aisheng.dong@nxp.com>
References: <1539504194-28289-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1539504194-28289-11-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add imx_check_clk_hws helper function

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/imx/clk-common.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/imx/clk-common.h b/drivers/clk/imx/clk-common.h
index e3634a5..01550fd 100644
--- a/drivers/clk/imx/clk-common.h
+++ b/drivers/clk/imx/clk-common.h
@@ -13,4 +13,15 @@ static inline struct clk_hw *imx_clk_hw_fixed(const char *name, int rate)
 	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
 }
 
+static inline void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++) {
+		if (IS_ERR(clks[i]))
+			pr_err("i.MX clk %u: register failed with %ld\n",
+				i, PTR_ERR(clks[i]));
+	}
+}
+
 #endif /* __IMX_CLK_COMMON_H */
-- 
2.7.4
