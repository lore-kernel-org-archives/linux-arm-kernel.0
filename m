From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 14 Jul 2014 08:39:27 +0200
Subject: [PATCH] ARM: at91/dt: fix usb0 clocks definition in sam9n12 dtsi
Message-ID: <1405319967-20807-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

udphs_clk (USB Device Controller clock) is referenced instead of
uhphs_clk (USB Host Controller clock).

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9n12.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 2877959..b84bac5 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -925,7 +925,7 @@
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00500000 0x00100000>;
 			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
-			clocks = <&usb>, <&uhphs_clk>, <&udphs_clk>,
+			clocks = <&usb>, <&uhphs_clk>, <&uhphs_clk>,
 				 <&uhpck>;
 			clock-names = "usb_clk", "ohci_clk", "hclk", "uhpck";
 			status = "disabled";
-- 
1.8.3.2
