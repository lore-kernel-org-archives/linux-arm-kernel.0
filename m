From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:23:40 +0900
Subject: [PATCH 04/80] sh: sh7757: Fix GPIO_FN_ET0_MDIO and GPIO_FN_ET1_MDIO
 GPIO entries
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080696-31489-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The GPIO_FN_ET0_MDIO and GPIO_FN_ET1_MDIO GPIO entries incorrectly
reference the ET0_MDC_MARK and ET1_MDC_MARK marks instead of the
ET0_MDIO_MARK and ET1_MDIO_MARK marks. Fix them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c
index 4c74bd0..4a2736d 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c
@@ -1376,9 +1376,9 @@ static struct pinmux_gpio pinmux_gpios[] = {
 	PINMUX_GPIO(GPIO_FN_WE1, WE1_MARK),
 	PINMUX_GPIO(GPIO_FN_RDY, RDY_MARK),
 	PINMUX_GPIO(GPIO_FN_ET0_MDC, ET0_MDC_MARK),
-	PINMUX_GPIO(GPIO_FN_ET0_MDIO, ET0_MDC_MARK),
+	PINMUX_GPIO(GPIO_FN_ET0_MDIO, ET0_MDIO_MARK),
 	PINMUX_GPIO(GPIO_FN_ET1_MDC, ET1_MDC_MARK),
-	PINMUX_GPIO(GPIO_FN_ET1_MDIO, ET1_MDC_MARK),
+	PINMUX_GPIO(GPIO_FN_ET1_MDIO, ET1_MDIO_MARK),
 
 	/* PTB (mobule: INTC, ONFI, TMU) */
 	PINMUX_GPIO(GPIO_FN_IRQ15, IRQ15_MARK),
-- 
1.7.10.4
