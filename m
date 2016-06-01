From: tony@atomide.com (Tony Lindgren)
Date: Wed,  1 Jun 2016 09:21:52 -0700
Subject: [PATCH] ARM: dts: Fix omap5 SDIO dat1 interrupt
Message-ID: <1464798112-8793-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SDIO wakeirq is wrong, it needs to be SDIO dat1 line, not dat0.
Otherwise the system won't wake to SDIO interrupts from idle states.

This makes the wl12xx behave better on igepv5, otherwise we may have hard
time connecting to an access point.

And omap5-uevm or wl18xx still seems to have some other issues remaining.

Cc: Agust? Fontquerni <af@iseebcn.com>
Cc: Eduard Gavin <egavin@iseebcn.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Uri Mashiach <uri.mashiach@compulab.co.il>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap5-board-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -357,7 +357,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc3_pins &wlcore_irq_pin>;
 	interrupts-extended = <&gic GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH
-			       &omap5_pmx_core 0x168>;
+			       &omap5_pmx_core 0x16a>;
 
 	#address-cells = <1>;
 	#size-cells = <0>;
-- 
2.8.1
