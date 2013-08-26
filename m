From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Mon, 26 Aug 2013 14:43:01 +0530
Subject: [PATCH v3 3/5] clk/exynos5420: fix the order of parents of hdmi mux
In-Reply-To: <1377508383-15185-1-git-send-email-rahul.sharma@samsung.com>
References: <1377508383-15185-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1377508383-15185-4-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Listing sclk_hdmiphy at 0th position in the list of parents is
causing wrong configuration in reg SRC_DISP10.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 4e0c13e..522c033 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -286,7 +286,7 @@ PNAME(audio2_p)	= { "fin_pll", "cdclk2", "sclk_dpll", "sclk_mpll",
 		  "sclk_spll", "sclk_ipll", "sclk_epll", "sclk_rpll" };
 PNAME(spdif_p)	= { "fin_pll", "dout_audio0", "dout_audio1", "dout_audio2",
 		  "spdif_extclk", "sclk_ipll", "sclk_epll", "sclk_rpll" };
-PNAME(hdmi_p)	= { "sclk_hdmiphy", "dout_hdmi_pixel" };
+PNAME(hdmi_p)	= { "dout_hdmi_pixel", "sclk_hdmiphy" };
 PNAME(maudio0_p)	= { "fin_pll", "maudio_clk", "sclk_dpll", "sclk_mpll",
 			  "sclk_spll", "sclk_ipll", "sclk_epll", "sclk_rpll" };
 
-- 
1.7.10.4
