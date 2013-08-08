From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu,  8 Aug 2013 09:55:47 +0530
Subject: [PATCH 1/3] clk: tegra114: Fix incorrect placement of __initdata
Message-ID: <1375935949-19557-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__initdata should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/tegra/clk-tegra114.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index f74ed19..66fa1d6 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -2182,7 +2182,7 @@ static const struct of_device_id pmc_match[] __initconst = {
  * dfll_soc/dfll_ref apparently must be kept enabled, otherwise I2C5
  * breaks
  */
-static __initdata struct tegra_clk_init_table init_table[] = {
+static struct tegra_clk_init_table init_table[] __initdata = {
 	{uarta, pll_p, 408000000, 0},
 	{uartb, pll_p, 408000000, 0},
 	{uartc, pll_p, 408000000, 0},
-- 
1.7.9.5
