From: chris.paterson2@renesas.com (Chris Paterson)
Date: Wed, 13 Sep 2017 18:05:38 +0100
Subject: [PATCH 5/8] ARM: dts: r8a7743: Add QSPI support
In-Reply-To: <1505322341-9480-1-git-send-email-chris.paterson2@renesas.com>
References: <1505322341-9480-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <1505322341-9480-6-git-send-email-chris.paterson2@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Add the DT node for the QSPI interface to the SoC dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
This patch is based on renesas-devel-20170913-v4.13.

This patch is dependant on:
- "dt-bindings: qspi: Add r8a7743/5 to the compatible list"


 arch/arm/boot/dts/r8a7743.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 266c5ec..454f980 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -28,6 +28,7 @@
 		i2c6 = &iic0;
 		i2c7 = &iic1;
 		i2c8 = &iic3;
+		spi0 = &qspi;
 	};
 
 	cpus {
@@ -835,6 +836,22 @@
 			status = "disabled";
 		};
 
+		qspi: spi at e6b10000 {
+			compatible = "renesas,qspi-r8a7743", "renesas,qspi";
+			reg = <0 0xe6b10000 0 0x2c>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 917>;
+			dmas = <&dmac0 0x17>, <&dmac0 0x18>,
+			       <&dmac1 0x17>, <&dmac1 0x18>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			resets = <&cpg 917>;
+			status = "disabled";
+		};
+
 		sdhi0: sd at ee100000 {
 			compatible = "renesas,sdhi-r8a7743";
 			reg = <0 0xee100000 0 0x328>;
-- 
1.9.1
