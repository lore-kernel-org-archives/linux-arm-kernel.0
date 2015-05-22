From: dhdang@apm.com (Duc Dang)
Date: Fri, 22 May 2015 11:41:11 -0700
Subject: [PATCH v8 3/4] arm64: dts: Add the device tree entry for the APM
 X-Gene PCIe MSI node
In-Reply-To: <cover.1432318289.git.dhdang@apm.com>
References: <cover.1432318289.git.dhdang@apm.com>
Message-ID: <27a6fb8d129cc9abf84d1a0ae02163a9b87d3d0a.1432318289.git.dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is single MSI block in X-Gene v1 SOC which serves all 5 PCIe ports.

Signed-off-by: Duc Dang <dhdang@apm.com>
Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index f1ad9c2..4b719c9 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -354,6 +354,28 @@
 			};
 		};
 
+		msi: msi at 79000000 {
+			compatible = "apm,xgene1-msi";
+			msi-controller;
+			reg = <0x00 0x79000000 0x0 0x900000>;
+			interrupts = <  0x0 0x10 0x4
+					0x0 0x11 0x4
+					0x0 0x12 0x4
+					0x0 0x13 0x4
+					0x0 0x14 0x4
+					0x0 0x15 0x4
+					0x0 0x16 0x4
+					0x0 0x17 0x4
+					0x0 0x18 0x4
+					0x0 0x19 0x4
+					0x0 0x1a 0x4
+					0x0 0x1b 0x4
+					0x0 0x1c 0x4
+					0x0 0x1d 0x4
+					0x0 0x1e 0x4
+					0x0 0x1f 0x4>;
+		};
+
 		pcie0: pcie at 1f2b0000 {
 			status = "disabled";
 			device_type = "pci";
@@ -375,6 +397,7 @@
 					 0x0 0x0 0x0 0x4 &gic 0x0 0xc5 0x1>;
 			dma-coherent;
 			clocks = <&pcie0clk 0>;
+			msi-parent = <&msi>;
 		};
 
 		pcie1: pcie at 1f2c0000 {
@@ -398,6 +421,7 @@
 					 0x0 0x0 0x0 0x4 &gic 0x0 0xcb 0x1>;
 			dma-coherent;
 			clocks = <&pcie1clk 0>;
+			msi-parent = <&msi>;
 		};
 
 		pcie2: pcie at 1f2d0000 {
@@ -421,6 +445,7 @@
 					 0x0 0x0 0x0 0x4 &gic 0x0 0xd1 0x1>;
 			dma-coherent;
 			clocks = <&pcie2clk 0>;
+			msi-parent = <&msi>;
 		};
 
 		pcie3: pcie at 1f500000 {
@@ -444,6 +469,7 @@
 					 0x0 0x0 0x0 0x4 &gic 0x0 0xd7 0x1>;
 			dma-coherent;
 			clocks = <&pcie3clk 0>;
+			msi-parent = <&msi>;
 		};
 
 		pcie4: pcie at 1f510000 {
@@ -467,6 +493,7 @@
 					 0x0 0x0 0x0 0x4 &gic 0x0 0xdd 0x1>;
 			dma-coherent;
 			clocks = <&pcie4clk 0>;
+			msi-parent = <&msi>;
 		};
 
 		serial0: serial at 1c020000 {
-- 
1.9.1
