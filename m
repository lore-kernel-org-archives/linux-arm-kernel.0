From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 27 Mar 2013 12:02:52 +0100
Subject: [PATCH 15/21] clk: samsung: exynos4: Use SRC_MASK_PERIL{0,1}
 definitions
In-Reply-To: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
References: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
Message-ID: <1364382178-25248-16-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are definitions of SRC_MASK_PERIL0 and SRC_MASK_PERIL1 registers,
but they are not used for clock definitions. This patch modifies related
clock definitions to use defined macros instead of numeric offsets.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 8ce3b25..e7c6acd 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -549,7 +549,7 @@ struct samsung_gate_clock exynos4_gate_clks[] __initdata = {
 	 * of the clocks can be removed.
 	 */
 	GATE(sclk_hdmi, "sclk_hdmi", "mout_hdmi", SRC_MASK_TV, 0, 0, 0),
-	GATE(sclk_spdif, "sclk_spdif", "mout_spdif", 0xc354, 8, 0, 0),
+	GATE(sclk_spdif, "sclk_spdif", "mout_spdif", SRC_MASK_PERIL1, 8, 0, 0),
 	GATE(jpeg, "jpeg", "aclk160", GATE_IP_CAM, 6, 0, 0),
 	GATE(mie0, "mie0", "aclk160", GATE_IP_LCD0, 1, 0, 0),
 	GATE(dsim0, "dsim0", "aclk160", GATE_IP_LCD0, 3, 0, 0),
@@ -575,7 +575,7 @@ struct samsung_gate_clock exynos4_gate_clks[] __initdata = {
 			SRC_MASK_LCD0, 12, CLK_SET_RATE_PARENT, 0),
 	GATE(sclk_audio0, "sclk_audio0", "div_audio0", SRC_MASK_MAUDIO, 0,
 			CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_audio1, "sclk_audio1", "div_audio1", 0xc354, 0,
+	GATE(sclk_audio1, "sclk_audio1", "div_audio1", SRC_MASK_PERIL1, 0,
 			CLK_SET_RATE_PARENT, 0),
 	GATE_D(vp, "s5p-mixer", "vp", "aclk160", GATE_IP_TV, 0, 0, 0),
 	GATE_D(mixer, "s5p-mixer", "mixer", "aclk160", GATE_IP_TV, 1, 0, 0),
@@ -613,23 +613,31 @@ struct samsung_gate_clock exynos4_gate_clks[] __initdata = {
 	GATE_DA(sclk_mmc4, NULL, "sclk_mmc4", "div_mmc_pre4",
 			SRC_MASK_FSYS, 16, CLK_SET_RATE_PARENT, 0, "ciu"),
 	GATE_DA(sclk_uart0, "exynos4210-uart.0", "uclk0", "div_uart0",
-			0xc350, 0, CLK_SET_RATE_PARENT, 0, "clk_uart_baud0"),
+			SRC_MASK_PERIL0, 0, CLK_SET_RATE_PARENT,
+			0, "clk_uart_baud0"),
 	GATE_DA(sclk_uart1, "exynos4210-uart.1", "uclk1", "div_uart1",
-			0xc350, 4, CLK_SET_RATE_PARENT, 0, "clk_uart_baud0"),
+			SRC_MASK_PERIL0, 4, CLK_SET_RATE_PARENT,
+			0, "clk_uart_baud0"),
 	GATE_DA(sclk_uart2, "exynos4210-uart.2", "uclk2", "div_uart2",
-			0xc350, 8, CLK_SET_RATE_PARENT, 0, "clk_uart_baud0"),
+			SRC_MASK_PERIL0, 8, CLK_SET_RATE_PARENT,
+			0, "clk_uart_baud0"),
 	GATE_DA(sclk_uart3, "exynos4210-uart.3", "uclk3", "div_uart3",
-			0xc350, 12, CLK_SET_RATE_PARENT, 0, "clk_uart_baud0"),
+			SRC_MASK_PERIL0, 12, CLK_SET_RATE_PARENT,
+			0, "clk_uart_baud0"),
 	GATE_DA(sclk_uart4, "exynos4210-uart.4", "uclk4", "div_uart4",
-			0xc350, 16, CLK_SET_RATE_PARENT, 0, "clk_uart_baud0"),
-	GATE(sclk_audio2, "sclk_audio2", "div_audio2", 0xc354, 4,
+			SRC_MASK_PERIL0, 16, CLK_SET_RATE_PARENT,
+			0, "clk_uart_baud0"),
+	GATE(sclk_audio2, "sclk_audio2", "div_audio2", SRC_MASK_PERIL1, 4,
 			CLK_SET_RATE_PARENT, 0),
 	GATE_DA(sclk_spi0, "exynos4210-spi.0", "sclk_spi0", "div_spi_pre0",
-			0xc354, 16, CLK_SET_RATE_PARENT, 0, "spi_busclk0"),
+			SRC_MASK_PERIL1, 16, CLK_SET_RATE_PARENT,
+			0, "spi_busclk0"),
 	GATE_DA(sclk_spi1, "exynos4210-spi.1", "sclk_spi1", "div_spi_pre1",
-			0xc354, 20, CLK_SET_RATE_PARENT, 0, "spi_busclk0"),
+			SRC_MASK_PERIL1, 20, CLK_SET_RATE_PARENT,
+			0, "spi_busclk0"),
 	GATE_DA(sclk_spi2, "exynos4210-spi.2", "sclk_spi2", "div_spi_pre2",
-			0xc354, 24, CLK_SET_RATE_PARENT, 0, "spi_busclk0"),
+			SRC_MASK_PERIL1, 24, CLK_SET_RATE_PARENT,
+			0, "spi_busclk0"),
 	GATE_DA(fimc0, "exynos4-fimc.0", "fimc0", "aclk160",
 			GATE_IP_CAM, 0, 0, 0, "fimc"),
 	GATE_DA(fimc1, "exynos4-fimc.1", "fimc1", "aclk160",
-- 
1.8.1.5
