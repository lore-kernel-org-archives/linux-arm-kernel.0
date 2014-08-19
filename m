From: tuomas.tynkkynen@iki.fi (Tuomas Tynkkynen)
Date: Tue, 19 Aug 2014 06:33:18 +0300
Subject: [PATCH v3 08/15] clk: tegra: Add the DFLL as a possible parent of the
 cclk_g clock
In-Reply-To: <1408419205-10048-1-git-send-email-tuomas.tynkkynen@iki.fi>
References: <1408419205-10048-1-git-send-email-tuomas.tynkkynen@iki.fi>
Message-ID: <1408419205-10048-9-git-send-email-tuomas.tynkkynen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>

The DFLL clocksource was missing from the list of possible parents for
the fast CPU cluster. Add it to the list.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
---
 drivers/clk/tegra/clk-tegra-super-gen4.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-tegra-super-gen4.c b/drivers/clk/tegra/clk-tegra-super-gen4.c
index feb3201..f1f4410 100644
--- a/drivers/clk/tegra/clk-tegra-super-gen4.c
+++ b/drivers/clk/tegra/clk-tegra-super-gen4.c
@@ -44,7 +44,9 @@ static const char *sclk_parents[] = { "clk_m", "pll_c_out1", "pll_p_out4",
 
 static const char *cclk_g_parents[] = { "clk_m", "pll_c", "clk_32k", "pll_m",
 					"pll_p", "pll_p_out4", "unused",
-					"unused", "pll_x" };
+					"unused", "pll_x", "unused", "unused",
+					"unused", "unused", "unused", "unused",
+					"dfllCPU_out" };
 
 static const char *cclk_lp_parents[] = { "clk_m", "pll_c", "clk_32k", "pll_m",
 					 "pll_p", "pll_p_out4", "unused",
-- 
1.8.1.5
