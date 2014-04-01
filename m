From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue,  1 Apr 2014 14:13:16 -0600
Subject: [PATCH 2/3] clk: tegra: remove non-existent clocks
In-Reply-To: <1396383197-5979-1-git-send-email-swarren@wwwdotorg.org>
References: <1396383197-5979-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1396383197-5979-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The Tegra124 clock driver currently provides 3 clocks that don't actually
exist; 2 for NAND and one for UART5/UARTE. Delete these.

Cc: <stable@vger.kernel.org>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/clk/tegra/clk-tegra124.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index 166e02f16c8a..cc37c342c4cb 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -764,7 +764,6 @@ static struct tegra_clk tegra124_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_sdmmc2_8] = { .dt_id = TEGRA124_CLK_SDMMC2, .present = true },
 	[tegra_clk_i2s1] = { .dt_id = TEGRA124_CLK_I2S1, .present = true },
 	[tegra_clk_i2c1] = { .dt_id = TEGRA124_CLK_I2C1, .present = true },
-	[tegra_clk_ndflash] = { .dt_id = TEGRA124_CLK_NDFLASH, .present = true },
 	[tegra_clk_sdmmc1_8] = { .dt_id = TEGRA124_CLK_SDMMC1, .present = true },
 	[tegra_clk_sdmmc4_8] = { .dt_id = TEGRA124_CLK_SDMMC4, .present = true },
 	[tegra_clk_pwm] = { .dt_id = TEGRA124_CLK_PWM, .present = true },
@@ -809,7 +808,6 @@ static struct tegra_clk tegra124_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_trace] = { .dt_id = TEGRA124_CLK_TRACE, .present = true },
 	[tegra_clk_soc_therm] = { .dt_id = TEGRA124_CLK_SOC_THERM, .present = true },
 	[tegra_clk_dtv] = { .dt_id = TEGRA124_CLK_DTV, .present = true },
-	[tegra_clk_ndspeed] = { .dt_id = TEGRA124_CLK_NDSPEED, .present = true },
 	[tegra_clk_i2cslow] = { .dt_id = TEGRA124_CLK_I2CSLOW, .present = true },
 	[tegra_clk_dsib] = { .dt_id = TEGRA124_CLK_DSIB, .present = true },
 	[tegra_clk_tsec] = { .dt_id = TEGRA124_CLK_TSEC, .present = true },
@@ -952,7 +950,6 @@ static struct tegra_clk tegra124_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_clk_out_3_mux] = { .dt_id = TEGRA124_CLK_CLK_OUT_3_MUX, .present = true },
 	[tegra_clk_dsia_mux] = { .dt_id = TEGRA124_CLK_DSIA_MUX, .present = true },
 	[tegra_clk_dsib_mux] = { .dt_id = TEGRA124_CLK_DSIB_MUX, .present = true },
-	[tegra_clk_uarte] = { .dt_id = TEGRA124_CLK_UARTE, .present = true },
 };
 
 static struct tegra_devclk devclks[] __initdata = {
-- 
1.8.1.5
