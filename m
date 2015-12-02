From: petr@barix.com (Petr Kulhavy)
Date: Wed,  2 Dec 2015 15:18:08 +0100
Subject: [PATCH] ARM: DaVinci DA850: added missing #gpio-cells into DTSI
Message-ID: <1449065888-31735-1-git-send-email-petr@barix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpio definition was missing the mandatory parameter "#gpio-cells"
---
 arch/arm/boot/dts/da850.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index b695548..c42ae76 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -260,6 +260,7 @@
 		gpio: gpio at 1e26000 {
 			compatible = "ti,dm6441-gpio";
 			gpio-controller;
+			#gpio-cells = <2>;
 			reg = <0x226000 0x1000>;
 			interrupts = <42 IRQ_TYPE_EDGE_BOTH
 				43 IRQ_TYPE_EDGE_BOTH 44 IRQ_TYPE_EDGE_BOTH
-- 
1.9.1
