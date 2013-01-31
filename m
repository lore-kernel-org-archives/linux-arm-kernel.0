From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 31 Jan 2013 15:23:58 +0900
Subject: [PATCH 5/9] ARM: shmobile: kota2: Use gpio_request_one()
In-Reply-To: <1359613442-26038-1-git-send-email-horms+renesas@verge.net.au>
References: <1359613442-26038-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359613442-26038-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Replace occurences of gpio_request() and gpio_direction_*() by calls to
gpio_request_one().

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kota2.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kota2.c b/arch/arm/mach-shmobile/board-kota2.c
index bf88f9a..7ec3112 100644
--- a/arch/arm/mach-shmobile/board-kota2.c
+++ b/arch/arm/mach-shmobile/board-kota2.c
@@ -474,10 +474,8 @@ static void __init kota2_init(void)
 	gpio_request(GPIO_FN_D15_NAF15, NULL);
 	gpio_request(GPIO_FN_CS5A_, NULL);
 	gpio_request(GPIO_FN_WE0__FWE, NULL);
-	gpio_request(GPIO_PORT144, NULL); /* PINTA2 */
-	gpio_direction_input(GPIO_PORT144);
-	gpio_request(GPIO_PORT145, NULL); /* RESET */
-	gpio_direction_output(GPIO_PORT145, 1);
+	gpio_request_one(GPIO_PORT144, GPIOF_IN, NULL); /* PINTA2 */
+	gpio_request_one(GPIO_PORT145, GPIOF_OUT_INIT_HIGH, NULL); /* RESET */
 
 	/* KEYSC */
 	gpio_request(GPIO_FN_KEYIN0_PU, NULL);
@@ -509,8 +507,7 @@ static void __init kota2_init(void)
 	gpio_request(GPIO_FN_MMCD0_6, NULL);
 	gpio_request(GPIO_FN_MMCD0_7, NULL);
 	gpio_request(GPIO_FN_MMCCMD0, NULL);
-	gpio_request(GPIO_PORT208, NULL); /* Reset */
-	gpio_direction_output(GPIO_PORT208, 1);
+	gpio_request_one(GPIO_PORT208, GPIOF_OUT_INIT_HIGH, NULL); /* Reset */
 
 	/* SDHI0 (microSD) */
 	gpio_request(GPIO_FN_SDHICD0_PU, NULL);
-- 
1.7.10.4
