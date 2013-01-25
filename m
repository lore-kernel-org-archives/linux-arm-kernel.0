From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:23:43 +0900
Subject: [PATCH 07/80] sh: shx3: Fix last GPIO index
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080696-31489-8-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

A careless look at the code shows that the last entry in the
pinmux_gpios seems to be GPIO_FN_IRQOUT. However, entries are ordered by
the GPIO number, as the PINMUX_GPIO macro is expended to an indexed
array initializer. The last entry in the array is thus GPIO_FN_STATUS0.
Set the pinmux_info last_gpio field accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/sh/kernel/cpu/sh4a/pinmux-shx3.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-shx3.c b/arch/sh/kernel/cpu/sh4a/pinmux-shx3.c
index aaa5338..2ebb983 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-shx3.c
@@ -572,7 +572,7 @@ static struct pinmux_info shx3_pinmux_info = {
 	.mark		= { PINMUX_MARK_BEGIN,     PINMUX_MARK_END },
 	.function	= { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
 	.first_gpio	= GPIO_PA7,
-	.last_gpio	= GPIO_FN_IRQOUT,
+	.last_gpio	= GPIO_FN_STATUS0,
 	.gpios		= shx3_pinmux_gpios,
 	.gpio_data	= shx3_pinmux_data,
 	.gpio_data_size	= ARRAY_SIZE(shx3_pinmux_data),
-- 
1.7.10.4
