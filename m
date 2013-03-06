From: mporter@ti.com (Matt Porter)
Date: Wed,  6 Mar 2013 11:15:36 -0500
Subject: [PATCH v9 6/9] ARM: dts: add AM33XX EDMA support
In-Reply-To: <1362586540-10393-1-git-send-email-mporter@ti.com>
References: <1362586540-10393-1-git-send-email-mporter@ti.com>
Message-ID: <1362586540-10393-7-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds AM33XX EDMA support to the am33xx.dtsi as documented in
Documentation/devicetree/bindings/dma/ti-edma.txt

Signed-off-by: Matt Porter <mporter@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 0957645..cbea5ab 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -87,6 +87,25 @@
 			reg = <0x48200000 0x1000>;
 		};
 
+		edma: edma at 49000000 {
+			compatible = "ti,edma3";
+			ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
+			reg =	<0x49000000 0x10000>,
+				<0x44e10f90 0x10>;
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
