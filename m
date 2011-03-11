From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 11 Mar 2011 12:23:42 +0200
Subject: [PATCH 7/8] ARM: PXA: Z2: Keep kbd backlight disabled by default
In-Reply-To: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
References: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1299839023-16601-7-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It eats too much power, and anyway it's not usefull
during boot process. Userspace can enable it later.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-pxa/z2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index d1e40ba..2fac54d 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -210,7 +210,7 @@ static struct platform_pwm_backlight_data z2_backlight_data[] = {
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
