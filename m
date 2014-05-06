From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Tue, 06 May 2014 21:56:50 +0530
Subject: [PATCH v4 15/15] clk: exynos5420: add more registers to restore list
In-Reply-To: <1399393610-23394-1-git-send-email-shaik.ameer@samsung.com>
References: <1399393610-23394-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1399393610-23394-16-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds more register offsets to the list for
preserving their values during S2R.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index e69e820..566d351 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -27,6 +27,7 @@
 #define DIV_CPU1		0x504
 #define GATE_BUS_CPU		0x700
 #define GATE_SCLK_CPU		0x800
+#define CLKOUT_CMU_CPU		0xa00
 #define GATE_IP_G2D		0x8800
 #define CPLL_LOCK		0x10020
 #define DPLL_LOCK		0x10030
@@ -39,7 +40,11 @@
 #define CPLL_CON0		0x10120
 #define DPLL_CON0		0x10128
 #define EPLL_CON0		0x10130
+#define EPLL_CON1		0x10134
+#define EPLL_CON2		0x10138
 #define RPLL_CON0		0x10140
+#define RPLL_CON1		0x10144
+#define RPLL_CON2		0x10148
 #define IPLL_CON0		0x10150
 #define SPLL_CON0		0x10160
 #define VPLL_CON0		0x10170
@@ -140,6 +145,13 @@ static unsigned long exynos5420_clk_regs[] __initdata = {
 	DIV_CPU1,
 	GATE_BUS_CPU,
 	GATE_SCLK_CPU,
+	CLKOUT_CMU_CPU,
+	EPLL_CON0,
+	EPLL_CON1,
+	EPLL_CON2,
+	RPLL_CON0,
+	RPLL_CON1,
+	RPLL_CON2,
 	SRC_TOP0,
 	SRC_TOP1,
 	SRC_TOP2,
-- 
1.7.9.5
