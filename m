From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed,  7 Aug 2013 10:18:40 +0530
Subject: [PATCH 4/4] clk: exynos5440: Fix incorrect placement of __initdata
In-Reply-To: <1375850921-23122-1-git-send-email-sachin.kamat@linaro.org>
References: <1375850921-23122-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1375850921-23122-4-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__initdata should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/samsung/clk-exynos5440.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5440.c b/drivers/clk/samsung/clk-exynos5440.c
index 6d043a2..4ef38e0 100644
--- a/drivers/clk/samsung/clk-exynos5440.c
+++ b/drivers/clk/samsung/clk-exynos5440.c
@@ -97,7 +97,7 @@ static struct samsung_gate_clock exynos5440_gate_clks[] __initdata = {
 	GATE(cs250_o, "cs250_o", "cs250", CLKEN_OV_VAL, 19, 0, 0),
 };
 
-static __initdata struct of_device_id ext_clk_match[] = {
+static struct of_device_id ext_clk_match[] __initdata = {
 	{ .compatible = "samsung,clock-xtal", .data = (void *)0, },
 	{},
 };
-- 
1.7.9.5
