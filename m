From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 12 Aug 2013 14:44:01 +0530
Subject: [PATCH 3/9] clk: u300: Fix incorrect placement of __initconst
In-Reply-To: <1376298847-21828-1-git-send-email-sachin.kamat@linaro.org>
References: <1376298847-21828-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1376298847-21828-3-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__initconst should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

While at it also make 'u300_clk_lookup' static as it is used only
in this file.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clk/clk-u300.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-u300.c b/drivers/clk/clk-u300.c
index 8774e05..3efbdd0 100644
--- a/drivers/clk/clk-u300.c
+++ b/drivers/clk/clk-u300.c
@@ -746,7 +746,7 @@ struct u300_clock {
 	u16 clk_val;
 };
 
-struct u300_clock const __initconst u300_clk_lookup[] = {
+static struct u300_clock const u300_clk_lookup[] __initconst = {
 	{
 		.type = U300_CLK_TYPE_REST,
 		.id = 3,
@@ -1151,7 +1151,7 @@ static void __init of_u300_syscon_mclk_init(struct device_node *np)
 		of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
 
-static const __initconst struct of_device_id u300_clk_match[] = {
+static const struct of_device_id u300_clk_match[] __initconst = {
 	{
 		.compatible = "fixed-clock",
 		.data = of_fixed_clk_setup,
-- 
1.7.9.5
