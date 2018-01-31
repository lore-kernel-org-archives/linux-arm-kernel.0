From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 31 Jan 2018 08:56:37 +0200
Subject: [PATCH v2 1/2] arm64: dts: marvell: add CP110 uart peripherals
Message-ID: <03f1bec6e11c9f6fb9d5520c745eafca28597801.1517381798.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CP110 component has 4 uart peripherals. All of them use the same clock
gate for slow peripherals that is shared with the i2c and spi peripherals.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v2: No change
---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index a8af4136dbe7..a422cd981a0b 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -290,6 +290,46 @@
 			status = "disabled";
 		};
 
+		CP110_LABEL(uart0): serial at 702000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x702000 0x100>;
+			reg-shift = <2>;
+			interrupts = <ICU_GRP_NSR 122 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <1>;
+			clocks = <&CP110_LABEL(clk) 1 21>;
+			status = "disabled";
+		};
+
+		CP110_LABEL(uart1): serial at 702100 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x702100 0x100>;
+			reg-shift = <2>;
+			interrupts = <ICU_GRP_NSR 123 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <1>;
+			clocks = <&CP110_LABEL(clk) 1 21>;
+			status = "disabled";
+		};
+
+		CP110_LABEL(uart2): serial at 702200 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x702200 0x100>;
+			reg-shift = <2>;
+			interrupts = <ICU_GRP_NSR 124 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <1>;
+			clocks = <&CP110_LABEL(clk) 1 21>;
+			status = "disabled";
+		};
+
+		CP110_LABEL(uart3): serial at 702300 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x702300 0x100>;
+			reg-shift = <2>;
+			interrupts = <ICU_GRP_NSR 125 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <1>;
+			clocks = <&CP110_LABEL(clk) 1 21>;
+			status = "disabled";
+		};
+
 		CP110_LABEL(nand): nand at 720000 {
 			/*
 			* Due to the limitation of the pins available
-- 
2.15.1
