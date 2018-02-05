From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  5 Feb 2018 16:45:37 -0200
Subject: [PATCH 6/7] arm64: dts: ls208xa-qds: Pass unit name to dspi child
 nodes
In-Reply-To: <1517856338-28289-1-git-send-email-festevam@gmail.com>
References: <1517856338-28289-1-git-send-email-festevam@gmail.com>
Message-ID: <1517856338-28289-6-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Pass unit name to dspi child nodes to fix the following build warnings
with W=1:

arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: Warning (unit_address_vs_reg): Node /soc/dspi at 2100000/n25q128a has a reg or ranges property, but no unit name
arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: Warning (unit_address_vs_reg): Node /soc/dspi at 2100000/sst25wf040b has a reg or ranges property, but no unit name
arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: Warning (unit_address_vs_reg): Node /soc/dspi at 2100000/en25s64 has a reg or ranges property, but no unit name

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
index b237446..a1a5ccb 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
@@ -140,21 +140,21 @@
 
 &dspi {
 	status = "okay";
-	dflash0: n25q128a {
+	dflash0: n25q128a at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "st,m25p80";
 		spi-max-frequency = <3000000>;
 		reg = <0>;
 	};
-	dflash1: sst25wf040b {
+	dflash1: sst25wf040b at 1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "st,m25p80";
 		spi-max-frequency = <3000000>;
 		reg = <1>;
 	};
-	dflash2: en25s64 {
+	dflash2: en25s64 at 2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "st,m25p80";
-- 
2.7.4
