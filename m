From: robh@kernel.org (Rob Herring)
Date: Tue, 21 Mar 2017 21:03:03 -0500
Subject: [PATCH 05/15] ARM: dts: imx: fix PCI bus dtc warnings
In-Reply-To: <20170322020313.24338-1-robh@kernel.org>
References: <20170322020313.24338-1-robh@kernel.org>
Message-ID: <20170322020313.24338-5-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc recently added PCI bus checks. Fix these warnings.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
---
Sub-arch maintainers, please apply to your trees unless arm-soc wants 
to take the whole lot.

 arch/arm/boot/dts/imx6qdl.dtsi | 3 ++-
 arch/arm/boot/dts/imx6qp.dtsi  | 2 +-
 arch/arm/boot/dts/imx6sx.dtsi  | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 6d7bf6496117..f95e24e73252 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -197,7 +197,7 @@
 			arm,shared-override;
 		};
 
-		pcie: pcie at 0x01000000 {
+		pcie: pcie at 1ffc000 {
 			compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
 			reg = <0x01ffc000 0x04000>,
 			      <0x01f00000 0x80000>;
@@ -205,6 +205,7 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
+			bus-range = <0 0xff>;
 			ranges = <0x81000000 0 0          0x01f80000 0 0x00010000 /* downstream I/O */
 				  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
diff --git a/arch/arm/boot/dts/imx6qp.dtsi b/arch/arm/boot/dts/imx6qp.dtsi
index 24d071f5d9cd..b7688f1e3c86 100644
--- a/arch/arm/boot/dts/imx6qp.dtsi
+++ b/arch/arm/boot/dts/imx6qp.dtsi
@@ -82,7 +82,7 @@
 				      "ldb_di0", "ldb_di1", "prg";
 		};
 
-		pcie: pcie at 0x01000000 {
+		pcie: pcie at 1ffc000 {
 			compatible = "fsl,imx6qp-pcie", "snps,dw-pcie";
 		};
 
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index dd4ec85ecbaa..c7f76de57c7b 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -1281,7 +1281,7 @@
 			};
 		};
 
-		pcie: pcie at 0x08000000 {
+		pcie: pcie at 8ffc000 {
 			compatible = "fsl,imx6sx-pcie", "snps,dw-pcie";
 			reg = <0x08ffc000 0x4000>; /* DBI */
 			#address-cells = <3>;
@@ -1293,6 +1293,7 @@
 				  0x81000000 0 0          0x08f80000 0 0x00010000
 				  /* non-prefetchable memory */
 				  0x82000000 0 0x08000000 0x08000000 0 0x00f00000>;
+			bus-range = <0x00 0xff>;
 			num-lanes = <1>;
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clks IMX6SX_CLK_PCIE_REF_125M>,
-- 
2.10.1
