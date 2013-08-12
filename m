From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 12 Aug 2013 14:44:00 +0530
Subject: [PATCH 2/9] clk: nomadik: Fix incorrect placement of __initconst
In-Reply-To: <1376298847-21828-1-git-send-email-sachin.kamat@linaro.org>
References: <1376298847-21828-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1376298847-21828-2-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__initconst should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clk/clk-nomadik.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
index 6d819a3..51410c2 100644
--- a/drivers/clk/clk-nomadik.c
+++ b/drivers/clk/clk-nomadik.c
@@ -479,12 +479,12 @@ static void __init of_nomadik_src_clk_setup(struct device_node *np)
 		of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
 
-static const __initconst struct of_device_id nomadik_src_match[] = {
+static const struct of_device_id nomadik_src_match[] __initconst = {
 	{ .compatible = "stericsson,nomadik-src" },
 	{ /* sentinel */ }
 };
 
-static const __initconst struct of_device_id nomadik_src_clk_match[] = {
+static const struct of_device_id nomadik_src_clk_match[] __initconst = {
 	{
 		.compatible = "fixed-clock",
 		.data = of_fixed_clk_setup,
-- 
1.7.9.5
