From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Fri, 21 Mar 2014 10:32:45 +0000
Subject: [PATCH v4 6/9] ARM: shmobile: Add PCIe device tree nodes for R8A7790
In-Reply-To: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1395397968-6242-7-git-send-email-phil.edworthy@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the device tree nodes for R8A7790

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index df9ec61..e7d498a 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -821,4 +821,23 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	pcie: pcie at fe000000 {
+		compatible = "renesas,r8a7790-pcie";
+		reg = <0 0xfe000000 0 0x80000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000
+			  0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000
+			  0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
+			  0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
+		interrupts = <0 116 IRQ_TYPE_LEVEL_HIGH>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic 0 116 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_PCIE>;
+		clock-names = "pcie";
+		status = "disabled";
+	};
 };
-- 
1.9.0
