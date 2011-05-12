From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 12 May 2011 10:11:13 +0900
Subject: [PATCH 6/7] video: s3c-fb: Remove to support fb for S5PC100
In-Reply-To: <1305162674-25860-1-git-send-email-kgene.kim@samsung.com>
References: <1305162674-25860-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1305162674-25860-7-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to removing ARCH_S5PC100, we don't need to support
fb for S5PC100.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/video/s3c-fb.c |   33 ---------------------------------
 1 files changed, 0 insertions(+), 33 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 3b6cdca..9928c7e 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1696,36 +1696,6 @@ static struct s3c_fb_driverdata s3c_fb_data_64xx = {
 	.win[4]	= &s3c_fb_data_64xx_wins[4],
 };
 
-static struct s3c_fb_driverdata s3c_fb_data_s5pc100 = {
-	.variant = {
-		.nr_windows	= 5,
-		.vidtcon	= VIDTCON0,
-		.wincon		= WINCON(0),
-		.winmap		= WINxMAP(0),
-		.keycon		= WKEYCON,
-		.osd		= VIDOSD_BASE,
-		.osd_stride	= 16,
-		.buf_start	= VIDW_BUF_START(0),
-		.buf_size	= VIDW_BUF_SIZE(0),
-		.buf_end	= VIDW_BUF_END(0),
-
-		.palette = {
-			[0] = 0x2400,
-			[1] = 0x2800,
-			[2] = 0x2c00,
-			[3] = 0x3000,
-			[4] = 0x3400,
-		},
-
-		.has_prtcon	= 1,
-	},
-	.win[0]	= &s3c_fb_data_64xx_wins[0],
-	.win[1]	= &s3c_fb_data_64xx_wins[1],
-	.win[2]	= &s3c_fb_data_64xx_wins[2],
-	.win[3]	= &s3c_fb_data_64xx_wins[3],
-	.win[4]	= &s3c_fb_data_64xx_wins[4],
-};
-
 static struct s3c_fb_driverdata s3c_fb_data_s5pv210 = {
 	.variant = {
 		.nr_windows	= 5,
@@ -1797,9 +1767,6 @@ static struct platform_device_id s3c_fb_driver_ids[] = {
 		.name		= "s3c-fb",
 		.driver_data	= (unsigned long)&s3c_fb_data_64xx,
 	}, {
-		.name		= "s5pc100-fb",
-		.driver_data	= (unsigned long)&s3c_fb_data_s5pc100,
-	}, {
 		.name		= "s5pv210-fb",
 		.driver_data	= (unsigned long)&s3c_fb_data_s5pv210,
 	}, {
-- 
1.7.1
