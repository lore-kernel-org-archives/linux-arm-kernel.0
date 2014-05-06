From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Tue, 06 May 2014 21:56:47 +0530
Subject: [PATCH v4 12/15] clk: exynos5420: fix register offset for sclk_bpll
In-Reply-To: <1399393610-23394-1-git-send-email-shaik.ameer@samsung.com>
References: <1399393610-23394-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1399393610-23394-13-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the wrong register offset for sclk_bpll clock.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 1449aee..ba7273a 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -111,7 +111,6 @@
 #define TOP_SPARE2		0x10b08
 #define BPLL_LOCK		0x20010
 #define BPLL_CON0		0x20110
-#define SRC_CDREX		0x20200
 #define KPLL_LOCK		0x28000
 #define KPLL_CON0		0x28100
 #define SRC_KFC			0x28200
@@ -204,7 +203,6 @@ static unsigned long exynos5420_clk_regs[] __initdata = {
 	GATE_TOP_SCLK_FSYS,
 	GATE_TOP_SCLK_PERIC,
 	TOP_SPARE2,
-	SRC_CDREX,
 	SRC_KFC,
 	DIV_KFC0,
 };
@@ -380,7 +378,7 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 	MUX(0, "mout_kpll", mout_kpll_p, SRC_KFC, 0, 1),
 	MUX(0, "mout_kfc", mout_kfc_p, SRC_KFC, 16, 1),
 
-	MUX(0, "sclk_bpll", mout_bpll_p, SRC_CDREX, 0, 1),
+	MUX(0, "sclk_bpll", mout_bpll_p, TOP_SPARE2, 0, 1),
 
 	MUX(0, "mout_aclk400_isp", mout_group1_p, SRC_TOP0, 0, 2),
 	MUX_A(0, "mout_aclk400_mscl", mout_group1_p,
-- 
1.7.9.5
