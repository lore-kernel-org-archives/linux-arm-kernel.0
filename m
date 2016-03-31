From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 31 Mar 2016 11:47:59 +0900
Subject: [PATCH v4 3/9] clk: samsung: exynos3250: Add UART2 clock
In-Reply-To: <1459392485-11327-1-git-send-email-cw00.choi@samsung.com>
References: <1459392485-11327-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1459392485-11327-4-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pankaj Dubey <pankaj.dubey@samsung.com>

This patch add the UART2 clocks (mux, divider, gate) of Exynos3250 SoC.

Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clk/samsung/clk-exynos3250.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
index fdd41b17a24f..bc60e399d1bc 100644
--- a/drivers/clk/samsung/clk-exynos3250.c
+++ b/drivers/clk/samsung/clk-exynos3250.c
@@ -306,6 +306,7 @@ static struct samsung_mux_clock mux_clks[] __initdata = {
 	MUX(CLK_MOUT_MMC0, "mout_mmc0", group_sclk_p, SRC_FSYS, 0, 4),
 
 	/* SRC_PERIL0 */
+	MUX(CLK_MOUT_UART2, "mout_uart2", group_sclk_p, SRC_PERIL0, 8, 4),
 	MUX(CLK_MOUT_UART1, "mout_uart1", group_sclk_p, SRC_PERIL0, 4, 4),
 	MUX(CLK_MOUT_UART0, "mout_uart0", group_sclk_p, SRC_PERIL0, 0, 4),
 
@@ -390,6 +391,7 @@ static struct samsung_div_clock div_clks[] __initdata = {
 	DIV(CLK_DIV_MMC0, "div_mmc0", "mout_mmc0", DIV_FSYS1, 0, 4),
 
 	/* DIV_PERIL0 */
+	DIV(CLK_DIV_UART2, "div_uart2", "mout_uart2", DIV_PERIL0, 8, 4),
 	DIV(CLK_DIV_UART1, "div_uart1", "mout_uart1", DIV_PERIL0, 4, 4),
 	DIV(CLK_DIV_UART0, "div_uart0", "mout_uart0", DIV_PERIL0, 0, 4),
 
@@ -552,6 +554,9 @@ static struct samsung_gate_clock gate_clks[] __initdata = {
 		GATE_SCLK_PERIL, 7, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_SPI0, "sclk_spi0", "div_spi0_pre",
 		GATE_SCLK_PERIL, 6, CLK_SET_RATE_PARENT, 0),
+
+	GATE(CLK_SCLK_UART2, "sclk_uart2", "div_uart2",
+		GATE_SCLK_PERIL, 2, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_UART1, "sclk_uart1", "div_uart1",
 		GATE_SCLK_PERIL, 1, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_UART0, "sclk_uart0", "div_uart0",
@@ -649,6 +654,7 @@ static struct samsung_gate_clock gate_clks[] __initdata = {
 	GATE(CLK_I2C2, "i2c2", "div_aclk_100", GATE_IP_PERIL, 8, 0, 0),
 	GATE(CLK_I2C1, "i2c1", "div_aclk_100", GATE_IP_PERIL, 7, 0, 0),
 	GATE(CLK_I2C0, "i2c0", "div_aclk_100", GATE_IP_PERIL, 6, 0, 0),
+	GATE(CLK_UART2, "uart2", "div_aclk_100", GATE_IP_PERIL, 2, 0, 0),
 	GATE(CLK_UART1, "uart1", "div_aclk_100", GATE_IP_PERIL, 1, 0, 0),
 	GATE(CLK_UART0, "uart0", "div_aclk_100", GATE_IP_PERIL, 0, 0, 0),
 };
-- 
1.9.1
