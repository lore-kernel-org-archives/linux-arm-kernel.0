From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 31 Jan 2013 15:24:01 +0900
Subject: [PATCH 8/9] ARM: shmobile: mackerel: Use gpio_request_one()
In-Reply-To: <1359613442-26038-1-git-send-email-horms+renesas@verge.net.au>
References: <1359613442-26038-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359613442-26038-9-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace occurences of gpio_request() and gpio_direction_*() by calls to
gpio_request_one().

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 002eaf6..8de350f 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1406,11 +1406,10 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_LCDDISP,  NULL);
 	gpio_request(GPIO_FN_LCDDCK,   NULL);
 
-	gpio_request(GPIO_PORT31, NULL); /* backlight */
-	gpio_direction_output(GPIO_PORT31, 0); /* off by default */
+	/* backlight, off by default */
+	gpio_request_one(GPIO_PORT31, GPIOF_OUT_INIT_LOW, NULL);
 
-	gpio_request(GPIO_PORT151, NULL); /* LCDDON */
-	gpio_direction_output(GPIO_PORT151, 1);
+	gpio_request_one(GPIO_PORT151, GPIOF_OUT_INIT_HIGH, NULL); /* LCDDON */
 
 	/* USBHS0 */
 	gpio_request(GPIO_FN_VBUS0_0, NULL);
@@ -1426,8 +1425,7 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_FSIAILR,	NULL);
 	gpio_request(GPIO_FN_FSIAISLD,	NULL);
 	gpio_request(GPIO_FN_FSIAOSLD,	NULL);
-	gpio_request(GPIO_PORT161,	NULL);
-	gpio_direction_output(GPIO_PORT161, 0); /* slave */
+	gpio_request_one(GPIO_PORT161, GPIOF_OUT_INIT_LOW, NULL); /* slave */
 
 	gpio_request(GPIO_PORT9,  NULL);
 	gpio_request(GPIO_PORT10, NULL);
@@ -1481,8 +1479,7 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_SDHID1_0, NULL);
 #endif
 	/* card detect pin for MMC slot (CN7) */
-	gpio_request(GPIO_PORT41, NULL);
-	gpio_direction_input(GPIO_PORT41);
+	gpio_request_one(GPIO_PORT41, GPIOF_IN, NULL);
 
 	/* enable SDHI2 */
 	gpio_request(GPIO_FN_SDHICMD2, NULL);
@@ -1493,8 +1490,7 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_SDHID2_0, NULL);
 
 	/* card detect pin for microSD slot (CN23) */
-	gpio_request(GPIO_PORT162, NULL);
-	gpio_direction_input(GPIO_PORT162);
+	gpio_request_one(GPIO_PORT162, GPIOF_IN, NULL);
 
 	/* MMCIF */
 	gpio_request(GPIO_FN_MMCD0_0, NULL);
-- 
1.7.10.4
