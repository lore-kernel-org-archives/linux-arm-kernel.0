From: jbe@pengutronix.de (Juergen Beisert)
Date: Sun,  8 Jul 2012 19:12:22 +0200
Subject: [PATCH 08/10] MACH/Samsung/Mini2440: enable button 6 as one of the
 GPIO keys
In-Reply-To: <1341767544-17447-1-git-send-email-jbe@pengutronix.de>
References: <1341767544-17447-1-git-send-email-jbe@pengutronix.de>
Message-ID: <1341767544-17447-9-git-send-email-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no more restriction to omit button 6

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
---
 arch/arm/mach-s3c24xx/mach-mini2440.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index 36149ed..ad1d89e 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -415,16 +415,12 @@ static struct gpio_keys_button mini2440_buttons[] = {
 		.desc		= "Button 5",
 		.active_low	= 1,
 	},
-#if 0
-	/* this pin is also known as TCLK1 and seems to already
-	 * marked as "in use" somehow in the kernel -- possibly wrongly */
 	{
-		.gpio		= S3C2410_GPG(11),	/* K6 */
+		.gpio		= S3C2410_GPG(11),		/* K6 */
 		.code		= KEY_F6,
 		.desc		= "Button 6",
 		.active_low	= 1,
 	},
-#endif
 };
 
 static struct gpio_keys_platform_data mini2440_button_data = {
-- 
1.7.10
