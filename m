From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed,  2 Oct 2013 23:12:41 +0200
Subject: [PATCH 2/2] clk: tegra114: Initialize gr2d clock
In-Reply-To: <1380748361-32459-1-git-send-email-treding@nvidia.com>
References: <1380748361-32459-1-git-send-email-treding@nvidia.com>
Message-ID: <1380748361-32459-2-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set up the gr2d clock as a child of PLLC and let it run at 300 MHz by
default.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/clk/tegra/clk-tegra114.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index ef8e892..698a92d 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -2226,6 +2226,7 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{host1x, pll_c, 150000000, 0},
 	{disp1, pll_p, 600000000, 0},
 	{disp2, pll_p, 600000000, 0},
+	{gr2d, pll_c, 300000000, 0},
 	{clk_max, clk_max, 0, 0}, /* This MUST be the last entry. */
 };
 
-- 
1.8.4
