From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 26 May 2018 11:38:34 +0200
Subject: [PATCH] ARM: pxa: hx4700: fix the usb client
Message-ID: <20180526093834.21277-1-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usb client of the hx4700 is not working because no platform data is
declared. Fix it by adding the missing call.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/hx4700.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index e2e7f247a645..b79b757fdd41 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -54,6 +54,7 @@
 
 #include "devices.h"
 #include "generic.h"
+#include "udc.h"
 
 /* Physical address space information */
 
@@ -594,6 +595,8 @@ static struct platform_device gpio_vbus = {
 	},
 };
 
+static struct pxa2xx_udc_mach_info hx4700_udc_info;
+
 /*
  * Touchscreen - TSC2046 connected to SSP2
  */
@@ -891,6 +894,7 @@ static void __init hx4700_init(void)
 	gpio_set_value(GPIO71_HX4700_ASIC3_nRESET, 1);
 	mdelay(10);
 
+	pxa_set_udc_info(&hx4700_udc_info);
 	regulator_has_full_constraints();
 }
 
-- 
2.11.0
