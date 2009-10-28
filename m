From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 28 Oct 2009 12:15:52 +0000
Subject: [PATCH 11/12] ARM: S3C2440: mini2440: Fix spare warnings
In-Reply-To: <1256732153-22027-1-git-send-email-ben-linux@fluff.org>
References: <1256732153-22027-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1256732153-22027-11-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following sparse warnings in arch/arm/mach-s3c2440/mach-mini2440.c
due to missing 'static'.

warning: symbol 'mini2440_lcd_cfg' was not declared. Should it be static?
warning: symbol 'mini2440_fb_info' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2440/mach-mini2440.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c2440/mach-mini2440.c b/arch/arm/mach-s3c2440/mach-mini2440.c
index ec71a69..1c3382f 100644
--- a/arch/arm/mach-s3c2440/mach-mini2440.c
+++ b/arch/arm/mach-s3c2440/mach-mini2440.c
@@ -144,7 +144,7 @@ static struct s3c2410_udc_mach_info mini2440_udc_cfg __initdata = {
 	.type		= (S3C2410_LCDCON1_TFT16BPP |\
 			   S3C2410_LCDCON1_TFT)
 
-struct s3c2410fb_display mini2440_lcd_cfg[] __initdata = {
+static struct s3c2410fb_display mini2440_lcd_cfg[] __initdata = {
 	[0] = {	/* mini2440 + 3.5" TFT + touchscreen */
 		_LCD_DECLARE(
 			7,			/* The 3.5 is quite fast */
@@ -191,7 +191,7 @@ struct s3c2410fb_display mini2440_lcd_cfg[] __initdata = {
 #define S3C2410_GPCCON_MASK(x)	(3 << ((x) * 2))
 #define S3C2410_GPDCON_MASK(x)	(3 << ((x) * 2))
 
-struct s3c2410fb_mach_info mini2440_fb_info __initdata = {
+static struct s3c2410fb_mach_info mini2440_fb_info __initdata = {
 	.displays	 = &mini2440_lcd_cfg[0], /* not constant! see init */
 	.num_displays	 = 1,
 	.default_display = 0,
-- 
1.6.3.3
