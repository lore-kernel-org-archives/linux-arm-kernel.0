From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 21 Nov 2013 09:47:34 +0530
Subject: [PATCH 1/1] clk: exynos5250: Add CLK_SET_RATE_PARENT flag to mout_apll
Message-ID: <1385007454-5234-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CLK_SET_RATE_PARENT flag to be able to change the frequency
to desired value.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/samsung/clk-exynos5250.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 80f652053cb5..11178b1ad735 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -303,7 +303,8 @@ static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
 	/*
 	 * CMU_CPU
 	 */
-	MUX_A(none, "mout_apll", mout_apll_p, SRC_CPU, 0, 1, "mout_apll"),
+	MUX_FA(none, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
+					CLK_SET_RATE_PARENT, 0, "mout_apll"),
 	MUX_A(none, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1, "mout_cpu"),
 
 	/*
-- 
1.7.9.5
