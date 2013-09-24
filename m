From: m.krawczuk@partner.samsung.com (Mateusz Krawczuk)
Date: Tue, 24 Sep 2013 18:53:23 +0200
Subject: [PATCH 1/3] clk: samsung: pll: Add support for PLL6545a and PLL6522x
Message-ID: <1380041605-15736-1-git-send-email-m.krawczuk@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-pll.c | 2 ++
 drivers/clk/samsung/clk-pll.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 529e11d..dea8715 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -773,6 +773,8 @@ static void __init _samsung_clk_register_pll(struct samsung_pll_clock *pll_clk,
 			init.ops = &samsung_pll36xx_clk_ops;
 		break;
 	case pll_6552:
+	case pll_6545a:
+	case pll_6522x:
 		init.ops = &samsung_pll6552_clk_ops;
 		break;
 	case pll_6553:
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index 6c39030..e786875 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -25,6 +25,8 @@ enum samsung_pll_type {
 	pll_4650c,
 	pll_6552,
 	pll_6553,
+	pll_6545a,
+	pll_6522x,
 };
 
 #define PLL_35XX_RATE(_rate, _m, _p, _s)			\
-- 
1.8.1.2
