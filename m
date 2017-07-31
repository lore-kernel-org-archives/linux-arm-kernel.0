From: jon.mason@broadcom.com (Jon Mason)
Date: Mon, 31 Jul 2017 17:54:21 -0400
Subject: [PATCH v2 1/3] ARM: dts: NSP: Add dma-coherent to relevant DT entries
In-Reply-To: <1501538063-32662-1-git-send-email-jon.mason@broadcom.com>
References: <1501538063-32662-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1501538063-32662-2-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cache related issues with DMA rings and performance issues related to
caching are being caused by not properly setting the "dma-coherent" flag
in the device tree entries.  Adding it here to correct the issue.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
Fixes: 3107fa5bcfb2 ("ARM: dts: NSP: Add SD/MMC support")
Fixes: 13d04f20935c ("ARM: dts: NSP: Add AMAC entries")
Fixes: 5aeda7bf8a1e ("ARM: dts: NSP: Add and enable amac2")
Fixes: 17d517172300 ("ARM: dts: NSP: Add mailbox (PDC) to NSP")
Fixes: 1d8ece6639e1 ("ARM: dts: NSP: Add EHCI/OHCI USB nodes to device tree")
Fixes: 0f9f27a36d09 ("ARM: dts: NSP: Add I2C support to the DT")
Fixes: 8dbcad020f2e ("ARM: dts: nsp: Add sata device tree entry")
Fixes: 522199029fdc ("ARM: dts: NSP: Fix PCIE DT issue")
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 7204d1def23d..c82313a677d9 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -215,6 +215,7 @@
 			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 			sdhci,auto-cmd12;
 			clocks = <&lcpll0 BCM_NSP_LCPLL0_SDIO_CLK>;
+			dma-coherent;
 			status = "disabled";
 		};
 
@@ -224,6 +225,7 @@
 			      <0x110000 0x1000>;
 			reg-names = "amac_base", "idm_base";
 			interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
 			status = "disabled";
 		};
 
@@ -233,6 +235,7 @@
 			      <0x111000 0x1000>;
 			reg-names = "amac_base", "idm_base";
 			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
 			status = "disabled";
 		};
 
@@ -242,6 +245,7 @@
 			      <0x112000 0x1000>;
 			reg-names = "amac_base", "idm_base";
 			interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
 			status = "disabled";
 		};
 
@@ -252,6 +256,7 @@
 			#mbox-cells = <1>;
 			brcm,rx-status-len = <32>;
 			brcm,use-bcm-hdr;
+			dma-coherent;
 		};
 
 		nand: nand at 26000 {
@@ -325,6 +330,7 @@
 			compatible = "generic-ehci";
 			reg = <0x2a000 0x100>;
 			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
 			status = "disabled";
 		};
 
@@ -332,6 +338,7 @@
 			compatible = "generic-ohci";
 			reg = <0x2b000 0x100>;
 			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
 			status = "disabled";
 		};
 
@@ -376,6 +383,7 @@
 			#size-cells = <0>;
 			interrupts = <GIC_SPI 89 IRQ_TYPE_NONE>;
 			clock-frequency = <100000>;
+			dma-coherent;
 			status = "disabled";
 		};
 
@@ -446,6 +454,7 @@
 			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			dma-coherent;
 			status = "disabled";
 
 			sata0: sata-port at 0 {
@@ -483,6 +492,7 @@
 		 */
 		ranges = <0x82000000 0 0x08000000 0x08000000 0 0x8000000>;
 
+		dma-coherent;
 		status = "disabled";
 
 		msi-parent = <&msi0>;
@@ -519,6 +529,7 @@
 		 */
 		ranges = <0x82000000 0 0x40000000 0x40000000 0 0x8000000>;
 
+		dma-coherent;
 		status = "disabled";
 
 		msi-parent = <&msi1>;
@@ -555,6 +566,7 @@
 		 */
 		ranges = <0x82000000 0 0x48000000 0x48000000 0 0x8000000>;
 
+		dma-coherent;
 		status = "disabled";
 
 		msi-parent = <&msi2>;
-- 
2.7.4
