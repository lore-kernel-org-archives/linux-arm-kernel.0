From: daniel@zonque.org (Daniel Mack)
Date: Tue, 22 May 2018 00:00:43 +0200
Subject: [PATCH 1/2] ARM: pxa: dts: add gpio-ranges to gpio controller
Message-ID: <20180521220044.821-1-daniel@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PXA GPIO driver calls out to the pinctrl driver for claiming pins
unless the config has CONFIG_PINCTRL unset. IOW, if a pinctrl driver is
active, it must be visible to the GPIO driver.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 arch/arm/boot/dts/pxa3xx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index 982d1a62661d..a13ac52e4fd2 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -148,6 +148,7 @@
 			compatible = "intel,pxa3xx-gpio";
 			reg = <0x40e00000 0x10000>;
 			clocks = <&clks CLK_GPIO>;
+			gpio-ranges = <&pinctrl 0 0 128>;
 			interrupt-names = "gpio0", "gpio1", "gpio_mux";
 			interrupts = <8 9 10>;
 			gpio-controller;
-- 
2.14.3
