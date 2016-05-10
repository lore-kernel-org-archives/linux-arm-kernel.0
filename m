From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 10 May 2016 22:09:27 +0200
Subject: [PATCH v3 24/27] clk: samsung: exynos5410: Add I2C,
 HSI2C and RTC clocks
In-Reply-To: <1462910970-1812-1-git-send-email-krzk@kernel.org>
References: <1462910970-1812-1-git-send-email-krzk@kernel.org>
Message-ID: <1462910970-1812-25-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clocks for I2C, USI (HSI2C) and RTC to the Exynos5410 clock driver.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/samsung/clk-exynos5410.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5410.c b/drivers/clk/samsung/clk-exynos5410.c
index 40775f678f02..8dd0d8f6703e 100644
--- a/drivers/clk/samsung/clk-exynos5410.c
+++ b/drivers/clk/samsung/clk-exynos5410.c
@@ -165,6 +165,7 @@ static struct samsung_div_clock exynos5410_div_clks[] __initdata = {
 
 static struct samsung_gate_clock exynos5410_gate_clks[] __initdata = {
 	GATE(CLK_MCT, "mct", "aclk66", GATE_IP_PERIS, 18, 0, 0),
+	GATE(CLK_RTC, "rtc", "aclk66", GATE_IP_PERIS, 20, 0, 0),
 
 	GATE(CLK_SCLK_MMC0, "sclk_mmc0", "div_mmc_pre0",
 			SRC_MASK_FSYS, 0, CLK_SET_RATE_PARENT, 0),
@@ -193,6 +194,14 @@ static struct samsung_gate_clock exynos5410_gate_clks[] __initdata = {
 	GATE(CLK_UART1, "uart1", "aclk66", GATE_IP_PERIC, 1, 0, 0),
 	GATE(CLK_UART2, "uart2", "aclk66", GATE_IP_PERIC, 2, 0, 0),
 	GATE(CLK_UART3, "uart3", "aclk66", GATE_IP_PERIC, 3, 0, 0),
+	GATE(CLK_I2C0, "i2c0", "aclk66", GATE_IP_PERIC, 6, 0, 0),
+	GATE(CLK_I2C1, "i2c1", "aclk66", GATE_IP_PERIC, 7, 0, 0),
+	GATE(CLK_I2C2, "i2c2", "aclk66", GATE_IP_PERIC, 8, 0, 0),
+	GATE(CLK_I2C3, "i2c3", "aclk66", GATE_IP_PERIC, 9, 0, 0),
+	GATE(CLK_USI0, "usi0", "aclk66", GATE_IP_PERIC, 10, 0, 0),
+	GATE(CLK_USI1, "usi1", "aclk66", GATE_IP_PERIC, 11, 0, 0),
+	GATE(CLK_USI2, "usi2", "aclk66", GATE_IP_PERIC, 12, 0, 0),
+	GATE(CLK_USI3, "usi3", "aclk66", GATE_IP_PERIC, 13, 0, 0),
 	GATE(CLK_PWM, "pwm", "aclk66", GATE_IP_PERIC, 24, 0, 0),
 
 	GATE(CLK_SCLK_UART0, "sclk_uart0", "div_uart0",
-- 
2.5.0
