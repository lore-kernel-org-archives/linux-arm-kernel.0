From: abrestic@chromium.org (Andrew Bresticker)
Date: Wed, 14 May 2014 17:33:00 -0700
Subject: [RFC PATCH 04/10] clk: tegra: Initialize xusb clocks
In-Reply-To: <1400113986-339-1-git-send-email-abrestic@chromium.org>
References: <1400113986-339-1-git-send-email-abrestic@chromium.org>
Message-ID: <1400113986-339-5-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialize the XUSB-related clocks with appropriate parents and rates
for both Tegra114 and Tegra124.

Signed-off-by: Jim Lin <jilin@nvidia.com>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/clk/tegra/clk-tegra114.c | 7 ++++++-
 drivers/clk/tegra/clk-tegra124.c | 6 ++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index 841f54f..b9c8ba2 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -1296,7 +1296,12 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{TEGRA114_CLK_GR3D, TEGRA114_CLK_PLL_C2, 300000000, 0},
 	{TEGRA114_CLK_DSIALP, TEGRA114_CLK_PLL_P, 68000000, 0},
 	{TEGRA114_CLK_DSIBLP, TEGRA114_CLK_PLL_P, 68000000, 0},
-
+	{TEGRA114_CLK_PLL_RE_VCO, TEGRA114_CLK_CLK_MAX, 612000000, 0},
+	{TEGRA114_CLK_XUSB_SS_SRC, TEGRA114_CLK_PLL_RE_OUT, 122400000, 0},
+	{TEGRA114_CLK_XUSB_FS_SRC, TEGRA114_CLK_PLL_U_48M, 48000000, 0},
+	{TEGRA114_CLK_XUSB_HS_SRC, TEGRA114_CLK_XUSB_SS_DIV2, 61200000, 0},
+	{TEGRA114_CLK_XUSB_FALCON_SRC, TEGRA114_CLK_PLL_P, 204000000, 0},
+	{TEGRA114_CLK_XUSB_HOST_SRC, TEGRA114_CLK_PLL_P, 102000000, 0},
 	/* This MUST be the last entry. */
 	{TEGRA114_CLK_CLK_MAX, TEGRA114_CLK_CLK_MAX, 0, 0},
 };
diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index 6cabc3d..80d64bf 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -1366,6 +1366,12 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{TEGRA124_CLK_SBC4, TEGRA124_CLK_PLL_P, 12000000, 1},
 	{TEGRA124_CLK_TSEC, TEGRA124_CLK_PLL_C3, 0, 0},
 	{TEGRA124_CLK_MSENC, TEGRA124_CLK_PLL_C3, 0, 0},
+	{TEGRA124_CLK_PLL_RE_VCO, TEGRA124_CLK_CLK_MAX, 672000000, 0},
+	{TEGRA124_CLK_XUSB_SS_SRC, TEGRA124_CLK_PLL_U_480M, 120000000, 0},
+	{TEGRA124_CLK_XUSB_FS_SRC, TEGRA124_CLK_PLL_U_48M, 48000000, 0},
+	{TEGRA124_CLK_XUSB_HS_SRC, TEGRA124_CLK_PLL_U_60M, 60000000, 0},
+	{TEGRA124_CLK_XUSB_FALCON_SRC, TEGRA124_CLK_PLL_RE_OUT, 224000000, 0},
+	{TEGRA124_CLK_XUSB_HOST_SRC, TEGRA124_CLK_PLL_RE_OUT, 112000000, 0},
 	/* This MUST be the last entry. */
 	{TEGRA124_CLK_CLK_MAX, TEGRA124_CLK_CLK_MAX, 0, 0},
 };
-- 
1.9.1.423.g4596e3a
