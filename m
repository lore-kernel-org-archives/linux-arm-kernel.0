From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu,  7 Aug 2014 19:39:41 +0200
Subject: [PATCH v2] ARM: imx6: add pci config space as platform resource
Message-ID: <1407433181-21960-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes "imx6q-pcie 1ffc000.pcie: missing *config* reg space"
error exposed by new versions of the designware pcie driver.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v2: also fix documentation example
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 4 +++-
 arch/arm/boot/dts/imx6qdl.dtsi                           | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 9455fd0ec830..6fbba53a309b 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -17,7 +17,9 @@ Example:
 
 	pcie at 0x01000000 {
 		compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
-		reg = <0x01ffc000 0x4000>;
+		reg = <0x01ffc000 0x04000>,
+		      <0x01f00000 0x80000>;
+		reg-names = "dbi", "config";
 		#address-cells = <3>;
 		#size-cells = <2>;
 		device_type = "pci";
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index ce0599134a69..6b5da2a98aaf 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -133,7 +133,9 @@
 
 		pcie: pcie at 0x01000000 {
 			compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
-			reg = <0x01ffc000 0x4000>; /* DBI */
+			reg = <0x01ffc000 0x04000>,
+			      <0x01f00000 0x80000>;
+			reg-names = "dbi", "config";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-- 
2.0.1
