From: Jiri.Pinkava@vscht.cz (=?ISO-8859-2?Q?Ji=F8=ED_Pinkava?=)
Date: Mon, 4 Oct 2010 02:25:41 +0200
Subject: [PATCH 2/6] n35: Update GPIO documentation for Acer n35
In-Reply-To: <4CA91EDA.80009@vscht.cz>
References: <4CA91E6F.3010704@vscht.cz> <4CA91EDA.80009@vscht.cz>
Message-ID: <4CA91F05.3040602@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
---
  arch/arm/mach-s3c2410/mach-n30.c |   12 +++++-------
  1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-n30.c 
b/arch/arm/mach-s3c2410/mach-n30.c
index e732619..abbb9b5 100644
--- a/arch/arm/mach-s3c2410/mach-n30.c
+++ b/arch/arm/mach-s3c2410/mach-n30.c
@@ -410,13 +410,11 @@ static struct s3c2410_platform_i2c __initdata 
n30_i2ccfg = {
  static void __init n30_hwinit(void)
  {
  	/* GPA0-11 special functions -- unknown what they do
-	 * GPA12 N30 special function -- unknown what it does
-	 *       N35/PiN output -- unknown what it does
-	 *
-	 * A12 is nGCS1 on the N30 and an output on the N35/PiN.  I
-	 * don't think it does anything useful on the N30, so I ought
-	 * to make it an output there too since it always driven to 0
-	 * as far as I can tell. */
+	 * GPA12 N30 special function (nGCS1) -- unknown what it does
+	 *       PiN output -- unknown function
+	 *       N35 output -- turn on/off red led, 0 = normal operation,
+	 *       1 = turn off red led at all. Note: GPD9 must be input or
+	 *       output with value set to 1 before setting GPA12 to 0. */
  	if (machine_is_n30())
  		__raw_writel(0x007fffff, S3C2410_GPACON);
  	if (machine_is_n35())
-- 
1.7.3.1
