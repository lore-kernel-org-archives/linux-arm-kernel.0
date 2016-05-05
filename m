From: jonmason@broadcom.com (Jon Mason)
Date: Thu,  5 May 2016 19:29:30 -0400
Subject: [PATCH 1/3] ARM: dts: NSP: Add MSI support on PCI
Message-ID: <1462490972-13566-1-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MSI support to the PCI driver of the Northstar Plus SoC.  This uses
the existing pcie-iproc driver.  So, all that is needed is device tree
entries in the DTS.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index def9e78..a44bf29 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -290,6 +290,18 @@
 		ranges = <0x82000000 0 0x08000000 0x08000000 0 0x8000000>;
 
 		status = "disabled";
+
+		msi-parent = <&msi0>;
+		msi0: msi at 18012000 {
+			compatible = "brcm,iproc-msi";
+			msi-controller;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 127 IRQ_TYPE_NONE>,
+				     <GIC_SPI 128 IRQ_TYPE_NONE>,
+				     <GIC_SPI 129 IRQ_TYPE_NONE>,
+				     <GIC_SPI 130 IRQ_TYPE_NONE>;
+			brcm,pcie-msi-inten;
+		};
 	};
 
 	pcie1: pcie at 18013000 {
@@ -314,6 +326,18 @@
 		ranges = <0x82000000 0 0x40000000 0x40000000 0 0x8000000>;
 
 		status = "disabled";
+
+		msi-parent = <&msi1>;
+		msi1: msi at 18013000 {
+			compatible = "brcm,iproc-msi";
+			msi-controller;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 133 IRQ_TYPE_NONE>,
+				     <GIC_SPI 134 IRQ_TYPE_NONE>,
+				     <GIC_SPI 135 IRQ_TYPE_NONE>,
+				     <GIC_SPI 136 IRQ_TYPE_NONE>;
+			brcm,pcie-msi-inten;
+		};
 	};
 
 	pcie2: pcie at 18014000 {
@@ -338,5 +362,17 @@
 		ranges = <0x82000000 0 0x48000000 0x48000000 0 0x8000000>;
 
 		status = "disabled";
+
+		msi-parent = <&msi2>;
+		msi2: msi at 18014000 {
+			compatible = "brcm,iproc-msi";
+			msi-controller;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_NONE>,
+				     <GIC_SPI 140 IRQ_TYPE_NONE>,
+				     <GIC_SPI 141 IRQ_TYPE_NONE>,
+				     <GIC_SPI 142 IRQ_TYPE_NONE>;
+			brcm,pcie-msi-inten;
+		};
 	};
 };
-- 
1.9.1
