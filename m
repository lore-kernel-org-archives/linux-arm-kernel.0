From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 05 Feb 2018 15:22:30 +0100
Subject: [PATCH 3/3] clk: exynos5433: Add CLK_IGNORE_UNUSED flag to
 sclk_ioclk_i2s1_bclk
In-Reply-To: <20180205142230.9755-1-s.nawrocki@samsung.com>
References: <20180205142230.9755-1-s.nawrocki@samsung.com>
 <CGME20180205142314epcas1p2c9b9bdcba33290a9528a1b24fbc849eb@epcas1p2.samsung.com>
Message-ID: <20180205142230.9755-3-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sclk_ioclk_i2s1_bclk clock is not currently handled by any driver
and disabling this clock by the clk core prevents proper operation
of the I2S1 block. CLK_IGNORE_UNUSED flag is added as a temporary fix.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/clk/samsung/clk-exynos5433.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index d74361736e64..15177f74e125 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -1680,7 +1680,7 @@ static const struct samsung_gate_clock peric_gate_clks[] __initconst = {
 			ENABLE_SCLK_PERIC, 11, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_IOCLK_I2S1_BCLK, "sclk_ioclk_i2s1_bclk",
 			"ioclk_i2s1_bclk_in", ENABLE_SCLK_PERIC, 10,
-			CLK_SET_RATE_PARENT, 0),
+			CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_SCLK_SPDIF, "sclk_spdif", "sclk_spdif_peric",
 			ENABLE_SCLK_PERIC, 8, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_PCM1, "sclk_pcm1", "sclk_pcm1_peric",
-- 
2.14.2
