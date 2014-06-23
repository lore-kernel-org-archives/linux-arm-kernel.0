From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 23 Jun 2014 23:29:10 +0300
Subject: [PATCH 2/2] clk: samsung: add more aliases for s3c24xx
In-Reply-To: <1403555350-14895-1-git-send-email-anarsoul@gmail.com>
References: <1403555350-14895-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1403555350-14895-2-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without these aliases clock lookup fails in s3c2410fb,
s3cmci, s3c2410-nand, s3c24xx-i2s, and i2c-s3c2410 drivers.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/clk/samsung/clk-s3c2410.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/samsung/clk-s3c2410.c b/drivers/clk/samsung/clk-s3c2410.c
index bd9a873..140f473 100644
--- a/drivers/clk/samsung/clk-s3c2410.c
+++ b/drivers/clk/samsung/clk-s3c2410.c
@@ -152,6 +152,11 @@ struct samsung_clock_alias s3c2410_common_aliases[] __initdata = {
 	ALIAS(HCLK, NULL, "hclk"),
 	ALIAS(MPLL, NULL, "mpll"),
 	ALIAS(FCLK, NULL, "fclk"),
+	ALIAS(PCLK, NULL, "watchdog"),
+	ALIAS(PCLK_SDI, NULL, "sdi"),
+	ALIAS(HCLK_NAND, NULL, "nand"),
+	ALIAS(PCLK_I2S, NULL, "iis"),
+	ALIAS(PCLK_I2C, NULL, "i2c"),
 };
 
 /* S3C2410 specific clocks */
-- 
2.0.0
