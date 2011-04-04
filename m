From: festevam@gmail.com (Fabio Estevam)
Date: Sun,  3 Apr 2011 22:47:23 -0300
Subject: [PATCH] ARM: mx5/mx53_loco: Fix build warning related to
	gpio_keys_button structure
Message-ID: <1301881643-26040-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following warning:

CC      arch/arm/mach-mx5/board-mx53_loco.o
arch/arm/mach-mx5/board-mx53_loco.c:203: warning: initialization discards qualifiers from pointer target type

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/board-mx53_loco.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 10a1bea..6206b11 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -193,7 +193,7 @@ static iomux_v3_cfg_t mx53_loco_pads[] = {
 	.wakeup		= wake,					\
 }
 
-static const struct gpio_keys_button loco_buttons[] __initconst = {
+static struct gpio_keys_button loco_buttons[] = {
 	GPIO_BUTTON(MX53_LOCO_POWER, KEY_POWER, 1, "power", 0),
 	GPIO_BUTTON(MX53_LOCO_UI1, KEY_VOLUMEUP, 1, "volume-up", 0),
 	GPIO_BUTTON(MX53_LOCO_UI2, KEY_VOLUMEDOWN, 1, "volume-down", 0),
-- 
1.6.0.4
