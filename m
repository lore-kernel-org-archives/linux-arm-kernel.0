From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 05 Feb 2018 15:22:28 +0100
Subject: [PATCH 1/3] clk: exynos5433: Extend list of available AUD_PLL
 output frequencies
References: <CGME20180205142252epcas1p4471e32e2b513806420c64b323af2ffa6@epcas1p4.samsung.com>
Message-ID: <20180205142230.9755-1-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add more definitions to the exynos5433_aud_pll_rates table so the
AUD_PLL can be used as a root clock source for the I2S1 and the HDMI
interface.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/clk/samsung/clk-exynos5433.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index db270908037a..74b70ddab4d6 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -765,6 +765,14 @@ static const struct samsung_pll_rate_table exynos5433_aud_pll_rates[] __initcons
 	PLL_36XX_RATE(294912000U,  98, 1, 3,  19923),
 	PLL_36XX_RATE(288000000U,  96, 1, 3,      0),
 	PLL_36XX_RATE(252000000U,  84, 1, 3,      0),
+	PLL_36XX_RATE(200000000U, 200, 3, 3,      0),
+	PLL_36XX_RATE(196608001U, 197, 3, 3, -25690),
+	PLL_36XX_RATE(180633609U, 301, 5, 3,   3671),
+	PLL_36XX_RATE(131072006U, 131, 3, 3,   4719),
+	PLL_36XX_RATE(100000000U, 200, 3, 4,      0),
+	PLL_36XX_RATE(65536003U,  131, 3, 4,   4719),
+	PLL_36XX_RATE(49152000U,  197, 3, 5, -25690),
+	PLL_36XX_RATE(32768001U,  131, 3, 5,   4719),
 	{ /* sentinel */ }
 };

--
2.14.2
