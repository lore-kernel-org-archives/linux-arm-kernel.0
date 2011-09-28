From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Wed, 28 Sep 2011 12:18:53 +0200
Subject: [PATCH 1/8] S3C2416: Add armdiv_mask constant
In-Reply-To: <201109281217.33813.heiko@sntech.de>
References: <201109281217.33813.heiko@sntech.de>
Message-ID: <201109281218.53972.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S3C2416/2450 has only 3 bits for the armdiv setting instead
of the 4 bits of the S3C2443.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../mach-s3c2410/include/mach/regs-s3c2443-clock.h |    1 +
 arch/arm/mach-s3c2416/clock.c                      |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h b/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h
index df6434f..c3feff3 100644
--- a/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h
+++ b/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h
@@ -65,6 +65,7 @@
 #define S3C2443_CLKDIV0_PREDIV_MASK	(3<<4)
 #define S3C2443_CLKDIV0_PREDIV_SHIFT	(4)
 
+#define S3C2416_CLKDIV0_ARMDIV_MASK	(7 << 9)
 #define S3C2443_CLKDIV0_ARMDIV_MASK	(15<<9)
 #define S3C2443_CLKDIV0_ARMDIV_SHIFT	(9)
 #define S3C2443_CLKDIV0_ARMDIV_1	(0<<9)
diff --git a/arch/arm/mach-s3c2416/clock.c b/arch/arm/mach-s3c2416/clock.c
index 72b7c62..5569def 100644
--- a/arch/arm/mach-s3c2416/clock.c
+++ b/arch/arm/mach-s3c2416/clock.c
@@ -127,7 +127,7 @@ static struct clk hsmmc0_clk = {
 
 static inline unsigned int s3c2416_fclk_div(unsigned long clkcon0)
 {
-	clkcon0 &= 7 << S3C2443_CLKDIV0_ARMDIV_SHIFT;
+	clkcon0 &= S3C2416_CLKDIV0_ARMDIV_MASK;
 
 	return armdiv[clkcon0 >> S3C2443_CLKDIV0_ARMDIV_SHIFT];
 }
-- 
1.7.5.4
