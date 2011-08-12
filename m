From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Fri, 12 Aug 2011 15:56:26 +0530
Subject: [PATCH 4/5] ARM: S5P64X0: Fix incorrect serial clock name
In-Reply-To: <1313144787-30666-1-git-send-email-a.kesavan@samsung.com>
References: <1313144787-30666-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1313144787-30666-5-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S3C6400 serial glue driver(used by S5P64X0) needs the clock name to be
pclk or uclk1. Correct the clock name in init.c to pclk and source pclk
from pclk_low to get the correct rate.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/mach-s5p64x0/clock-s5p6440.c |    2 +-
 arch/arm/mach-s5p64x0/clock-s5p6450.c |    2 +-
 arch/arm/mach-s5p64x0/init.c          |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c b/arch/arm/mach-s5p64x0/clock-s5p6440.c
index 0e9cd30..4b594a4 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6440.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6440.c
@@ -554,7 +554,7 @@ void __init_or_cpufreq s5p6440_setup_clocks(void)
 
 	clk_f.rate = fclk;
 	clk_h.rate = hclk;
-	clk_p.rate = pclk;
+	clk_p.rate = pclk_low;
 
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
 		s3c_set_clksrc(&clksrcs[ptr], true);
diff --git a/arch/arm/mach-s5p64x0/clock-s5p6450.c b/arch/arm/mach-s5p64x0/clock-s5p6450.c
index d9dc16c..eca9a57 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6450.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6450.c
@@ -613,7 +613,7 @@ void __init_or_cpufreq s5p6450_setup_clocks(void)
 
 	clk_f.rate = fclk;
 	clk_h.rate = hclk;
-	clk_p.rate = pclk;
+	clk_p.rate = pclk_low;
 
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
 		s3c_set_clksrc(&clksrcs[ptr], true);
diff --git a/arch/arm/mach-s5p64x0/init.c b/arch/arm/mach-s5p64x0/init.c
index 79833ca..ee25e28 100644
--- a/arch/arm/mach-s5p64x0/init.c
+++ b/arch/arm/mach-s5p64x0/init.c
@@ -25,7 +25,7 @@
 
 static struct s3c24xx_uart_clksrc s5p64x0_serial_clocks[] = {
 	[0] = {
-		.name		= "pclk_low",
+		.name		= "pclk",
 		.divisor	= 1,
 		.min_baud	= 0,
 		.max_baud	= 0,
-- 
1.7.4.1
