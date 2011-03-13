From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 13 Mar 2011 17:19:20 +0200
Subject: [PATCH v2 4/6] ARM: PXA: Z2: Keep kbd backlight disabled by default
In-Reply-To: <1300029562-8400-1-git-send-email-anarsoul@gmail.com>
References: <1300029562-8400-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1300029562-8400-5-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It eats too much power, and anyway it's not usefull
during boot process. Userspace can enable it later.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-pxa/z2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 2c5a5cc..eb52444 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -203,7 +203,7 @@ static struct platform_pwm_backlight_data z2_backlight_data[] = {
 		/* Keypad Backlight */
 		.pwm_id		= 1,
 		.max_brightness	= 1023,
-		.dft_brightness	= 512,
+		.dft_brightness	= 0,
 		.pwm_period_ns	= 1260320,
 	},
 	[1] = {
-- 
1.7.4.1
