From: tony@atomide.com (Tony Lindgren)
Date: Fri,  9 Sep 2016 14:00:37 -0700
Subject: [PATCH] ARM: dts: Configure panda SDIO WLAN wakeirq
Message-ID: <20160909210037.19090-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise we have delays on noticing interrupts from the
WLAN card when idle.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -446,6 +446,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&wl12xx_pins>;
 	vmmc-supply = <&wl12xx_vmmc>;
+	interrupts-extended = <&wakeupgen GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH
+			       &omap4_pmx_core 0x10e>;
 	non-removable;
 	bus-width = <4>;
 	cap-power-off-card;
-- 
2.9.3
