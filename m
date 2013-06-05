From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:38 +0900
Subject: [PATCH 107/130] ARM: shmobile: kzm9g-reference: Remove the VCCQ MC0
 function GPIO
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-108-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The VCCQ MC0 power gate is now controlled by a regulator registered by
the PFC driver. Remove the corresponding function GPIO.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g-reference.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index aefa50d..44055fe 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -79,7 +79,6 @@ static void __init kzm_init(void)
 	sh73a0_pinmux_init();
 
 	/* enable SD */
-	gpio_request(GPIO_FN_SDHI0_VCCQ_MC0_ON,	NULL);
 	gpio_request_one(15, GPIOF_OUT_INIT_HIGH, NULL); /* power */
 
 	gpio_request_one(14, GPIOF_OUT_INIT_HIGH, NULL); /* power */
-- 
1.8.2.1
