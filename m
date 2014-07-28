From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Mon, 28 Jul 2014 21:27:14 +0800
Subject: [PATCH -next] clk: sunxi: sun6i-apb0-gates: fix sparse non static
 symbol warning
Message-ID: <1406554034-30266-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fixes the following sparse warnings:

drivers/clk/sunxi/clk-sun6i-apb0-gates.c:82:27: warning:
 symbol 'sun6i_a31_apb0_gates_clk_dt_ids' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
index ef5e419..e10d052 100644
--- a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
+++ b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
@@ -29,7 +29,7 @@ static const struct gates_data sun8i_a23_apb0_gates __initconst = {
 	.mask = {0x5D},
 };
 
-const struct of_device_id sun6i_a31_apb0_gates_clk_dt_ids[] = {
+static const struct of_device_id sun6i_a31_apb0_gates_clk_dt_ids[] = {
 	{ .compatible = "allwinner,sun6i-a31-apb0-gates-clk", .data = &sun6i_a31_apb0_gates },
 	{ .compatible = "allwinner,sun8i-a23-apb0-gates-clk", .data = &sun8i_a23_apb0_gates },
 	{ /* sentinel */ }
