From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:05:07 +0900
Subject: [PATCH 011/142] sh-pfc: Make struct pinmux_gpio enum_id field const
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-12-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

This ensures that the field is not modified, which is a prerequisite for
the rest of the PFC refactoring work.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/sh_pfc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index e150395..6ed7ab9 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -36,7 +36,7 @@ enum {
 #define PINMUX_FLAG_DREG            (0x3f << PINMUX_FLAG_DREG_SHIFT)
 
 struct pinmux_gpio {
-	pinmux_enum_t enum_id;
+	const pinmux_enum_t enum_id;
 	pinmux_flag_t flags;
 	const char *name;
 };
-- 
1.7.10.4
