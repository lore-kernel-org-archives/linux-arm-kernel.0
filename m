From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu, 16 Jan 2014 16:25:34 +0100
Subject: [PATCH] ARM: at91/dt: fix sama5d3 ohci hclk clock reference
Message-ID: <1389885934-26119-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hclk clock of the ohci node is referencing udphs_clk instead of
uhphs_clk.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/sama5d3.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index e398e5d..31356e2 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1195,7 +1195,7 @@
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00600000 0x100000>;
 			interrupts = <32 IRQ_TYPE_LEVEL_HIGH 2>;
-			clocks = <&usb>, <&uhphs_clk>, <&udphs_clk>,
+			clocks = <&usb>, <&uhphs_clk>, <&uhphs_clk>,
 				 <&uhpck>;
 			clock-names = "usb_clk", "ohci_clk", "hclk", "uhpck";
 			status = "disabled";
-- 
1.7.9.5
