From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 29 Nov 2017 16:46:15 -0200
Subject: [PATCH 07/11] dtcmx7pci
In-Reply-To: <1511981179-12660-1-git-send-email-festevam@gmail.com>
References: <1511981179-12660-1-git-send-email-festevam@gmail.com>
Message-ID: <1511981179-12660-7-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

arch/arm/boot/dts/imx7d-cl-som-imx7.dtb: Warning (pci_bridge): Node /soc/aips-bus at 30800000/pcie at 0x33800000 missing bus-range for PCI bridge
arch/arm/boot/dts/imx7d-cl-som-imx7.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/imx7d-cl-som-imx7.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/imx7d-cl-som-imx7.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 9d92725..200714e 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -132,7 +132,7 @@
 		status = "disabled";
 	};
 
-	pcie: pcie at 0x33800000 {
+	pcie: pcie at 33800000 {
 		compatible = "fsl,imx7d-pcie", "snps,dw-pcie";
 		reg = <0x33800000 0x4000>,
 		      <0x4ff00000 0x80000>;
@@ -140,6 +140,7 @@
 		#address-cells = <3>;
 		#size-cells = <2>;
 		device_type = "pci";
+		bus-range = <0x00 0xff>;
 		ranges = <0x81000000 0 0          0x4ff80000 0 0x00010000   /* downstream I/O */
 			  0x82000000 0 0x40000000 0x40000000 0 0x0ff00000>; /* non-prefetchable memory */
 		num-lanes = <1>;
-- 
2.7.4
