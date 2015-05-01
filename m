From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 01:02:47 +0900
Subject: [PATCH 1/2] clk: s3c2410: Staticize local symbols
Message-ID: <1430496168-32408-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Staticize symbols not exported and not used outside of file.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/clk/samsung/clk-s3c2410-dclk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-s3c2410-dclk.c b/drivers/clk/samsung/clk-s3c2410-dclk.c
index f4f29ed6bd25..db6fddb211d4 100644
--- a/drivers/clk/samsung/clk-s3c2410-dclk.c
+++ b/drivers/clk/samsung/clk-s3c2410-dclk.c
@@ -81,13 +81,13 @@ static int s3c24xx_clkout_set_parent(struct clk_hw *hw, u8 index)
 	return ret;
 }
 
-const struct clk_ops s3c24xx_clkout_ops = {
+static const struct clk_ops s3c24xx_clkout_ops = {
 	.get_parent = s3c24xx_clkout_get_parent,
 	.set_parent = s3c24xx_clkout_set_parent,
 	.determine_rate = __clk_mux_determine_rate,
 };
 
-struct clk *s3c24xx_register_clkout(struct device *dev, const char *name,
+static struct clk *s3c24xx_register_clkout(struct device *dev, const char *name,
 		const char **parent_names, u8 num_parents,
 		u8 shift, u32 mask)
 {
-- 
2.1.4
