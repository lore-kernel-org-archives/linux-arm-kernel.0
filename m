From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 27 Mar 2013 12:02:51 +0100
Subject: [PATCH 14/21] clk: samsung: exynos4: Define {E,V}PLL registers
In-Reply-To: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
References: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
Message-ID: <1364382178-25248-15-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds preprocessor definitions of EPLL and VPLL registers and
replaces all occurences of offsets of related registers with new
definitions.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 959402f..8ce3b25 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -25,6 +25,14 @@
 #define E4X12_GATE_IP_IMAGE	0x4930
 #define GATE_IP_RIGHTBUS	0x8800
 #define E4X12_GATE_IP_PERIR	0x8960
+#define EPLL_LOCK		0xc010
+#define VPLL_LOCK		0xc020
+#define EPLL_CON0		0xc110
+#define EPLL_CON1		0xc114
+#define EPLL_CON2		0xc118
+#define VPLL_CON0		0xc120
+#define VPLL_CON1		0xc124
+#define VPLL_CON2		0xc128
 #define SRC_TOP0		0xc210
 #define SRC_TOP1		0xc214
 #define SRC_CAM			0xc220
@@ -968,18 +976,18 @@ void __init exynos4_clk_init(struct device_node *np)
 		mpll = samsung_clk_register_pll45xx("fout_mpll", "fin_pll",
 					reg_base + E4210_MPLL_CON0, pll_4508);
 		epll = samsung_clk_register_pll46xx("fout_epll", "fin_pll",
-					reg_base + 0xc110, pll_4600);
+					reg_base + EPLL_CON0, pll_4600);
 		vpll = samsung_clk_register_pll46xx("fout_vpll", "mout_vpllsrc",
-					reg_base + 0xc120, pll_4650c);
+					reg_base + VPLL_CON0, pll_4650c);
 	} else {
 		apll = samsung_clk_register_pll35xx("fout_apll", "fin_pll",
 					reg_base + APLL_CON0);
 		mpll = samsung_clk_register_pll35xx("fout_mpll", "fin_pll",
 					reg_base + E4X12_MPLL_CON0);
 		epll = samsung_clk_register_pll36xx("fout_epll", "fin_pll",
-					reg_base + 0xc110);
+					reg_base + EPLL_CON0);
 		vpll = samsung_clk_register_pll36xx("fout_vpll", "fin_pll",
-					reg_base + 0xc120);
+					reg_base + VPLL_CON0);
 	}
 
 	samsung_clk_add_lookup(apll, fout_apll);
-- 
1.8.1.5
