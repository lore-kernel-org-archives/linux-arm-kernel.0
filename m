From: jon.mason@broadcom.com (Jon Mason)
Date: Tue, 25 Jul 2017 18:06:10 -0400
Subject: [PATCH 1/3] ARM: dts: NSP: Add dma-coherent to relevant DT entries
In-Reply-To: <1501020372-19607-1-git-send-email-jon.mason@broadcom.com>
References: <1501020372-19607-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1501020372-19607-2-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cache related issues with DMA rings and performance issues related to
caching are being caused by not properly setting the "dma-coherent" flag
in the device tree entries.  Adding it here to correct the issue.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
Fixes: 5fa1026a3e4d ("ARM: dts: NSP: Add PL330 support")
Fixes: 3107fa5bcfb2 ("ARM: dts: NSP: Add SD/MMC support")
Fixes: 13d04f20935c ("ARM: dts: NSP: Add AMAC entries")
Fixes: 5aeda7bf8a1e ("ARM: dts: NSP: Add and enable amac2")
Fixes: 17d517172300 ("ARM: dts: NSP: Add mailbox (PDC) to NSP")
Fixes: 1d8ece6639e1 ("ARM: dts: NSP: Add EHCI/OHCI USB nodes to device tree")
Fixes: bf2289bedef4 ("ARM: dts: NSP: Add Switch Register Access Block node")
Fixes: 0f9f27a36d09 ("ARM: dts: NSP: Add I2C support to the DT")
Fixes: 8dbcad020f2e ("ARM: dts: nsp: Add sata device tree entry")
Fixes: 522199029fdc ("ARM: dts: NSP: Fix PCIE DT issue")
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 7204d1def23d..c8d734d9f5fc 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -207,6 +207,7 @@
 			clocks = <&iprocslow>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
+			dma-coherent;
 		};
 
 		sdio: sdhci at 21000 {
@@ -215,6 +216,7 @@
 			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 			sdhci,auto-cmd12;
 			clocks = <&lcpll0 BCM_NSP_LCPLL0_SDIO_CLK>;
+			dma-coherent;
 			status = "disabled";
 		};
 
@@ -224,6 +226,7 @@
 			      <0x110000 0x1000>;
 			reg-names = "amac_base", "idm_base";
 			interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
 			status = "disabled";
 		};
 
@@ -233,6 +236,7 @@
 			      <0x111000 0x1000>;
 			reg-names = "amac_base", "idm_base";
 			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
 			status = "disabled";
 		};
 
@@ -242,6 +246,7 @@
 			      <0x112000 0x1000>;
 			reg-names = "amac_base", "idm_base";
 			interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
 			status = "disabled";
 		};
 
@@ -252,6 +257,7 @@
 			#mbox-cells = <1>;
 			brcm,rx-status-len = <32>;
 			brcm,use-bcm-hdr;
+			dma-coherent;
 		};
 
 		nand: nand at 26000 {
@@ -325,6 +331,7 @@
 			compatible = "generic-ehci";
 			reg = <0x2a000 0x100>;
 			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
 			status = "disabled";
 		};
 
@@ -332,6 +339,7 @@
 			compatible = "generic-ohci";
 			reg = <0x2b000 0x100>;
 			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
 			status = "disabled";
 		};
 
@@ -364,6 +372,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
+			dma-coherent;
 			status = "disabled";
 
 			/* ports are defined in board DTS */
@@ -376,6 +385,7 @@
 			#size-cells = <0>;
 			interrupts = <GIC_SPI 89 IRQ_TYPE_NONE>;
 			clock-frequency = <100000>;
+			dma-coherent;
 			status = "disabled";
 		};
 
@@ -446,6 +456,7 @@
 			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			dma-coherent;
 			status = "disabled";
 
 			sata0: sata-port at 0 {
@@ -483,6 +494,7 @@
 		 */
 		ranges = <0x82000000 0 0x08000000 0x08000000 0 0x8000000>;
 
+		dma-coherent;
 		status = "disabled";
 
 		msi-parent = <&msi0>;
@@ -519,6 +531,7 @@
 		 */
 		ranges = <0x82000000 0 0x40000000 0x40000000 0 0x8000000>;
 
+		dma-coherent;
 		status = "disabled";
 
 		msi-parent = <&msi1>;
@@ -555,6 +568,7 @@
 		 */
 		ranges = <0x82000000 0 0x48000000 0x48000000 0 0x8000000>;
 
+		dma-coherent;
 		status = "disabled";
 
 		msi-parent = <&msi2>;
-- 
2.7.4
