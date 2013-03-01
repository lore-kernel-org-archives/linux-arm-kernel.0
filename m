From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  1 Mar 2013 11:32:25 -0700
Subject: [PATCH 2/2] clk: Tegra: Remove duplicate smp_twd clock
In-Reply-To: <1362162745-21392-1-git-send-email-swarren@wwwdotorg.org>
References: <1362162745-21392-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1362162745-21392-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Prashant Gaikwad <pgaikwad@nvidia.com>

Remove duplicate smp_twd clocks as these clocks are accessed using
DT now.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/clk/tegra/clk-tegra20.c |    1 -
 drivers/clk/tegra/clk-tegra30.c |    1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 143ce1f..1e2de73 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -1292,7 +1292,6 @@ static struct tegra_clk_duplicate tegra_clk_duplicates[] = {
 	TEGRA_CLK_DUPLICATE(usbd,   "tegra-ehci.0", NULL),
 	TEGRA_CLK_DUPLICATE(usbd,   "tegra-otg",    NULL),
 	TEGRA_CLK_DUPLICATE(cclk,   NULL,           "cpu"),
-	TEGRA_CLK_DUPLICATE(twd,    "smp_twd",      NULL),
 	TEGRA_CLK_DUPLICATE(clk_max, NULL, NULL), /* Must be the last entry */
 };
 
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 32c61cb..ba6f51b 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1931,7 +1931,6 @@ static struct tegra_clk_duplicate tegra_clk_duplicates[] = {
 	TEGRA_CLK_DUPLICATE(cml1, "tegra_sata_cml", NULL),
 	TEGRA_CLK_DUPLICATE(cml0, "tegra_pcie", "cml"),
 	TEGRA_CLK_DUPLICATE(pciex, "tegra_pcie", "pciex"),
-	TEGRA_CLK_DUPLICATE(twd, "smp_twd", NULL),
 	TEGRA_CLK_DUPLICATE(vcp, "nvavp", "vcp"),
 	TEGRA_CLK_DUPLICATE(clk_max, NULL, NULL), /* MUST be the last entry */
 };
-- 
1.7.10.4
