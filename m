From: romain.izard.pro@gmail.com (Romain Izard)
Date: Fri, 17 Feb 2017 16:12:50 +0100
Subject: [PATCH] Revert "ARM: at91/dt: sama5d2: Use new compatible for ohci
 node"
Message-ID: <20170217151250.8572-1-romain.izard.pro@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit cab43282682e ("ARM: at91/dt: sama5d2: Use new
compatible for ohci node")

It depends from commit 7150bc9b4d43 ("usb: ohci-at91: Forcibly suspend
ports while USB suspend") which was reverted and implemented
differently. With the new implementation, the compatible string must
remain the same.

The compatible string introduced by this commit has been used in the
default SAMA5D2 dtsi starting from Linux 4.8. As it has never been
working correctly in an official release, removing it should not be
breaking the stability rules.

Fixes: cab43282682e ("ARM: at91/dt: sama5d2: Use new compatible for ohci node")
Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
cc: <stable@vger.kernel.org>
---
 arch/arm/boot/dts/sama5d2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index ceb9783ff7e1..ff7eae833a6d 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -266,7 +266,7 @@
 		};
 
 		usb1: ohci at 00400000 {
-			compatible = "atmel,sama5d2-ohci", "usb-ohci";
+			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00400000 0x100000>;
 			interrupts = <41 IRQ_TYPE_LEVEL_HIGH 2>;
 			clocks = <&uhphs_clk>, <&uhphs_clk>, <&uhpck>;
-- 
2.9.3
