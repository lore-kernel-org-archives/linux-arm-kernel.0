From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 27 Oct 2009 08:26:18 -0400
Subject: [PATCH] pxa: enable graphics driver
Message-ID: <mailman.95.1256741275.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable graphics driver in littleton, zylonite and saar platform.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/littleton.c |    3 +++
 arch/arm/mach-pxa/saar.c      |    2 ++
 arch/arm/mach-pxa/zylonite.c  |    2 ++
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index 1384895..17bf376 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -49,6 +49,7 @@
 #include <mach/pxa3xx_nand.h>
 #include <mach/littleton.h>

+#include "devices.h"
 #include "generic.h"

 #define GPIO_MMC1_CARD_DETECT	mfp_to_gpio(MFP_PIN_GPIO15)
@@ -419,6 +420,8 @@ static void __init littleton_init(void)
 	 */
 	platform_device_register(&smc91x_device);

+	pxa_register_device(&pxa3xx_device_gcu, NULL);
+
 	littleton_init_spi();
 	littleton_init_i2c();
 	littleton_init_mmc();
diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
index 8241a63..5cd8a97 100644
--- a/arch/arm/mach-pxa/saar.c
+++ b/arch/arm/mach-pxa/saar.c
@@ -487,6 +487,8 @@ static void __init saar_init(void)

 	platform_device_register(&smc91x_device);

+	pxa_register_device(&pxa3xx_device_gcu, NULL);
+
 	saar_init_i2c();
 	saar_init_lcd();
 }
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index 09784d3..685db64 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -456,6 +456,8 @@ static void __init zylonite_init(void)
 	smc91x_resources[1].end   = gpio_to_irq(gpio_eth_irq);
 	platform_device_register(&smc91x_device);

+	pxa_register_device(&pxa3xx_device_gcu, NULL);
+
 	pxa_set_ac97_info(NULL);
 	zylonite_init_lcd();
 	zylonite_init_mmc();
-- 
1.5.6.5
