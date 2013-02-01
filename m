From: mporter@ti.com (Matt Porter)
Date: Fri,  1 Feb 2013 13:22:51 -0500
Subject: [PATCH v7 06/10] ARM: dts: add AM33XX EDMA support
In-Reply-To: <1359742975-10421-1-git-send-email-mporter@ti.com>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
Message-ID: <1359742975-10421-7-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds AM33XX EDMA support to the am33xx.dtsi as documented in
Documentation/devicetree/bindings/dma/ti-edma.txt

Signed-off-by: Matt Porter <mporter@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index c2f14e8..e711ffb 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -87,6 +87,26 @@
 			reg = <0x48200000 0x1000>;
 		};
 
+		edma: edma at 49000000 {
+			compatible = "ti,edma3";
+			ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
+			reg =	<0x49000000 0x10000>,
+				<0x44e10f90 0x10>;
+			interrupt-parent = <&intc>;
+			interrupts = <12 13 14>;
+			#dma-cells = <1>;
+			dma-channels = <64>;
+			ti,edma-regions = <4>;
+			ti,edma-slots = <256>;
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
