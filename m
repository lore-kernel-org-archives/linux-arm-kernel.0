From: LW@KARO-electronics.de (=?utf-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Mon, 21 Mar 2011 16:15:44 +0100
Subject: [PATCH] ARM: mxs: TX28: Change pwm backlight max_brightness to 100
In-Reply-To: <1300720545-14123-2-git-send-email-LW@KARO-electronics.de>
References: <1300720545-14123-1-git-send-email-LW@KARO-electronics.de>
	<1300720545-14123-2-git-send-email-LW@KARO-electronics.de>
Message-ID: <1300720545-14123-3-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change max_brightness for PWM backlight to 100, so that the configured
brightness value equals the PWM duty cycle in percent.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/mach-mxs/mach-tx28.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-tx28.c b/arch/arm/mach-mxs/mach-tx28.c
index b0d91e7..f7c6526 100644
--- a/arch/arm/mach-mxs/mach-tx28.c
+++ b/arch/arm/mach-mxs/mach-tx28.c
@@ -304,8 +304,8 @@ early_param("videomem", tx28_set_videomem);
 
 static struct platform_pwm_backlight_data pwm_data = {
 	.pwm_id = 0,
-	.max_brightness = 255,
-	.dft_brightness = 255,
+	.max_brightness = 100,
+	.dft_brightness = 100,
 	.pwm_period_ns = 100000,
 };
 
-- 
1.5.6.5
