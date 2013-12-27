From: abrestic@chromium.org (Andrew Bresticker)
Date: Thu, 26 Dec 2013 16:44:26 -0800
Subject: [PATCH 6/7] clk: tegra: cclk_lp has a pllx/2 divider
In-Reply-To: <1388105067-24438-1-git-send-email-abrestic@chromium.org>
References: <1388105067-24438-1-git-send-email-abrestic@chromium.org>
Message-ID: <1388105067-24438-7-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When pll_x is the parent of cclk_lp, PLLX_DIV2_BYPASS_LP determines
whether cclk_lp output is divided by 2.  Set TEGRA_DIVIDER_2 so that
the clk_super driver is aware of this.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/clk/tegra/clk-tegra-super-gen4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-tegra-super-gen4.c b/drivers/clk/tegra/clk-tegra-super-gen4.c
index 05dce4a..feb3201 100644
--- a/drivers/clk/tegra/clk-tegra-super-gen4.c
+++ b/drivers/clk/tegra/clk-tegra-super-gen4.c
@@ -120,7 +120,7 @@ void __init tegra_super_clk_gen4_init(void __iomem *clk_base,
 					ARRAY_SIZE(cclk_lp_parents),
 					CLK_SET_RATE_PARENT,
 					clk_base + CCLKLP_BURST_POLICY,
-					0, 4, 8, 9, NULL);
+					TEGRA_DIVIDER_2, 4, 8, 9, NULL);
 		*dt_clk = clk;
 	}
 
-- 
1.8.5.1
