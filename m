From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Mon, 28 Jul 2014 21:27:43 +0800
Subject: [PATCH -next] clk: sunxi: sun6i-apb0: fix sparse non static symbol
 warning
Message-ID: <1406554063-30350-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fixes the following sparse warnings:

drivers/clk/sunxi/clk-sun6i-apb0.c:60:27: warning:
 symbol 'sun6i_a31_apb0_clk_dt_ids' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/clk/sunxi/clk-sun6i-apb0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-sun6i-apb0.c b/drivers/clk/sunxi/clk-sun6i-apb0.c
index 11f17c3..1fa2337 100644
--- a/drivers/clk/sunxi/clk-sun6i-apb0.c
+++ b/drivers/clk/sunxi/clk-sun6i-apb0.c
@@ -57,7 +57,7 @@ static int sun6i_a31_apb0_clk_probe(struct platform_device *pdev)
 	return of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
 
-const struct of_device_id sun6i_a31_apb0_clk_dt_ids[] = {
+static const struct of_device_id sun6i_a31_apb0_clk_dt_ids[] = {
 	{ .compatible = "allwinner,sun6i-a31-apb0-clk" },
 	{ /* sentinel */ }
 };
