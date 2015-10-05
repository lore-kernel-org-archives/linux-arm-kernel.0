From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  5 Oct 2015 10:49:44 +0200
Subject: [PATCH 04/17] ARM: pxa: hx4700: Remove unused field initializers
In-Reply-To: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
References: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1444034997-9805-5-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ID and period for the backlight PWM are obtained from a PWM lookup
table, so the corresponding values don't need to be duplicated into the
platform data.

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 arch/arm/mach-pxa/hx4700.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 5fb41ad6e3bc..c10898c283e6 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -557,10 +557,8 @@ static struct platform_device hx4700_lcd = {
  */
 
 static struct platform_pwm_backlight_data backlight_data = {
-	.pwm_id         = -1,	/* Superseded by pwm_lookup */
 	.max_brightness = 200,
 	.dft_brightness = 100,
-	.pwm_period_ns  = 30923,
 	.enable_gpio    = -1,
 };
 
-- 
2.5.0
