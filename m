From: mcuelenaere@gmail.com (Patrick Georgi)
Date: Fri, 13 Aug 2010 21:17:56 +0200
Subject: [PATCH 3/5] ARM: S3C64XX: Framebuffer fix for SmartQ5
Message-ID: <4c659a66.097b0e0a.0d05.ffffcdd5@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following change makes the framebuffer work on SmartQ5. There are
still some problems with ADC, so this patch alone won't make the device
run (or even give a working fb), but it's one issue less to think about.

Signed-off-by: Patrick Georgi <patrick@georgi-clan.de>
Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/mach-s3c64xx/mach-smartq5.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index 2bfa708..a4d59b0 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -108,10 +108,10 @@ static struct platform_device smartq5_buttons_device  = {
 
 static struct s3c_fb_pd_win smartq5_fb_win0 = {
 	.win_mode	= {
-		.left_margin	= 40,
-		.right_margin	= 216,
-		.upper_margin	= 10,
-		.lower_margin	= 35,
+		.left_margin	= 216,
+		.right_margin	= 40,
+		.upper_margin	= 35,
+		.lower_margin	= 10,
 		.hsync_len	= 1,
 		.vsync_len	= 1,
 		.xres		= 800,
-- 
1.7.0.4
