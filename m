From: florian.meier@koalo.de (Florian Meier)
Date: Mon, 13 Jan 2014 12:11:43 +0100
Subject: [PATCH 1/2] BCM2835: Add dmaengine driver to device tree
Message-ID: <52D3C9EF.1030901@koalo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the definitions for the BCM2835 dmaengine driver
to the device tree. The dma-channel-mask is currently
fixed. Later it should be set via the firmware.

Signed-off-by: Florian Meier <florian.meier@koalo.de>
---
 arch/arm/boot/dts/bcm2835.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index b021c96..1da6b36 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -113,6 +113,27 @@
 			reg = <0x7e980000 0x10000>;
 			interrupts = <1 9>;
 		};
+
+		dma: dma at 7e007000 {
+			compatible = "brcm,bcm2835-dma";
+			reg = <0x7e007000 0xf00>;
+			interrupts = <1 16>,
+				     <1 17>,
+				     <1 18>,
+				     <1 19>,
+				     <1 20>,
+				     <1 21>,
+				     <1 22>,
+				     <1 23>,
+				     <1 24>,
+				     <1 25>,
+				     <1 26>,
+				     <1 27>,
+				     <1 28>;
+
+			#dma-cells = <1>;
+			brcm,dma-channel-mask = <0x7f35>;
+		};
 	};
 
 	clocks {
-- 
1.8.3.2
