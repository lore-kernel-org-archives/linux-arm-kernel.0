From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 11 Mar 2011 12:23:43 +0200
Subject: [PATCH 8/8] ARM: PXA: Z2: Add default triggers for LEDs
In-Reply-To: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
References: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1299839023-16601-8-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So user can see if there's any mmc activity and if device's
charging.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-pxa/z2.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 2fac54d..7314a79 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -315,12 +315,12 @@ struct gpio_led z2_gpio_leds[] = {
 	.active_low		= 1,
 }, {
 	.name			= "z2:green:charged",
-	.default_trigger	= "none",
+	.default_trigger	= "mmc0",
 	.gpio			= GPIO85_ZIPITZ2_LED_CHARGED,
 	.active_low		= 1,
 }, {
 	.name			= "z2:amber:charging",
-	.default_trigger	= "none",
+	.default_trigger	= "Z2-charging-or-full",
 	.gpio			= GPIO83_ZIPITZ2_LED_CHARGING,
 	.active_low		= 1,
 },
-- 
1.7.4.1
