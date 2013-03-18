From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:05:23 +0900
Subject: [PATCH 027/142] ARM: shmobile: bonito: Replace GPIO_PORTx enum with
 GPIO port numbers
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-28-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The PFC GPIO API implementation moved to using port numbers. Replace all
GPIO_PORTx enum usage with the corresponding port number. The GPIO_PORTx
enum values are identical to the port number on this platform.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-shmobile/board-bonito.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index e50f866..d363526 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -392,8 +392,8 @@ static void __init bonito_init(void)
 	/*
 	 * base board settings
 	 */
-	gpio_request_one(GPIO_PORT176, GPIOF_IN, NULL);
-	if (!gpio_get_value(GPIO_PORT176)) {
+	gpio_request_one(176, GPIOF_IN, NULL);
+	if (!gpio_get_value(176)) {
 		u16 bsw2;
 		u16 bsw3;
 		u16 bsw4;
@@ -461,7 +461,7 @@ static void __init bonito_init(void)
 			gpio_request(GPIO_FN_LCD0_DISP,		NULL);
 			gpio_request(GPIO_FN_LCD0_LCLK_PORT165,	NULL);
 
-			gpio_request_one(GPIO_PORT61, GPIOF_OUT_INIT_HIGH,
+			gpio_request_one(61, GPIOF_OUT_INIT_HIGH,
 					 NULL); /* LCDDON */
 
 			/* backlight on */
-- 
1.7.10.4
