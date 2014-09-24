From: rric@kernel.org (Robert Richter)
Date: Wed, 24 Sep 2014 17:37:45 +0200
Subject: [PATCH 3/6] pci, thunder: Add PCIe host controller devicetree bindings
In-Reply-To: <1411573068-12952-1-git-send-email-rric@kernel.org>
References: <1411573068-12952-1-git-send-email-rric@kernel.org>
Message-ID: <1411573068-12952-4-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

This patch adds the PCIe host controller entry for Cavium Thunder SoCs
to the devicetree. There are 4 internal PCI controllers available.

Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 arch/arm64/boot/dts/thunder-88xx.dtsi | 49 +++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/thunder-88xx.dtsi b/arch/arm64/boot/dts/thunder-88xx.dtsi
index 9cb7cf94284a..0b433b0e7af4 100644
--- a/arch/arm64/boot/dts/thunder-88xx.dtsi
+++ b/arch/arm64/boot/dts/thunder-88xx.dtsi
@@ -407,4 +407,53 @@
 			clock-names = "apb_pclk";
 		};
 	};
+
+	pcie0 at 0x8480,00000000 {
+	        compatible = "cavium,thunder-pcie";
+		device_type = "pci";
+		msi-parent = <&its>;
+		bus-range = <0 255>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0x8480 0x00000000 0 0x10000000>;  /* Configuration space */
+		ranges = <0x03000000 0x8010 0x00000000 0x8010 0x00000000 0x70 0x00000000>, /* mem ranges */
+			<0x03000000 0x8300 0x00000000 0x8300 0x00000000 0x80 0x00000000>,
+			<0x03000000 0x87e0 0x00000000 0x87e0 0x00000000 0x01 0x00000000>;
+        };
+
+	pcie1 at 0x8490,00000000 {
+	        compatible = "cavium,thunder-pcie";
+		device_type = "pci";
+		msi-parent = <&its>;
+		bus-range = <0 255>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0x8490 0x00000000 0 0x10000000>;  /* Configuration space */
+		ranges = <0x03000000 0x8310 0x00000000 0x8310 0x00000000 0x00 0x10000000>, /* mem ranges */
+			<0x03000000 0x8100 0x00000000 0x8100 0x00000000 0x80 0x00000000>;
+        };
+
+	pcie2 at 0x84a0,00000000 {
+	        compatible = "cavium,thunder-pcie";
+		device_type = "pci";
+		msi-parent = <&its>;
+		bus-range = <0 255>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0x84a0 0x00000000 0 0x10000000>;  /* Configuration space */
+		ranges = <0x03000000 0x8320 0x00000000 0x8320 0x00000000 0x00 0x10000000>, /* mem ranges */
+			<0x03000000 0x8430 0x00000000 0x8430 0x00000000 0x01 0x00000000>;
+        };
+
+	pcie3 at 0x84b0,00000000 {
+	        compatible = "cavium,thunder-pcie";
+		device_type = "pci";
+		msi-parent = <&its>;
+		bus-range = <0 255>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0x84b0 0x00000000 0 0x10000000>;  /* Configuration space */
+		ranges = <0x03000000 0x8330 0x00000000 0x8330 0x00000000 0x00 0x10000000>, /* mem ranges */
+			<0x03000000 0x8180 0x00000000 0x8180 0x00000000 0x80 0x00000000>;
+        };
 };
-- 
2.1.0
