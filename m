From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Tue, 13 Jul 2010 02:03:56 +0200
Subject: [PATCH] ARM: SAMSUNG: Remove pixclock from several boards
Message-ID: <4c3bad6e.ce7c0e0a.20a4.ffffd0a9@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since "s3c-fb: Automatically calculate pixel clock when none is given", there's
no need for manually calculating the pixel clock anymore so remove these lines
and add the correct refresh rate where appropriately.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---

This was only tested on a S3C6410 SmartQ 7, so Tested-by's are welcome!

---
 arch/arm/mach-s3c64xx/mach-anw6410.c  |    1 -
 arch/arm/mach-s3c64xx/mach-hmt.c      |    1 -
 arch/arm/mach-s3c64xx/mach-smartq5.c  |    3 +--
 arch/arm/mach-s3c64xx/mach-smartq7.c  |    3 +--
 arch/arm/mach-s3c64xx/mach-smdk6410.c |    1 -
 arch/arm/mach-s5pc100/mach-smdkc100.c |    2 +-
 arch/arm/mach-s5pv210/mach-aquila.c   |    2 --
 7 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index 4a0bb24..742dc87 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -134,7 +134,6 @@ static struct platform_device anw6410_lcd_powerdev = {
 static struct s3c_fb_pd_win anw6410_fb_win0 = {
 	/* this is to ensure we use win0 */
 	.win_mode	= {
-		.pixclock	= 41094,
 		.left_margin	= 8,
 		.right_margin	= 13,
 		.upper_margin	= 7,
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index 187441a..fba9022 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -128,7 +128,6 @@ static struct platform_device hmt_backlight_device = {
 
 static struct s3c_fb_pd_win hmt_fb_win0 = {
 	.win_mode	= {
-		.pixclock	= 41094,
 		.left_margin	= 8,
 		.right_margin	= 13,
 		.upper_margin	= 7,
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index 1d0326e..a065062 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -134,8 +134,6 @@ static struct platform_device smartq5_buttons_device  = {
 
 static struct s3c_fb_pd_win smartq5_fb_win0 = {
 	.win_mode	= {
-		.pixclock	= 1000000000000ULL /
-				((40+1+216+800)*(10+1+35+480)*80),
 		.left_margin	= 40,
 		.right_margin	= 216,
 		.upper_margin	= 10,
@@ -144,6 +142,7 @@ static struct s3c_fb_pd_win smartq5_fb_win0 = {
 		.vsync_len	= 1,
 		.xres		= 800,
 		.yres		= 480,
+		.refresh	= 80,
 	},
 	.max_bpp	= 32,
 	.default_bpp	= 16,
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index e0bc78e..0ecf451 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
@@ -150,8 +150,6 @@ static struct platform_device smartq7_buttons_device  = {
 
 static struct s3c_fb_pd_win smartq7_fb_win0 = {
 	.win_mode	= {
-		.pixclock	= 1000000000000ULL /
-				((3+10+5+800)*(1+3+20+480)*80),
 		.left_margin	= 3,
 		.right_margin	= 5,
 		.upper_margin	= 1,
@@ -160,6 +158,7 @@ static struct s3c_fb_pd_win smartq7_fb_win0 = {
 		.vsync_len	= 3,
 		.xres		= 800,
 		.yres		= 480,
+		.refresh	= 80,
 	},
 	.max_bpp	= 32,
 	.default_bpp	= 16,
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index d9a0355..0302fcc 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -141,7 +141,6 @@ static struct platform_device smdk6410_lcd_powerdev = {
 static struct s3c_fb_pd_win smdk6410_fb_win0 = {
 	/* this is to ensure we use win0 */
 	.win_mode	= {
-		.pixclock	= 41094,
 		.left_margin	= 8,
 		.right_margin	= 13,
 		.upper_margin	= 7,
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index af22f82..117fbba 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -128,7 +128,6 @@ static struct platform_device smdkc100_lcd_powerdev = {
 static struct s3c_fb_pd_win smdkc100_fb_win0 = {
 	/* this is to ensure we use win0 */
 	.win_mode	= {
-		.pixclock = 1000000000000ULL / ((8+13+3+800)*(7+5+1+480)*80),
 		.left_margin	= 8,
 		.right_margin	= 13,
 		.upper_margin	= 7,
@@ -137,6 +136,7 @@ static struct s3c_fb_pd_win smdkc100_fb_win0 = {
 		.vsync_len	= 1,
 		.xres		= 800,
 		.yres		= 480,
+		.refresh	= 80,
 	},
 	.max_bpp	= 32,
 	.default_bpp	= 16,
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 10bc76e..881fe89 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -77,7 +77,6 @@ static struct s3c2410_uartcfg smdkv210_uartcfgs[] __initdata = {
 /* Frame Buffer */
 static struct s3c_fb_pd_win aquila_fb_win0 = {
 	.win_mode = {
-		.pixclock = 1000000000000ULL / ((16+16+2+480)*(28+3+2+800)*60),
 		.left_margin = 16,
 		.right_margin = 16,
 		.upper_margin = 3,
@@ -93,7 +92,6 @@ static struct s3c_fb_pd_win aquila_fb_win0 = {
 
 static struct s3c_fb_pd_win aquila_fb_win1 = {
 	.win_mode = {
-		.pixclock = 1000000000000ULL / ((16+16+2+480)*(28+3+2+800)*60),
 		.left_margin = 16,
 		.right_margin = 16,
 		.upper_margin = 3,
-- 
1.7.0.4
