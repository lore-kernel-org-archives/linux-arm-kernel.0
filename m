From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Thu, 27 Mar 2014 16:37:49 +0530
Subject: [PATCH v2 6/7] clk: exynos5420: Add more registers to restore list
In-Reply-To: <1395918470-16374-1-git-send-email-shaik.ameer@samsung.com>
References: <1395918470-16374-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1395918470-16374-7-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <rahul.sharma@samsung.com>

Some of the clock registers should retain their state during
system suspend/resume operation. This patch adds more clock
registers to this list.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c |   27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 26ddf33..2067797 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -152,6 +152,13 @@ static unsigned long exynos5420_clk_regs[] __initdata = {
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
@@ -172,6 +179,7 @@ static unsigned long exynos5420_clk_regs[] __initdata = {
 	SRC_MASK_FSYS,
 	SRC_MASK_PERIC0,
 	SRC_MASK_PERIC1,
+	SRC_ISP,
 	DIV_TOP0,
 	DIV_TOP1,
 	DIV_TOP2,
@@ -185,27 +193,44 @@ static unsigned long exynos5420_clk_regs[] __initdata = {
 	DIV_PERIC2,
 	DIV_PERIC3,
 	DIV_PERIC4,
+	SCLK_DIV_ISP0,
+	SCLK_DIV_ISP1,
+	DIV2_RATIO0,
+	DIV4_RATIO,
 	GATE_BUS_TOP,
+	GATE_BUS_GSCL0,
+	GATE_BUS_GSCL1,
+	GATE_BUS_DISP1,
+	GATE_BUS_MFC,
+	GATE_BUS_GEN,
 	GATE_BUS_FSYS0,
+	GATE_BUS_FSYS2,
+	GATE_BUS_MSCL,
 	GATE_BUS_PERIC,
 	GATE_BUS_PERIC1,
 	GATE_BUS_PERIS0,
 	GATE_BUS_PERIS1,
+	GATE_BUS_NOC,
+	GATE_TOP_SCLK_ISP,
 	GATE_IP_GSCL0,
 	GATE_IP_GSCL1,
 	GATE_IP_MFC,
 	GATE_IP_DISP1,
 	GATE_IP_G3D,
 	GATE_IP_GEN,
+	GATE_IP_FSYS,
+	GATE_IP_PERIC,
+	GATE_IP_PERIS,
 	GATE_IP_MSCL,
 	GATE_TOP_SCLK_GSCL,
 	GATE_TOP_SCLK_DISP1,
 	GATE_TOP_SCLK_MAU,
 	GATE_TOP_SCLK_FSYS,
 	GATE_TOP_SCLK_PERIC,
-	SRC_CDREX,
+	TOP_SPARE2,
 	SRC_KFC,
 	DIV_KFC0,
+	SRC_MASK_TOP2,
 };
 
 static int exynos5420_clk_suspend(void)
-- 
1.7.9.5
