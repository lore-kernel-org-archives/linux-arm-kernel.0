From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu,  5 Oct 2017 11:32:59 +0900
Subject: [PATCH] clk: uniphier: fix DAPLL2 clock rate of Pro5
Message-ID: <1507170779-26688-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The parent of DAPLL2 should be DAPLL1.  Fix the clock connection.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/clk/uniphier/clk-uniphier-sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index 0e396f3..bffe095 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -123,7 +123,7 @@ const struct uniphier_clk_data uniphier_sld8_sys_clk_data[] = {
 const struct uniphier_clk_data uniphier_pro5_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("spll", -1, "ref", 120, 1),		/* 2400 MHz */
 	UNIPHIER_CLK_FACTOR("dapll1", -1, "ref", 128, 1),	/* 2560 MHz */
-	UNIPHIER_CLK_FACTOR("dapll2", -1, "ref", 144, 125),	/* 2949.12 MHz */
+	UNIPHIER_CLK_FACTOR("dapll2", -1, "dapll1", 144, 125),	/* 2949.12 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "dapll2", 1, 40),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 48),
 	UNIPHIER_PRO5_SYS_CLK_NAND(2),
-- 
2.7.4
