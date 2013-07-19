From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 19 Jul 2013 13:37:12 +0900
Subject: [PATCH 13/19] ARM: shmobile: armadillo-reference: Move st1232 reset
 GPIO to DT
In-Reply-To: <cover.1374208262.git.horms+renesas@verge.net.au>
References: <cover.1374208262.git.horms+renesas@verge.net.au>
Message-ID: <9900595b3dac2948112ed7745dbb28d2a8bf99f9.1374208262.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reference the st1232 reset GPIO from the device tree and remove it from
board code.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts  |    2 ++
 arch/arm/mach-shmobile/board-armadillo800eva-reference.c |    7 -------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index a6c6606..8ec4cd1 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -10,6 +10,7 @@
 
 /dts-v1/;
 /include/ "r8a7740.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "armadillo 800 eva reference";
@@ -43,6 +44,7 @@
 		interrupts = <2 0>; /* IRQ10: hwirq 2 on irqpin1 */
 		pinctrl-0 = <&st1232_pins>;
 		pinctrl-names = "default";
+		gpios = <&pfc 166 GPIO_ACTIVE_LOW>;
 	};
 };
 
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index 4ddd299..002d8d3 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -158,7 +158,6 @@ clock_error:
  */
 static void __init eva_init(void)
 {
-
 	r8a7740_clock_init(MD_CK0 | MD_CK2);
 	eva_clock_init();
 
@@ -171,12 +170,6 @@ static void __init eva_init(void)
 
 	r8a7740_add_standard_devices_dt();
 
-	/*
-	 * Touchscreen
-	 * TODO: Move reset GPIO over to .dts when we can reference it
-	 */
-	gpio_request_one(166, GPIOF_OUT_INIT_HIGH, NULL); /* TP_RST_B */
-
 	r8a7740_pm_init();
 }
 
-- 
1.7.10.4
