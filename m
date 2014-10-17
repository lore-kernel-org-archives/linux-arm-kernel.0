From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Fri, 17 Oct 2014 21:41:49 +0530
Subject: [PATCH 1/7] clk: samsung: exynos7: add clocks for I2C block
In-Reply-To: <1413562315-12283-1-git-send-email-a.kesavan@samsung.com>
References: <1413562315-12283-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1413562315-12283-2-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>

Exynos7 supports 12 I2C channels, add the I2C gate clocks to
support them.

Signed-off-by: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/clk/samsung/clk-exynos7.c       |   24 ++++++++++++++++++++++++
 include/dt-bindings/clock/exynos7-clk.h |   16 ++++++++++++++--
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
index 54206d4..c700f65 100644
--- a/drivers/clk/samsung/clk-exynos7.c
+++ b/drivers/clk/samsung/clk-exynos7.c
@@ -290,6 +290,20 @@ static struct samsung_mux_clock peric0_mux_clks[] __initdata = {
 };
 
 static struct samsung_gate_clock peric0_gate_clks[] __initdata = {
+	GATE(PCLK_HSI2C0, "pclk_hsi2c0", "mout_aclk_peric0_66_user",
+		ENABLE_PCLK_PERIC0, 8, 0, 0),
+	GATE(PCLK_HSI2C1, "pclk_hsi2c1", "mout_aclk_peric0_66_user",
+		ENABLE_PCLK_PERIC0, 9, 0, 0),
+	GATE(PCLK_HSI2C4, "pclk_hsi2c4", "mout_aclk_peric0_66_user",
+		ENABLE_PCLK_PERIC0, 10, 0, 0),
+	GATE(PCLK_HSI2C5, "pclk_hsi2c5", "mout_aclk_peric0_66_user",
+		ENABLE_PCLK_PERIC0, 11, 0, 0),
+	GATE(PCLK_HSI2C9, "pclk_hsi2c9", "mout_aclk_peric0_66_user",
+		ENABLE_PCLK_PERIC0, 12, 0, 0),
+	GATE(PCLK_HSI2C10, "pclk_hsi2c10", "mout_aclk_peric0_66_user",
+		ENABLE_PCLK_PERIC0, 13, 0, 0),
+	GATE(PCLK_HSI2C11, "pclk_hsi2c11", "mout_aclk_peric0_66_user",
+		ENABLE_PCLK_PERIC0, 14, 0, 0),
 	GATE(PCLK_UART0, "pclk_uart0", "mout_aclk_peric0_66_user",
 		ENABLE_PCLK_PERIC0, 16, 0, 0),
 
@@ -347,6 +361,16 @@ static struct samsung_mux_clock peric1_mux_clks[] __initdata = {
 };
 
 static struct samsung_gate_clock peric1_gate_clks[] __initdata = {
+	GATE(PCLK_HSI2C2, "pclk_hsi2c2", "mout_aclk_peric1_66_user",
+		ENABLE_PCLK_PERIC1, 4, 0, 0),
+	GATE(PCLK_HSI2C3, "pclk_hsi2c3", "mout_aclk_peric1_66_user",
+		ENABLE_PCLK_PERIC1, 5, 0, 0),
+	GATE(PCLK_HSI2C6, "pclk_hsi2c6", "mout_aclk_peric1_66_user",
+		ENABLE_PCLK_PERIC1, 6, 0, 0),
+	GATE(PCLK_HSI2C7, "pclk_hsi2c7", "mout_aclk_peric1_66_user",
+		ENABLE_PCLK_PERIC1, 7, 0, 0),
+	GATE(PCLK_HSI2C8, "pclk_hsi2c8", "mout_aclk_peric1_66_user",
+		ENABLE_PCLK_PERIC1, 8, 0, 0),
 	GATE(PCLK_UART1, "pclk_uart1", "mout_aclk_peric1_66_user",
 		ENABLE_PCLK_PERIC1, 9, 0, 0),
 	GATE(PCLK_UART2, "pclk_uart2", "mout_aclk_peric1_66_user",
diff --git a/include/dt-bindings/clock/exynos7-clk.h b/include/dt-bindings/clock/exynos7-clk.h
index 00fd6de..6d07b6f 100644
--- a/include/dt-bindings/clock/exynos7-clk.h
+++ b/include/dt-bindings/clock/exynos7-clk.h
@@ -30,7 +30,14 @@
 /* PERIC0 */
 #define PCLK_UART0			1
 #define SCLK_UART0			2
-#define PERIC0_NR_CLK			3
+#define PCLK_HSI2C0			3
+#define PCLK_HSI2C1			4
+#define PCLK_HSI2C4			5
+#define PCLK_HSI2C5			6
+#define PCLK_HSI2C9			7
+#define PCLK_HSI2C10			8
+#define PCLK_HSI2C11			9
+#define PERIC0_NR_CLK			10
 
 /* PERIC1 */
 #define PCLK_UART1			1
@@ -39,7 +46,12 @@
 #define SCLK_UART1			4
 #define SCLK_UART2			5
 #define SCLK_UART3			6
-#define PERIC1_NR_CLK			7
+#define PCLK_HSI2C2			7
+#define PCLK_HSI2C3			8
+#define PCLK_HSI2C6			9
+#define PCLK_HSI2C7			10
+#define PCLK_HSI2C8			11
+#define PERIC1_NR_CLK			12
 
 /* PERIS */
 #define PCLK_CHIPID			1
-- 
1.7.9.5
