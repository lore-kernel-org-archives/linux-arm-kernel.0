From: mporter@ti.com (Matt Porter)
Date: Thu, 11 Oct 2012 15:04:32 -0400
Subject: [RFC PATCH v2 07/16] ARM: dts: add AM33XX EDMA support
In-Reply-To: <1349982281-10785-1-git-send-email-mporter@ti.com>
References: <1349982281-10785-1-git-send-email-mporter@ti.com>
Message-ID: <1349982281-10785-8-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds AM33XX EDMA support to the am33xx.dtsi as documented in
Documentation/devicetree/bindings/dma/ti-edma.txt

Signed-off-by: Matt Porter <mporter@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index bb31bff..2ddb31b 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -62,6 +62,36 @@
 			reg = <0x48200000 0x1000>;
 		};
 
+		edma: edma at 49000000 {
+			compatible = "ti,edma3";
+			ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
+			reg = <0x49000000 0x10000>;
+			interrupt-parent = <&intc>;
+			interrupts = <12 13 14>;
+			#dma-cells = <1>;
+			dma-channels = <64>;
+			ti,edma-regions = <4>;
+			ti,edma-slots = <256>;
+			ti,edma-reserved-channels = <0  2
+						     14 2
+						     26 6
+						     48 4
+						     56 8>;
+			ti,edma-reserved-slots = <0  2
+						  14 2
+						  26 6
+						  48 4
+						  56 8
+						  64 127>;
+			ti,edma-queue-tc-map = <0 0
+						1 1
+						2 2>;
+			ti,edma-queue-priority-map = <0 0
+						      1 1
+						      2 2>;
+			ti,edma-default-queue = <0>;
+		};
+
 		gpio1: gpio at 44e07000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio1";
-- 
1.7.9.5
