From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 19 Dec 2013 14:23:58 +0530
Subject: [PATCH Resend 4/7] clk: versatile: Staticize
 clk_sp810_timerclken_of_get
In-Reply-To: <1387443241-5694-1-git-send-email-sachin.kamat@linaro.org>
References: <1387443241-5694-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1387443241-5694-4-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_sp810_timerclken_of_get is used only in this file. Make it static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/versatile/clk-sp810.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/versatile/clk-sp810.c b/drivers/clk/versatile/clk-sp810.c
index bf9b15a585e1..c6e86a9a2aa3 100644
--- a/drivers/clk/versatile/clk-sp810.c
+++ b/drivers/clk/versatile/clk-sp810.c
@@ -123,7 +123,7 @@ static const struct clk_ops clk_sp810_timerclken_ops = {
 	.set_parent = clk_sp810_timerclken_set_parent,
 };
 
-struct clk *clk_sp810_timerclken_of_get(struct of_phandle_args *clkspec,
+static struct clk *clk_sp810_timerclken_of_get(struct of_phandle_args *clkspec,
 		void *data)
 {
 	struct clk_sp810 *sp810 = data;
-- 
1.7.9.5
