From: ccross@android.com (Colin Cross)
Date: Sun, 13 Feb 2011 01:40:14 -0800
Subject: [PATCH 02/21] ARM: tegra: clock: Don't BUG on changing an enabled PLL
In-Reply-To: <1297590033-15035-1-git-send-email-ccross@android.com>
References: <1297590033-15035-1-git-send-email-ccross@android.com>
Message-ID: <1297590033-15035-3-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-tegra/tegra2_clocks.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
index 240f921..db27e59 100644
--- a/arch/arm/mach-tegra/tegra2_clocks.c
+++ b/arch/arm/mach-tegra/tegra2_clocks.c
@@ -620,7 +620,6 @@ static int tegra2_pll_clk_set_rate(struct clk *c, unsigned long rate)
 	const struct clk_pll_table *sel;
 
 	pr_debug("%s: %s %lu\n", __func__, c->name, rate);
-	BUG_ON(c->refcnt != 0);
 
 	input_rate = c->parent->rate;
 	for (sel = c->pll_table; sel->input_rate != 0; sel++) {
-- 
1.7.3.1
