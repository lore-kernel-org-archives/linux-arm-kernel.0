From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:16 +0900
Subject: [PATCH 085/130] sh-pfc: r8a7740: Remove HDMI function GPIOS
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-86-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

All r8a7740 platforms now use the pinctrl API to control the HDMI pins,
the corresponding function GPIOS are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index a93fd84..fb7a3e8 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -3386,10 +3386,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(SDENC_CPG),
 	GPIO_FN(SDENC_DV_CLKI),
 
-	/* HDMI */
-	GPIO_FN(HDMI_HPD),
-	GPIO_FN(HDMI_CEC),
-
 	/* SYSC */
 	GPIO_FN(RESETP_PULLUP),
 	GPIO_FN(RESETP_PLAIN),
-- 
1.8.2.1
