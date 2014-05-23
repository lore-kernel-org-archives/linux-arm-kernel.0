From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 23 May 2014 22:58:53 +0200
Subject: [PATCH] clk: samsung: clk-s3c2410-dlck: do not use PNAME macro as it
 declares __initdata
Message-ID: <4598341.WkbLY9yLfe@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The originally used PNAME macro from the core samsung clock infrastructure
declares the created array as initdata, creating section mismatch warnings
in the dclk driver.

Thus declare them directly, removing these warning.

Reported-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
This should probably go though the samsung tree / arm-soc, as the
offending patch is also in there.

 drivers/clk/samsung/clk-s3c2410-dclk.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/samsung/clk-s3c2410-dclk.c b/drivers/clk/samsung/clk-s3c2410-dclk.c
index 8d8dff0..c1726f4 100644
--- a/drivers/clk/samsung/clk-s3c2410-dclk.c
+++ b/drivers/clk/samsung/clk-s3c2410-dclk.c
@@ -135,26 +135,26 @@ struct s3c24xx_dclk {
 #define to_s3c24xx_dclk1(x) \
 		container_of(x, struct s3c24xx_dclk, dclk1_div_change_nb)
 
-PNAME(dclk_s3c2410_p) = { "pclk", "uclk" };
-PNAME(clkout0_s3c2410_p) = { "mpll", "upll", "fclk", "hclk", "pclk",
+static const char *dclk_s3c2410_p[] = { "pclk", "uclk" };
+static const char *clkout0_s3c2410_p[] = { "mpll", "upll", "fclk", "hclk", "pclk",
 			     "gate_dclk0" };
-PNAME(clkout1_s3c2410_p) = { "mpll", "upll", "fclk", "hclk", "pclk",
+static const char *clkout1_s3c2410_p[] = { "mpll", "upll", "fclk", "hclk", "pclk",
 			     "gate_dclk1" };
 
-PNAME(clkout0_s3c2412_p) = { "mpll", "upll", "rtc_clkout",
+static const char *clkout0_s3c2412_p[] = { "mpll", "upll", "rtc_clkout",
 			     "hclk", "pclk", "gate_dclk0" };
-PNAME(clkout1_s3c2412_p) = { "xti", "upll", "fclk", "hclk", "pclk",
+static const char *clkout1_s3c2412_p) = { "xti", "upll", "fclk", "hclk", "pclk",
 			     "gate_dclk1" };
 
-PNAME(clkout0_s3c2440_p) = { "xti", "upll", "fclk", "hclk", "pclk",
+static const char *clkout0_s3c2440_p[] = { "xti", "upll", "fclk", "hclk", "pclk",
 			     "gate_dclk0" };
-PNAME(clkout1_s3c2440_p) = { "mpll", "upll", "rtc_clkout",
+static const char *clkout1_s3c2440_p[] = { "mpll", "upll", "rtc_clkout",
 			     "hclk", "pclk", "gate_dclk1" };
 
-PNAME(dclk_s3c2443_p) = { "pclk", "epll" };
-PNAME(clkout0_s3c2443_p) = { "xti", "epll", "armclk", "hclk", "pclk",
+static const char *dclk_s3c2443_p[] = { "pclk", "epll" };
+static const char *clkout0_s3c2443_p[] = { "xti", "epll", "armclk", "hclk", "pclk",
 			     "gate_dclk0" };
-PNAME(clkout1_s3c2443_p) = { "dummy", "epll", "rtc_clkout",
+static const char *clkout1_s3c2443_p[] = { "dummy", "epll", "rtc_clkout",
 			     "hclk", "pclk", "gate_dclk1" };
 
 #define DCLKCON_DCLK_DIV_MASK		0xf
-- 
1.9.0
