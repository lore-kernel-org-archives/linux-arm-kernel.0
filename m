From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:48 +0900
Subject: [PATCH 112/142] sh-pfc: sh73a0: Remove USB function GPIOS
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-113-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

All sh73a0 platforms now use the pinctrl API to control the USB pins,
the corresponding function GPIOS are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 7b010b6..273345c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -2936,11 +2936,10 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(usb),
 };
 
-#define PINMUX_FN_BASE	GPIO_FN_VBUS_0
+#define PINMUX_FN_BASE	GPIO_FN_GPI0
 
 static const struct pinmux_func pinmux_func_gpios[] = {
 	/* Table 25-1 (Functions 0-7) */
-	GPIO_FN(VBUS_0),
 	GPIO_FN(GPI0),
 	GPIO_FN(GPI1),
 	GPIO_FN(GPI2),
-- 
1.7.10.4
