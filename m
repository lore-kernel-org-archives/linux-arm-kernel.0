From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 28 Oct 2012 18:35:54 +0300
Subject: [PATCH 4/5] ARM: PXA: Zipit Z2: Change active_state of power button
In-Reply-To: <1351438555-4668-1-git-send-email-anarsoul@gmail.com>
References: <1351438555-4668-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1351438555-4668-4-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: mcmajeres <mark@engine12.com>

Otherwise userspace might be confused about button state

Signed-off-by: mcmajeres <mark@engine12.com>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-pxa/z2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index ce90fa9..fac7cba 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -437,7 +437,7 @@ static struct gpio_keys_button z2_pxa_buttons[] = {
 	{
 		.code		= KEY_POWER,
 		.gpio		= GPIO1_ZIPITZ2_POWER_BUTTON,
-		.active_low	= 0,
+		.active_low	= 1,
 		.desc		= "Power Button",
 		.wakeup		= 1,
 		.type		= EV_KEY,
-- 
1.7.12.4
