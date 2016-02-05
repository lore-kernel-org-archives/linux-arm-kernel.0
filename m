From: jonmason@broadcom.com (Jon Mason)
Date: Fri,  5 Feb 2016 17:43:20 -0500
Subject: [PATCH 1/5] ARM: dts: NSP: Fix PCIE DT issue
In-Reply-To: <1454712204-30419-1-git-send-email-jonmason@broadcom.com>
References: <1454712204-30419-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1454712204-30419-2-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the ranges value is preventing the PCI nodes from working.
Pulling them out outside makes them work again (and makes it similar to
the NS2 device tree).

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 144 ++++++++++++++++++++---------------------
 1 file changed, 72 insertions(+), 72 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 10bdef5..c5b0c09c 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -185,78 +185,6 @@
 			status = "disabled";
 		};
 
-		pcie0: pcie at 12000 {
-			compatible = "brcm,iproc-pcie";
-			reg = <0x12000 0x1000>;
-
-			#interrupt-cells = <1>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &gic GIC_SPI 131 IRQ_TYPE_NONE>;
-
-			linux,pci-domain = <0>;
-
-			bus-range = <0x00 0xff>;
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-			device_type = "pci";
-
-			/* Note: The HW does not support I/O resources.  So,
-			 * only the memory resource range is being specified.
-			 */
-			ranges = <0x82000000 0 0x08000000 0x08000000 0 0x8000000>;
-
-			status = "disabled";
-		};
-
-		pcie1: pcie at 13000 {
-			compatible = "brcm,iproc-pcie";
-			reg = <0x13000 0x1000>;
-
-			#interrupt-cells = <1>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &gic GIC_SPI 137 IRQ_TYPE_NONE>;
-
-			linux,pci-domain = <1>;
-
-			bus-range = <0x00 0xff>;
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-			device_type = "pci";
-
-			/* Note: The HW does not support I/O resources.  So,
-			 * only the memory resource range is being specified.
-			 */
-			ranges = <0x82000000 0 0x40000000 0x40000000 0 0x8000000>;
-
-			status = "disabled";
-		};
-
-		pcie2: pcie at 14000 {
-			compatible = "brcm,iproc-pcie";
-			reg = <0x14000 0x1000>;
-
-			#interrupt-cells = <1>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &gic GIC_SPI 143 IRQ_TYPE_NONE>;
-
-			linux,pci-domain = <2>;
-
-			bus-range = <0x00 0xff>;
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-			device_type = "pci";
-
-			/* Note: The HW does not support I/O resources.  So,
-			 * only the memory resource range is being specified.
-			 */
-			ranges = <0x82000000 0 0x48000000 0x48000000 0 0x8000000>;
-
-			status = "disabled";
-		};
-
 		nand: nand at 26000 {
 			compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1";
 			reg = <0x026000 0x600>,
@@ -306,4 +234,76 @@
 			      <0x3f408 0x04>;
 		};
 	};
+
+	pcie0: pcie at 18012000 {
+		compatible = "brcm,iproc-pcie";
+		reg = <0x18012000 0x1000>;
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 131 IRQ_TYPE_NONE>;
+
+		linux,pci-domain = <0>;
+
+		bus-range = <0x00 0xff>;
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+
+		/* Note: The HW does not support I/O resources.  So,
+		 * only the memory resource range is being specified.
+		 */
+		ranges = <0x82000000 0 0x08000000 0x08000000 0 0x8000000>;
+
+		status = "disabled";
+	};
+
+	pcie1: pcie at 18013000 {
+		compatible = "brcm,iproc-pcie";
+		reg = <0x18013000 0x1000>;
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 137 IRQ_TYPE_NONE>;
+
+		linux,pci-domain = <1>;
+
+		bus-range = <0x00 0xff>;
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+
+		/* Note: The HW does not support I/O resources.  So,
+		 * only the memory resource range is being specified.
+		 */
+		ranges = <0x82000000 0 0x40000000 0x40000000 0 0x8000000>;
+
+		status = "disabled";
+	};
+
+	pcie2: pcie at 18014000 {
+		compatible = "brcm,iproc-pcie";
+		reg = <0x18014000 0x1000>;
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 143 IRQ_TYPE_NONE>;
+
+		linux,pci-domain = <2>;
+
+		bus-range = <0x00 0xff>;
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+
+		/* Note: The HW does not support I/O resources.  So,
+		 * only the memory resource range is being specified.
+		 */
+		ranges = <0x82000000 0 0x48000000 0x48000000 0 0x8000000>;
+
+		status = "disabled";
+	};
 };
-- 
1.9.1
