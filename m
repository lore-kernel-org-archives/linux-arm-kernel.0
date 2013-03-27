From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 27 Mar 2013 12:02:56 +0100
Subject: [PATCH 19/21] clk: samsung: exynos4: Remove E4X12 prefix from SRC_DMC
 register
In-Reply-To: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
References: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
Message-ID: <1364382178-25248-20-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This register is present on all Exynos4 SoCs and so the prefix is
misleading.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index a89cac9..571b7e3 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -93,7 +93,7 @@
 #define GATE_IP_PERIL		0xc950
 #define E4210_GATE_IP_PERIR	0xc960
 #define E4X12_MPLL_CON0		0x10108
-#define E4X12_SRC_DMC		0x10200
+#define SRC_DMC			0x10200
 #define APLL_CON0		0x14100
 #define E4210_MPLL_CON0		0x14108
 #define SRC_CPU			0x14200
@@ -388,7 +388,7 @@ struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
 	MUX(none, "mout_jpeg1", sclk_evpll_p, E4X12_SRC_CAM1, 4, 1),
 	MUX(none, "mout_jpeg", mout_jpeg_p, E4X12_SRC_CAM1, 8, 1),
 	MUX_A(sclk_mpll, "sclk_mpll", mout_mpll_p,
-			E4X12_SRC_DMC, 12, 1, "sclk_mpll"),
+			SRC_DMC, 12, 1, "sclk_mpll"),
 	MUX_A(sclk_vpll, "sclk_vpll", mout_vpll_p,
 			SRC_TOP0, 8, 1, "sclk_vpll"),
 	MUX(mout_core, "mout_core", mout_core_p4x12, SRC_CPU, 16, 1),
-- 
1.8.1.5
