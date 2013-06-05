From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:09 +0900
Subject: [PATCH 078/130] ARM: shmobile: bonito: Don't configure LCDC routing
 manually
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-79-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

LCDC routing is configured automatically in the PFC driver, don't
configure it manually in board code.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bonito.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index 2781c7f..b373e9c 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -451,7 +451,6 @@ static void __init bonito_init(void)
 		    BIT_ON(bsw2, 2)) {	/* S38.2 = OFF */
 			pinctrl_register_mappings(lcdc0_pinctrl_map,
 						  ARRAY_SIZE(lcdc0_pinctrl_map));
-			gpio_request(GPIO_FN_LCDC0_SELECT, NULL);
 
 			gpio_request_one(61, GPIOF_OUT_INIT_HIGH,
 					 NULL); /* LCDDON */
-- 
1.8.2.1
