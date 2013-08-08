From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu,  8 Aug 2013 09:55:49 +0530
Subject: [PATCH 3/3] clk: tegra30: Fix incorrect placement of __initdata
In-Reply-To: <1375935949-19557-1-git-send-email-sachin.kamat@linaro.org>
References: <1375935949-19557-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1375935949-19557-3-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__initdata should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/tegra/clk-tegra30.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index e2c6ca0..ab35040 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1901,7 +1901,7 @@ static struct tegra_cpu_car_ops tegra30_cpu_car_ops = {
 #endif
 };
 
-static __initdata struct tegra_clk_init_table init_table[] = {
+static struct tegra_clk_init_table init_table[] __initdata = {
 	{uarta, pll_p, 408000000, 0},
 	{uartb, pll_p, 408000000, 0},
 	{uartc, pll_p, 408000000, 0},
-- 
1.7.9.5
