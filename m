From: po.liu@nxp.com (Po Liu)
Date: Fri, 30 Sep 2016 17:11:35 +0800
Subject: [PATCH v6 1/3] arm/dts-ls1021: add pcie aer/pme interrupt-name
 property in the dts
In-Reply-To: <1473741659-17618-3-git-send-email-po.liu@nxp.com>
References: <1473741659-17618-3-git-send-email-po.liu@nxp.com>
Message-ID: <1475226697-7709-1-git-send-email-po.liu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NXP arm aer/pme interrupts was not MSI/MSI-X/INTx but using interrupt
line independently. This patch add a "aer" "pme" interrupt-names for
aer/pme interrupts.

With the interrupt-names "aer","pme" code could probe aer/pme interrupt
line for pcie root port, replace the aer/pme interrupt service irqs.

This patch is intend to fixup the Layerscape platforms which aer/pme
interrupt was not MSI/MSI-X/INTx, but using interrupt line independently.

Since the interrupt-names "intr" never been used. Remove it.

Signed-off-by: Po Liu <po.liu@nxp.com>
---
changes for v6:
	- add remove "intr" reason;
	- add "pme" interrupt;

 arch/arm/boot/dts/ls1021a.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 368e219..9b3cb3b 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -634,7 +634,9 @@
 			reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
+			interrupt-names = "pme", "aer";
 			fsl,pcie-scfg = <&scfg 0>;
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -657,7 +659,9 @@
 			reg = <0x00 0x03500000 0x0 0x00010000   /* controller registers */
 			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
+			interrupt-names = "pme", "aer";
 			fsl,pcie-scfg = <&scfg 1>;
 			#address-cells = <3>;
 			#size-cells = <2>;
-- 
2.1.0.27.g96db324
