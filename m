From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 23 Jun 2014 23:29:09 +0300
Subject: [PATCH 1/2] clk: samsung: fix several typos to fix boot on s3c2410
Message-ID: <1403555350-14895-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's a several typos in a driver: 2410 instead of S3C2410
and wrong argument to ARRAY_SIZE(). They prevent s3c2410
from properly booting.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/clk/samsung/clk-s3c2410.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-s3c2410.c b/drivers/clk/samsung/clk-s3c2410.c
index ba07168..bd9a873 100644
--- a/drivers/clk/samsung/clk-s3c2410.c
+++ b/drivers/clk/samsung/clk-s3c2410.c
@@ -378,7 +378,7 @@ void __init s3c2410_common_clk_init(struct device_node *np, unsigned long xti_f,
 	if (!np)
 		s3c2410_common_clk_register_fixed_ext(ctx, xti_f);
 
-	if (current_soc == 2410) {
+	if (current_soc == S3C2410) {
 		if (_get_rate("xti") == 12 * MHZ) {
 			s3c2410_plls[mpll].rate_table = pll_s3c2410_12mhz_tbl;
 			s3c2410_plls[upll].rate_table = pll_s3c2410_12mhz_tbl;
@@ -432,7 +432,7 @@ void __init s3c2410_common_clk_init(struct device_node *np, unsigned long xti_f,
 		samsung_clk_register_fixed_factor(ctx, s3c2410_ffactor,
 				ARRAY_SIZE(s3c2410_ffactor));
 		samsung_clk_register_alias(ctx, s3c2410_aliases,
-			ARRAY_SIZE(s3c2410_common_aliases));
+			ARRAY_SIZE(s3c2410_aliases));
 		break;
 	case S3C2440:
 		samsung_clk_register_mux(ctx, s3c2440_muxes,
-- 
2.0.0
