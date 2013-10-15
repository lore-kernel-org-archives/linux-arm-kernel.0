From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 15 Oct 2013 19:41:20 +0200
Subject: [PATCH 6/7] clk: samsung: exynos5250: Correct parent list of audio
 muxes
In-Reply-To: <1381858881-25611-1-git-send-email-t.figa@samsung.com>
References: <1381858881-25611-1-git-send-email-t.figa@samsung.com>
Message-ID: <1381858881-25611-7-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to SoC documentation, input 5 of mout_audio muxes is connected
to xxti (named fin_pll in the driver). This patch corrects defined
parent arrays to match SoC documentation.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos5250.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 05e3a94..1290da9 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -207,19 +207,19 @@ PNAME(mout_group1_p)	= { "fin_pll", "fin_pll", "sclk_hdmi27m",
 				"none", "none", "none",
 				"none" };
 PNAME(mout_audio0_p)	= { "cdclk0", "fin_pll", "sclk_hdmi27m", "sclk_dptxphy",
-				"sclk_uhostphy", "sclk_hdmiphy",
+				"sclk_uhostphy", "fin_pll",
 				"mout_mpll_user", "mout_epll", "mout_vpll",
 				"mout_cpll", "none", "none",
 				"none", "none", "none",
 				"none" };
 PNAME(mout_audio1_p)	= { "cdclk1", "fin_pll", "sclk_hdmi27m", "sclk_dptxphy",
-				"sclk_uhostphy", "sclk_hdmiphy",
+				"sclk_uhostphy", "fin_pll",
 				"mout_mpll_user", "mout_epll", "mout_vpll",
 				"mout_cpll", "none", "none",
 				"none", "none", "none",
 				"none" };
 PNAME(mout_audio2_p)	= { "cdclk2", "fin_pll", "sclk_hdmi27m", "sclk_dptxphy",
-				"sclk_uhostphy", "sclk_hdmiphy",
+				"sclk_uhostphy", "fin_pll",
 				"mout_mpll_user", "mout_epll", "mout_vpll",
 				"mout_cpll", "none", "none",
 				"none", "none", "none",
-- 
1.8.3.2
