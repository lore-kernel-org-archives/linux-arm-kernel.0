From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 31 Jan 2013 15:24:00 +0900
Subject: [PATCH 7/9] ARM: shmobile: kzm9g: Use gpio_request_one()
In-Reply-To: <1359613442-26038-1-git-send-email-horms+renesas@verge.net.au>
References: <1359613442-26038-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359613442-26038-8-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace occurences of gpio_request() and gpio_direction_*() by calls to
gpio_request_one().

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index eadf309..2d08f57 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -672,8 +672,7 @@ static void __init kzm_init(void)
 	gpio_request(GPIO_FN_CS4_, NULL); /* CS4 */
 
 	/* SMSC */
-	gpio_request(GPIO_PORT224, NULL); /* IRQ3 */
-	gpio_direction_input(GPIO_PORT224);
+	gpio_request_one(GPIO_PORT224, GPIOF_IN, NULL); /* IRQ3 */
 
 	/* LCDC */
 	gpio_request(GPIO_FN_LCDD23,	NULL);
@@ -703,14 +702,11 @@ static void __init kzm_init(void)
 	gpio_request(GPIO_FN_LCDDISP,	NULL);
 	gpio_request(GPIO_FN_LCDDCK,	NULL);
 
-	gpio_request(GPIO_PORT222,	NULL); /* LCDCDON */
-	gpio_request(GPIO_PORT226,	NULL); /* SC */
-	gpio_direction_output(GPIO_PORT222, 1);
-	gpio_direction_output(GPIO_PORT226, 1);
+	gpio_request_one(GPIO_PORT222, GPIOF_OUT_INIT_HIGH, NULL); /* LCDCDON */
+	gpio_request_one(GPIO_PORT226, GPIOF_OUT_INIT_HIGH, NULL); /* SC */
 
 	/* Touchscreen */
-	gpio_request(GPIO_PORT223, NULL); /* IRQ8 */
-	gpio_direction_input(GPIO_PORT223);
+	gpio_request_one(GPIO_PORT223, GPIOF_IN, NULL); /* IRQ8 */
 
 	/* enable MMCIF */
 	gpio_request(GPIO_FN_MMCCLK0,		NULL);
@@ -734,8 +730,7 @@ static void __init kzm_init(void)
 	gpio_request(GPIO_FN_SDHID0_1,		NULL);
 	gpio_request(GPIO_FN_SDHID0_0,		NULL);
 	gpio_request(GPIO_FN_SDHI0_VCCQ_MC0_ON,	NULL);
-	gpio_request(GPIO_PORT15, NULL);
-	gpio_direction_output(GPIO_PORT15, 1); /* power */
+	gpio_request_one(GPIO_PORT15, GPIOF_OUT_INIT_HIGH, NULL); /* power */
 
 	/* enable Micro SD */
 	gpio_request(GPIO_FN_SDHID2_0,		NULL);
@@ -744,8 +739,7 @@ static void __init kzm_init(void)
 	gpio_request(GPIO_FN_SDHID2_3,		NULL);
 	gpio_request(GPIO_FN_SDHICMD2,		NULL);
 	gpio_request(GPIO_FN_SDHICLK2,		NULL);
-	gpio_request(GPIO_PORT14, NULL);
-	gpio_direction_output(GPIO_PORT14, 1); /* power */
+	gpio_request_one(GPIO_PORT14, GPIOF_OUT_INIT_HIGH, NULL); /* power */
 
 	/* I2C 3 */
 	gpio_request(GPIO_FN_PORT27_I2C_SCL3, NULL);
-- 
1.7.10.4
