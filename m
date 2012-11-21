From: sivaramn@nvidia.com (Sivaram Nair)
Date: Wed, 21 Nov 2012 13:42:27 +0200
Subject: [PATCH 1/1] arm: tegra: fix comment in dsib clk set_parent
Message-ID: <1353498147-14574-1-git-send-email-sivaramn@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the clk framework has already taken necessary locks before calling
into the arch clk ops code, no further locks are needed while setting
the parent of dsib clk. This patch removes a comment that indicated
otherwise, and yet did not take any locks.

Signed-off-by: Sivaram Nair <sivaramn@nvidia.com>
---
 arch/arm/mach-tegra/tegra30_clocks.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra30_clocks.c b/arch/arm/mach-tegra/tegra30_clocks.c
index efc000e..d714777 100644
--- a/arch/arm/mach-tegra/tegra30_clocks.c
+++ b/arch/arm/mach-tegra/tegra30_clocks.c
@@ -2045,9 +2045,7 @@ struct clk_ops tegra30_periph_clk_ops = {
 static int tegra30_dsib_clk_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct clk *d = clk_get_sys(NULL, "pll_d");
-	/* The DSIB parent selection bit is in PLLD base
-	   register - can not do direct r-m-w, must be
-	   protected by PLLD lock */
+	/* The DSIB parent selection bit is in PLLD base register */
 	tegra_clk_cfg_ex(
 		d, TEGRA_CLK_PLLD_MIPI_MUX_SEL, index);
 
-- 
1.7.9.5
