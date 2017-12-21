From: rasmus.villemoes@prevas.dk (Rasmus Villemoes)
Date: Thu, 21 Dec 2017 16:38:18 +0100
Subject: [PATCH] ARM: dts: ls1021a: add nodes for on-chip ram
Message-ID: <1513870698-31264-1-git-send-email-rasmus.villemoes@prevas.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 arch/arm/boot/dts/ls1021a.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index bd6622f10046..6f53e6aefb63 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -748,5 +748,21 @@
 					<0000 0 0 3 &gic GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		ocram1: sram at 10000000 {
+			compatible = "mmio-sram";
+			reg = <0x0 0x10000000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x10000000 0x10000>;
+		};
+
+		ocram2: sram at 10010000 {
+			compatible = "mmio-sram";
+			reg = <0x0 0x10010000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x10010000 0x10000>;
+		};
 	};
 };
-- 
2.7.4
