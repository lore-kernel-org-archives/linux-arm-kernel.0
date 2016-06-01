From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 01 Jun 2016 11:45:50 +0200
Subject: [PATCH 2/3] clk: samsung: exynos5410: Add WDT, ACLK266 and SSS clocks
In-Reply-To: <1464774351-23604-1-git-send-email-k.kozlowski@samsung.com>
References: <1464774351-23604-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1464774351-23604-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock hierarchy for Security SubSystem clock and watchdog.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos5410.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5410.c b/drivers/clk/samsung/clk-exynos5410.c
index db9978dc6e83..7e3ffa70d364 100644
--- a/drivers/clk/samsung/clk-exynos5410.c
+++ b/drivers/clk/samsung/clk-exynos5410.c
@@ -31,6 +31,7 @@
 #define SRC_CPU			0x200
 #define DIV_CPU0		0x500
 #define SRC_CPERI1		0x4204
+#define GATE_IP_G2D		0x8800
 #define DIV_TOP0		0x10510
 #define DIV_TOP1		0x10514
 #define DIV_FSYS0		0x10548
@@ -154,11 +155,15 @@ static struct samsung_div_clock exynos5410_div_clks[] __initdata = {
 	DIV(0, "dout_pwm", "mout_pwm", DIV_PERIC3, 0, 4),
 
 	DIV(0, "aclk200", "mout_aclk200", DIV_TOP0, 12, 3),
+	DIV(0, "aclk266", "mpll_user_p", DIV_TOP0, 16, 3),
 	DIV(0, "aclk400", "mout_aclk400", DIV_TOP0, 24, 3),
 };
 
 static struct samsung_gate_clock exynos5410_gate_clks[] __initdata = {
+	GATE(CLK_SSS, "sss", "aclk266", GATE_IP_G2D, 2, 0, 0),
+
 	GATE(CLK_MCT, "mct", "aclk66", GATE_IP_PERIS, 18, 0, 0),
+	GATE(CLK_WDT, "wdt", "aclk66", GATE_IP_PERIS, 19, 0, 0),
 	GATE(CLK_RTC, "rtc", "aclk66", GATE_IP_PERIS, 20, 0, 0),
 	GATE(CLK_TMU, "tmu", "aclk66", GATE_IP_PERIS, 21, 0, 0),
 
-- 
1.9.1
