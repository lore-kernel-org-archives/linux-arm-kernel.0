From: markz@nvidia.com (Mark Zhang)
Date: Wed, 7 Aug 2013 19:25:09 +0800
Subject: [PATCH 5/5] clk: tegra: Set the clk parent of host1x to pll_p
In-Reply-To: <1375874709-10438-1-git-send-email-markz@nvidia.com>
References: <1375874709-10438-1-git-send-email-markz@nvidia.com>
Message-ID: <1375874709-10438-5-git-send-email-markz@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Chew <achew@nvidia.com>

The power-on default parent for this clock is pll_m, which turns out to
be wrong. Previously, bootloader reparented this clock.  We'll do it in
the kernel as well, so that there's one less thing that we depend on
bootloader to initialize.

Signed-off-by: Andrew Chew <achew@nvidia.com>
Signed-off-by: Mark Zhang <markz@nvidia.com>
---
 drivers/clk/tegra/clk-tegra114.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index 72976a2..100105b 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -2197,6 +2197,7 @@ static __initdata struct tegra_clk_init_table init_table[] = {
 	{i2s2, pll_a_out0, 11289600, 0},
 	{i2s3, pll_a_out0, 11289600, 0},
 	{i2s4, pll_a_out0, 11289600, 0},
+	{host1x, pll_p, 136000000, 0},
 	{dfll_soc, pll_p, 51000000, 1},
 	{dfll_ref, pll_p, 51000000, 1},
 	{gr_2d, pll_c2, 300000000, 0},
-- 
1.7.9.5
