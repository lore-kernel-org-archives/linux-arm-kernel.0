From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  3 Apr 2013 11:04:55 +0900
Subject: [PATCH 17/28] sh-pfc: r8a73a4: Support sparse GPIO numbers
In-Reply-To: <1364954706-14727-1-git-send-email-horms+renesas@verge.net.au>
References: <1364954706-14727-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364954706-14727-18-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The r8a73a4 SoC has sparse GPIO numbers. Declare ranges for pin numbers
in the PFC SoC data. Pin numbers shall be used with the GPIO API from
this point on.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a73a4.h |    2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c          |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a73a4.h b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
index f0b1b4a..2d4af4a 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a73a4.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
@@ -86,7 +86,7 @@ enum {
 	GPIO_PORT325, GPIO_PORT326, GPIO_PORT327, GPIO_PORT328, GPIO_PORT329,
 
 	/* Port0 */
-	GPIO_FN_LCDD0,
+	GPIO_FN_LCDD0 = 330,
 	GPIO_FN_PDM2_CLK_0,
 	GPIO_FN_DU0_DR0,
 	GPIO_FN_IRQ0,
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
index 47d75d5..5dd68fb9 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
@@ -1424,6 +1424,20 @@ static struct sh_pfc_pin pinmux_pins[] = {
 	GPIO_PORT_ALL(),
 };
 
+static const struct pinmux_range pinmux_ranges[] = {
+	{.begin = 0, .end = 30,},
+	{.begin = 32, .end = 40,},
+	{.begin = 64, .end = 85,},
+	{.begin = 96, .end = 126,},
+	{.begin = 128, .end = 134,},
+	{.begin = 160, .end = 178,},
+	{.begin = 192, .end = 222,},
+	{.begin = 224, .end = 250,},
+	{.begin = 256, .end = 283,},
+	{.begin = 288, .end = 308,},
+	{.begin = 320, .end = 329,},
+};
+
 #define PINMUX_FN_BASE	ARRAY_SIZE(pinmux_pins)
 
 static const struct pinmux_func pinmux_func_gpios[] = {
@@ -2815,6 +2829,8 @@ const struct sh_pfc_soc_info r8a73a4_pinmux_info = {
 
 	.pins = pinmux_pins,
 	.nr_pins = ARRAY_SIZE(pinmux_pins),
+	.ranges = pinmux_ranges,
+	.nr_ranges = ARRAY_SIZE(pinmux_ranges),
 	.func_gpios = pinmux_func_gpios,
 	.nr_func_gpios = ARRAY_SIZE(pinmux_func_gpios),
 
-- 
1.7.10.4
