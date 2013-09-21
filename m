From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Fri, 20 Sep 2013 22:03:11 -0300
Subject: [PATCH 2/3] clk: sunxi: factors: clear variables before using them
In-Reply-To: <1379725392-30202-1-git-send-email-emilio@elopez.com.ar>
References: <1379725392-30202-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1379725392-30202-3-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Random bits may get into our factors if we don't clear n, k, m and p.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 drivers/clk/sunxi/clk-factors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index 5687ac9..f05207a 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -88,7 +88,7 @@ static long clk_factors_round_rate(struct clk_hw *hw, unsigned long rate,
 static int clk_factors_set_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long parent_rate)
 {
-	u8 n, k, m, p;
+	u8 n = 0, k = 0, m = 0, p = 0;
 	u32 reg;
 	struct clk_factors *factors = to_clk_factors(hw);
 	struct clk_factors_config *config = factors->config;
-- 
1.8.4
