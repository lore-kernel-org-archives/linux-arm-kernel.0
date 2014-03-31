From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Mon, 31 Mar 2014 11:30:53 +0100
Subject: [PATCH v7 08/10] ARM: shmobile: r8a7791: Add PCIe device nodes
In-Reply-To: <1396261856-22465-1-git-send-email-phil.edworthy@renesas.com>
References: <1396261856-22465-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1396261856-22465-9-git-send-email-phil.edworthy@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

v6:
 - Split device and board DT changes
---
 arch/arm/boot/dts/r8a7791.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index ccfba57..7a4be4c 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -836,4 +836,28 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	pcie: pcie at fe000000 {
+		compatible = "renesas,pcie-r8a7791";
+		reg = <0 0xfe000000 0 0x80000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000
+			  0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000
+			  0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
+			  0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
+		/* Map all possible DDR as inbound ranges */
+		dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000
+			      0x43000000 2 0x00000000 2 0x00000000 1 0x00000000>;
+		interrupts = <0 116 IRQ_TYPE_LEVEL_HIGH
+			      0 117 IRQ_TYPE_LEVEL_HIGH
+			      0 118 IRQ_TYPE_LEVEL_HIGH>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic 0 116 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7791_CLK_PCIE>, <&pcie_bus_clk>;
+		clock-names = "pcie", "pcie_bus";
+		status = "disabled";
+	};
 };
-- 
1.9.0
