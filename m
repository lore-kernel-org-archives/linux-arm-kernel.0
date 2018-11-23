From: linux.amoon@gmail.com (Anand Moon)
Date: Fri, 23 Nov 2018 09:44:12 +0000
Subject: [PATCH 2/3] clk: samsung: exynos5420: Add CLK_SET_RATE_PARENT flag to
 mout_sclk_vpll
In-Reply-To: <20181123094413.1108-1-linux.amoon@gmail.com>
References: <20181123094413.1108-1-linux.amoon@gmail.com>
Message-ID: <20181123094413.1108-2-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows changing the VPLL output frequency through the g3d subsystem
clock tree leaf clocks.

Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 34156bdfd0d2..6bf1b2e89106 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -647,7 +647,8 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
 			mout_user_aclk300_gscl_p, SRC_TOP5, 28, 1),
 
 	MUX(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
-	MUX(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
+	MUX_F(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1,
+			CLK_SET_RATE_PARENT, 0),
 	MUX(0, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
 	MUX(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
 	MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
-- 
2.17.1
