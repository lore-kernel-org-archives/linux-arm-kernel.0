From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 26 Jun 2014 17:34:12 +0300
Subject: [PATCH] clk: tegra124: init table updates
Message-ID: <1403793253-16534-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure some clocks critical for system operation are always. Also enable csite
for JTAG debugging and set the tsensor clock frequency for the upcoming
soctherm driver.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk-tegra124.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index 80efe51..0f5275a 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -1369,6 +1369,11 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{TEGRA124_CLK_XUSB_HS_SRC, TEGRA124_CLK_PLL_U_60M, 60000000, 0},
 	{TEGRA124_CLK_XUSB_FALCON_SRC, TEGRA124_CLK_PLL_RE_OUT, 224000000, 0},
 	{TEGRA124_CLK_XUSB_HOST_SRC, TEGRA124_CLK_PLL_RE_OUT, 112000000, 0},
+	{TEGRA124_CLK_EMC, TEGRA124_CLK_CLK_MAX, 0, 1},
+	{TEGRA124_CLK_CCLK_G, TEGRA124_CLK_CLK_MAX, 0, 1},
+	{TEGRA124_CLK_MSELECT, TEGRA124_CLK_CLK_MAX, 0, 1},
+	{TEGRA124_CLK_CSITE, TEGRA124_CLK_CLK_MAX, 0, 1},
+	{TEGRA124_CLK_TSENSOR, TEGRA124_CLK_CLK_M, 40000, 0},
 	/* This MUST be the last entry. */
 	{TEGRA124_CLK_CLK_MAX, TEGRA124_CLK_CLK_MAX, 0, 0},
 };
-- 
1.7.7.rc0.72.g4b5ea.dirty
