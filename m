From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Tue, 3 Apr 2018 20:09:31 -0500
Subject: [PATCH] clk: samsung: s3c: Mark expected switch fall-through
Message-ID: <20180404010931.GA30291@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that in this particular case I replaced the comma wiht a dash,
which is what GCC is expecting to find when there are other comments
in the same line in which "fall through" appears.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
This code was compiled with GCC 7.3.0

 drivers/clk/samsung/clk-s3c2443.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-s3c2443.c b/drivers/clk/samsung/clk-s3c2443.c
index c46e6d5..7ebb87f 100644
--- a/drivers/clk/samsung/clk-s3c2443.c
+++ b/drivers/clk/samsung/clk-s3c2443.c
@@ -429,7 +429,7 @@ void __init s3c2443_common_clk_init(struct device_node *np, unsigned long xti_f,
 				ARRAY_SIZE(s3c2450_gates));
 		samsung_clk_register_alias(ctx, s3c2450_aliases,
 				ARRAY_SIZE(s3c2450_aliases));
-		/* fall through, as s3c2450 extends the s3c2416 clocks */
+		/* fall through - as s3c2450 extends the s3c2416 clocks */
 	case S3C2416:
 		samsung_clk_register_div(ctx, s3c2416_dividers,
 				ARRAY_SIZE(s3c2416_dividers));
-- 
2.7.4
