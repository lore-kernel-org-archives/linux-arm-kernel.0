From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 31 Jan 2013 15:23:59 +0900
Subject: [PATCH 6/9] ARM: shmobile: bonito: Use gpio_request_one()
In-Reply-To: <1359613442-26038-1-git-send-email-horms+renesas@verge.net.au>
References: <1359613442-26038-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359613442-26038-7-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace occurences of gpio_request() and gpio_direction_*() by calls to
gpio_request_one().

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bonito.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index cb8c994..932a9c0 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -392,8 +392,7 @@ static void __init bonito_init(void)
 	/*
 	 * base board settings
 	 */
-	gpio_request(GPIO_PORT176, NULL);
-	gpio_direction_input(GPIO_PORT176);
+	gpio_request_one(GPIO_PORT176, GPIOF_IN, NULL);
 	if (!gpio_get_value(GPIO_PORT176)) {
 		u16 bsw2;
 		u16 bsw3;
@@ -462,8 +461,8 @@ static void __init bonito_init(void)
 			gpio_request(GPIO_FN_LCD0_DISP,		NULL);
 			gpio_request(GPIO_FN_LCD0_LCLK_PORT165,	NULL);
 
-			gpio_request(GPIO_PORT61, NULL); /* LCDDON */
-			gpio_direction_output(GPIO_PORT61, 1);
+			gpio_request_one(GPIO_PORT61, GPIOF_OUT_INIT_HIGH,
+					 NULL); /* LCDDON */
 
 			/* backlight on */
 			bonito_fpga_write(LCDCR, 1);
-- 
1.7.10.4
