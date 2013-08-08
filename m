From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu,  8 Aug 2013 09:55:48 +0530
Subject: [PATCH 2/3] clk: tegra20: Fix incorrect placement of __initdata
In-Reply-To: <1375935949-19557-1-git-send-email-sachin.kamat@linaro.org>
References: <1375935949-19557-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1375935949-19557-2-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__initdata should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/tegra/clk-tegra20.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 759ca47..ebe94ce 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -1223,7 +1223,7 @@ static struct tegra_cpu_car_ops tegra20_cpu_car_ops = {
 #endif
 };
 
-static __initdata struct tegra_clk_init_table init_table[] = {
+static struct tegra_clk_init_table init_table[] __initdata = {
 	{pll_p, clk_max, 216000000, 1},
 	{pll_p_out1, clk_max, 28800000, 1},
 	{pll_p_out2, clk_max, 48000000, 1},
-- 
1.7.9.5
