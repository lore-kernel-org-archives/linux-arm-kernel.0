From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 07 Mar 2018 17:46:55 +0100
Subject: [PATCH] clk: samsung: exynos5420: Add CLK_SET_RATE_PARENT flag to
 mout_mau_epll_clk
References: <CGME20180307164708epcas1p27e6599e85617f559c5c4c8eb92a70a47@epcas1p2.samsung.com>
Message-ID: <20180307164656.12194-1-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows changing the EPLL output frequency through the audio subsystem
clock tree leaf clocks. This change is needed to support audio on the HDMI
interface on Peach-Pi(t) Chromebook.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 8c050ff63536..1f204ba37f0f 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -621,7 +621,8 @@ static const struct samsung_mux_clock exynos5420_mux_clks[] __initconst = {
 
 	MUX(CLK_MOUT_MX_MSPLL_CCORE, "mout_mx_mspll_ccore",
 			mout_group5_5800_p, SRC_TOP7, 16, 2),
-	MUX(0, "mout_mau_epll_clk", mout_mau_epll_clk_p, SRC_TOP7, 20, 2),
+	MUX_F(0, "mout_mau_epll_clk", mout_mau_epll_clk_p, SRC_TOP7, 20, 2,
+	      CLK_SET_RATE_PARENT, 0),
 
 	MUX(0, "mout_fimd1", mout_group3_p, SRC_DISP10, 4, 1),
 };
-- 
2.14.2
