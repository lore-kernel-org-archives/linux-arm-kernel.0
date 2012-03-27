From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 27 Mar 2012 15:23:24 +0800
Subject: [PATCH 05/10] clk: align error return of basic clks registeration
In-Reply-To: <1332833009-4121-1-git-send-email-shawn.guo@linaro.org>
References: <1332833009-4121-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1332833009-4121-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_register_gate and clk_register_divider return NULL for error,
which is aligned with clk_register function.  But clk_register_mux
and clk_register_fixed_rate return ERR_PTR.  Change them to return
NULL for better aligning with other registeration functions.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/clk-fixed-rate.c |    2 +-
 drivers/clk/clk-mux.c        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index 027e477..d268439 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -50,7 +50,7 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 
 	if (!fixed) {
 		pr_err("%s: could not allocate fixed clk\n", __func__);
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 	}
 
 	/* struct clk_fixed_rate assignments */
diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 5424488..19f3116 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -99,7 +99,7 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
 
 	if (!mux) {
 		pr_err("%s: could not allocate mux clk\n", __func__);
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 	}
 
 	/* struct clk_mux assignments */
-- 
1.7.5.4
