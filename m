From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 15 Oct 2013 19:41:19 +0200
Subject: [PATCH 5/7] clk: samsung: exynos5250: Add missing unpopulated mux
 parents
In-Reply-To: <1381858881-25611-1-git-send-email-t.figa@samsung.com>
References: <1381858881-25611-1-git-send-email-t.figa@samsung.com>
Message-ID: <1381858881-25611-6-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mux parent arrays with unpopulated mux inputs, as all
inputs need to be specified in parent arrays passed to
clk_register_mux(), otherwise clk_set_parent() can generate out of bound
accesses to the array.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos5250.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index b3793fe..05e3a94 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -203,19 +203,27 @@ PNAME(mout_usb3_p)	= { "mout_mpll_user", "mout_cpll" };
 PNAME(mout_group1_p)	= { "fin_pll", "fin_pll", "sclk_hdmi27m",
 				"sclk_dptxphy", "sclk_uhostphy", "sclk_hdmiphy",
 				"mout_mpll_user", "mout_epll", "mout_vpll",
-				"mout_cpll" };
+				"mout_cpll", "none", "none",
+				"none", "none", "none",
+				"none" };
 PNAME(mout_audio0_p)	= { "cdclk0", "fin_pll", "sclk_hdmi27m", "sclk_dptxphy",
 				"sclk_uhostphy", "sclk_hdmiphy",
 				"mout_mpll_user", "mout_epll", "mout_vpll",
-				"mout_cpll" };
+				"mout_cpll", "none", "none",
+				"none", "none", "none",
+				"none" };
 PNAME(mout_audio1_p)	= { "cdclk1", "fin_pll", "sclk_hdmi27m", "sclk_dptxphy",
 				"sclk_uhostphy", "sclk_hdmiphy",
 				"mout_mpll_user", "mout_epll", "mout_vpll",
-				"mout_cpll" };
+				"mout_cpll", "none", "none",
+				"none", "none", "none",
+				"none" };
 PNAME(mout_audio2_p)	= { "cdclk2", "fin_pll", "sclk_hdmi27m", "sclk_dptxphy",
 				"sclk_uhostphy", "sclk_hdmiphy",
 				"mout_mpll_user", "mout_epll", "mout_vpll",
-				"mout_cpll" };
+				"mout_cpll", "none", "none",
+				"none", "none", "none",
+				"none" };
 PNAME(mout_spdif_p)	= { "sclk_audio0", "sclk_audio1", "sclk_audio2",
 				"spdif_extclk" };
 
-- 
1.8.3.2
