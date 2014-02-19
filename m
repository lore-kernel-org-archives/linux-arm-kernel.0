From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Wed, 19 Feb 2014 16:18:41 +0200
Subject: [PATCH] clk: qcom: Add missing clock at index GCC_XO_CLK for MSM8974
Message-ID: <1392819521-25734-1-git-send-email-iivanov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Ivan T. Ivanov" <iivanov@mm-sol.com>

Accessing GCC on MSM8974 trough <&gcc GCC_XO_CLK> lead to NULL
pointer dereference. Fix this.

Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
---
 drivers/clk/qcom/gcc-msm8974.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/gcc-msm8974.c b/drivers/clk/qcom/gcc-msm8974.c
index 51d457e..98be7ea 100644
--- a/drivers/clk/qcom/gcc-msm8974.c
+++ b/drivers/clk/qcom/gcc-msm8974.c
@@ -2625,6 +2625,8 @@ static int gcc_msm8974_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
+	clks[GCC_XO_CLK] = clk;
+
 	/* Should move to DT node? */
 	clk = clk_register_fixed_rate(dev, "sleep_clk_src", NULL,
 				      CLK_IS_ROOT, 32768);
-- 
1.7.9.5
