From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:23:52 +0900
Subject: [PATCH 16/80] sh-pfc: Remove check for impossible error condition
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080696-31489-17-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The pfc pointer can't be NULL in the get and set value functions, remove
the error check.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/sh/pfc/gpio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/sh/pfc/gpio.c b/drivers/sh/pfc/gpio.c
index 37493e5..c11c1bb 100644
--- a/drivers/sh/pfc/gpio.c
+++ b/drivers/sh/pfc/gpio.c
@@ -52,7 +52,7 @@ static void sh_gpio_set_value(struct sh_pfc *pfc, unsigned gpio, int value)
 	struct pinmux_data_reg *dr = NULL;
 	int bit = 0;
 
-	if (!pfc || sh_pfc_get_data_reg(pfc, gpio, &dr, &bit) != 0)
+	if (sh_pfc_get_data_reg(pfc, gpio, &dr, &bit) != 0)
 		BUG();
 	else
 		sh_pfc_write_bit(dr, bit, value);
@@ -63,7 +63,7 @@ static int sh_gpio_get_value(struct sh_pfc *pfc, unsigned gpio)
 	struct pinmux_data_reg *dr = NULL;
 	int bit = 0;
 
-	if (!pfc || sh_pfc_get_data_reg(pfc, gpio, &dr, &bit) != 0)
+	if (sh_pfc_get_data_reg(pfc, gpio, &dr, &bit) != 0)
 		return -EINVAL;
 
 	return sh_pfc_read_bit(dr, bit);
-- 
1.7.10.4
