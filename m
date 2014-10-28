From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 28 Oct 2014 16:48:55 +0530
Subject: [PATCH v3 5/5] clk: samsung: exynos7: add gate clock for ADC block
In-Reply-To: <1414495135-25588-1-git-send-email-a.kesavan@samsung.com>
References: <1414495135-25588-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1414495135-25588-6-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock support for the ADC interface in Exynos7.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/clk/samsung/clk-exynos7.c       |    2 ++
 include/dt-bindings/clock/exynos7-clk.h |    3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
index 17e5cf4..ea4483b 100644
--- a/drivers/clk/samsung/clk-exynos7.c
+++ b/drivers/clk/samsung/clk-exynos7.c
@@ -486,6 +486,8 @@ static struct samsung_gate_clock peric0_gate_clks[] __initdata = {
 		ENABLE_PCLK_PERIC0, 14, 0, 0),
 	GATE(PCLK_UART0, "pclk_uart0", "mout_aclk_peric0_66_user",
 		ENABLE_PCLK_PERIC0, 16, 0, 0),
+	GATE(PCLK_ADCIF, "pclk_adcif", "mout_aclk_peric0_66_user",
+		ENABLE_PCLK_PERIC0, 20, 0, 0),
 	GATE(PCLK_PWM, "pclk_pwm", "mout_aclk_peric0_66_user",
 		ENABLE_PCLK_PERIC0, 21, 0, 0),
 
diff --git a/include/dt-bindings/clock/exynos7-clk.h b/include/dt-bindings/clock/exynos7-clk.h
index f255bb7..8e4681b0 100644
--- a/include/dt-bindings/clock/exynos7-clk.h
+++ b/include/dt-bindings/clock/exynos7-clk.h
@@ -55,7 +55,8 @@
 #define PCLK_HSI2C11			9
 #define PCLK_PWM			10
 #define SCLK_PWM			11
-#define PERIC0_NR_CLK			12
+#define PCLK_ADCIF			12
+#define PERIC0_NR_CLK			13
 
 /* PERIC1 */
 #define PCLK_UART1			1
-- 
1.7.9.5
