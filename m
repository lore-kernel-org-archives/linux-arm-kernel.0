From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sat, 30 Jun 2012 14:09:01 +0200
Subject: [PATCH 09/10] ARM: S3C24XX: Correct AC97 clock control bit for S3C2440
In-Reply-To: <1341058142-30438-1-git-send-email-sylvester.nawrocki@gmail.com>
References: <1341058142-30438-1-git-send-email-sylvester.nawrocki@gmail.com>
Message-ID: <1341058142-30438-10-git-send-email-sylvester.nawrocki@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use correct gate control bit for AC97 clock which is
S3C2440_CLKCON_AC97, not S3C2440_CLKCON_CAMERA.

Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
---
 arch/arm/mach-s3c24xx/clock-s3c2440.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/clock-s3c2440.c b/arch/arm/mach-s3c24xx/clock-s3c2440.c
index 414364e..cb2883d 100644
--- a/arch/arm/mach-s3c24xx/clock-s3c2440.c
+++ b/arch/arm/mach-s3c24xx/clock-s3c2440.c
@@ -106,7 +106,7 @@ static struct clk s3c2440_clk_cam_upll = {
 static struct clk s3c2440_clk_ac97 = {
 	.name		= "ac97",
 	.enable		= s3c2410_clkcon_enable,
-	.ctrlbit	= S3C2440_CLKCON_CAMERA,
+	.ctrlbit	= S3C2440_CLKCON_AC97,
 };
 
 static unsigned long  s3c2440_fclk_n_getrate(struct clk *clk)
-- 
1.7.4.1
