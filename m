From: po.liu@nxp.com (Po Liu)
Date: Tue, 13 Sep 2016 12:40:57 +0800
Subject: [PATCH v5 1/3] arm/dts: add pcie aer interrupt-name property in the
 dts
In-Reply-To: <1472625442-23309-2-git-send-email-po.liu@nxp.com>
References: <1472625442-23309-2-git-send-email-po.liu@nxp.com>
Message-ID: <1473741659-17618-1-git-send-email-po.liu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NXP arm aer interrupt was not MSI/MSI-X/INTx but using interrupt
line independently. This patch add a "aer" interrupt-names for
aer interrupt.

With the interrupt-names "aer", code could probe aer interrupt line
for pcie root port, replace the aer interrupt service irq.

This patch is intend to fixup the Layerscape platforms which aer
interrupt was not MSI/MSI-X/INTx, but using interrupt line independently.

Signed-off-by: Po Liu <po.liu@nxp.com>
---
changes for v5:
	- Seperate arm arm64 dts changes

 arch/arm/boot/dts/ls1021a.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 368e219..443e50b 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -634,7 +634,8 @@
 			reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
+			interrupt-names = "aer";
 			fsl,pcie-scfg = <&scfg 0>;
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -657,7 +658,8 @@
 			reg = <0x00 0x03500000 0x0 0x00010000   /* controller registers */
 			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
+			interrupt-names = "aer";
 			fsl,pcie-scfg = <&scfg 1>;
 			#address-cells = <3>;
 			#size-cells = <2>;
-- 
2.1.0.27.g96db324
