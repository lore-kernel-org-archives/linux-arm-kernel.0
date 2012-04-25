From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 25 Apr 2012 12:18:12 -0600
Subject: [PATCH] ARM: tegra: add pll_x freq table entry for 750MHz
Message-ID: <1335377892-26367-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Some SKUs limit the maximum CPU frequency to 750MHz; see
tegra2_pllx_clk_init(). The pll_x frequency table needs an entry for this
frequency, or there will be continual log spam from the cpufreq driver
attempting to set this rate, yet there being no table entry for it.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/tegra2_clocks.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
index 0bf0f2d..b59315c 100644
--- a/arch/arm/mach-tegra/tegra2_clocks.c
+++ b/arch/arm/mach-tegra/tegra2_clocks.c
@@ -1768,6 +1768,12 @@ static struct clk_pll_freq_table tegra_pll_x_freq_table[] = {
 	{ 19200000, 760000000,  950,  24, 1, 8},
 	{ 26000000, 760000000,  760,  26, 1, 12},
 
+	/* 750 MHz */
+	{ 12000000, 750000000,  750,  12, 1, 12},
+	{ 13000000, 750000000,  750,  13, 1, 12},
+	{ 19200000, 750000000,  625,  16, 1, 8},
+	{ 26000000, 750000000,  750,  26, 1, 12},
+
 	/* 608 MHz */
 	{ 12000000, 608000000,  608,  12, 1, 12},
 	{ 13000000, 608000000,  608,  13, 1, 12},
-- 
1.7.0.4
