From: dev@lynxeye.de (Lucas Stach)
Date: Sun,  4 Jan 2015 21:39:18 +0100
Subject: [PATCH 2/4] clk: tegra20: init NDFLASH clock to sensible rate
In-Reply-To: <1420403960-26626-1-git-send-email-dev@lynxeye.de>
References: <1420403960-26626-1-git-send-email-dev@lynxeye.de>
Message-ID: <1420403960-26626-2-git-send-email-dev@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set up the NAND Flash controller clock to run at 150MHz
instead of the rate set by the bootloader. This is a
conservative rate which also yields good performance.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
 drivers/clk/tegra/clk-tegra20.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 41272dc..f20424d 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -1063,6 +1063,7 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{TEGRA20_CLK_DISP2, TEGRA20_CLK_PLL_P, 600000000, 0},
 	{TEGRA20_CLK_GR2D, TEGRA20_CLK_PLL_C, 300000000, 0},
 	{TEGRA20_CLK_GR3D, TEGRA20_CLK_PLL_C, 300000000, 0},
+	{TEGRA20_CLK_NDFLASH, TEGRA20_CLK_PLL_P, 150000000, 0},
 	{TEGRA20_CLK_CLK_MAX, TEGRA20_CLK_CLK_MAX, 0, 0}, /* This MUST be the last entry */
 };
 
-- 
2.1.0
