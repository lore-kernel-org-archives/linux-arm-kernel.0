From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Fri, 11 Jan 2013 13:31:28 +0530
Subject: [PATCH v2 09/10] clk: tegra20: remove unused TEGRA_CLK_DUPLICATE()s
In-Reply-To: <1357891289-23500-1-git-send-email-pgaikwad@nvidia.com>
References: <1357891289-23500-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <1357891289-23500-9-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With device tree support added for Tegra clocks look up is done from
device tree, remove unused TEGRA_CLK_DUPLICATE()s.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
 drivers/clk/tegra/clk-tegra20.c |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 4875261..9383b85 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -1174,28 +1174,11 @@ static __initdata struct tegra_clk_init_table init_table[] = {
  * table under two names.
  */
 static struct tegra_clk_duplicate tegra_clk_duplicates[] = {
-	TEGRA_CLK_DUPLICATE(uarta,  "serial8250.0", NULL),
-	TEGRA_CLK_DUPLICATE(uartb,  "serial8250.1", NULL),
-	TEGRA_CLK_DUPLICATE(uartc,  "serial8250.2", NULL),
-	TEGRA_CLK_DUPLICATE(uartd,  "serial8250.3", NULL),
-	TEGRA_CLK_DUPLICATE(uarte,  "serial8250.4", NULL),
 	TEGRA_CLK_DUPLICATE(usbd,   "utmip-pad",    NULL),
 	TEGRA_CLK_DUPLICATE(usbd,   "tegra-ehci.0", NULL),
 	TEGRA_CLK_DUPLICATE(usbd,   "tegra-otg",    NULL),
-	TEGRA_CLK_DUPLICATE(pll_p,   "tegradc.0",    "parent"),
-	TEGRA_CLK_DUPLICATE(pll_p,   "tegradc.1",    "parent"),
-	TEGRA_CLK_DUPLICATE(pll_d_out0,   "hdmi",    "parent"),
-	TEGRA_CLK_DUPLICATE(gr2d,   "tegra_grhost", "gr2d"),
-	TEGRA_CLK_DUPLICATE(gr3d,   "tegra_grhost", "gr3d"),
-	TEGRA_CLK_DUPLICATE(epp,    "tegra_grhost", "epp"),
-	TEGRA_CLK_DUPLICATE(mpe,    "tegra_grhost", "mpe"),
-	TEGRA_CLK_DUPLICATE(vde,    "tegra-aes",    "vde"),
 	TEGRA_CLK_DUPLICATE(cclk,   NULL,           "cpu"),
 	TEGRA_CLK_DUPLICATE(twd,    "smp_twd",      NULL),
-	TEGRA_CLK_DUPLICATE(pll_p_out3, "tegra-i2c.0", "fast-clk"),
-	TEGRA_CLK_DUPLICATE(pll_p_out3, "tegra-i2c.1", "fast-clk"),
-	TEGRA_CLK_DUPLICATE(pll_p_out3, "tegra-i2c.2", "fast-clk"),
-	TEGRA_CLK_DUPLICATE(pll_p_out3, "tegra-i2c.3", "fast-clk"),
 	TEGRA_CLK_DUPLICATE(clk_max, NULL, NULL), /* Must be the last entry */
 };
 
-- 
1.7.4.1
