From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu,  1 Mar 2012 11:19:04 +0200
Subject: [PATCH 2/2] ARM: OMAP3: cm-t3517: add EMAC support
In-Reply-To: <1324423590-32489-1-git-send-email-yanok@emcraft.com>
References: <1324423590-32489-1-git-send-email-yanok@emcraft.com>
Message-ID: <1330593544-25411-2-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the EMAC Ethernet controller in the AM35xx SoC.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t3517.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index f36d694..9e66e16 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -49,6 +49,7 @@
 #include "mux.h"
 #include "control.h"
 #include "common-board-devices.h"
+#include "am35xx-emac.h"
 
 #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
 static struct gpio_led cm_t3517_leds[] = {
@@ -291,6 +292,7 @@ static void __init cm_t3517_init(void)
 	cm_t3517_init_rtc();
 	cm_t3517_init_usbh();
 	cm_t3517_init_hecc();
+	am35xx_emac_init(AM35XX_DEFAULT_MDIO_FREQUENCY, 1);
 }
 
 MACHINE_START(CM_T3517, "Compulab CM-T3517")
-- 
1.7.3.4
