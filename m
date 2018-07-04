From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  4 Jul 2018 14:52:50 -0300
Subject: [PATCH] ARM: dts: imx: Remove optional 'fsl,sec-era' property
Message-ID: <1530726770-814-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Since commit 654f2b937b38 ("crypto: caam - allow retrieving 'era' from
register") the CAAM driver is capable of obtaining the era version by
reading the appropriate CAAM registers, so let the CAAM driver discover
the era version in run-time instead of hardcoding such information in the
device tree.

According to Documentation/devicetree/bindings/crypto/fsl-sec4.txt the
'fsl,sec-era' is an optional property and this can be safely removed
now.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 1 -
 arch/arm/boot/dts/imx6sx.dtsi  | 1 -
 arch/arm/boot/dts/imx7s.dtsi   | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 911141e..61d2d26 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -922,7 +922,6 @@
 
 			crypto: caam at 2100000 {
 				compatible = "fsl,sec-v4.0";
-				fsl,sec-era = <4>;
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <0x2100000 0x10000>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index c8970bf..ddbde46 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -815,7 +815,6 @@
 
 			crypto: caam at 2100000 {
 				compatible = "fsl,sec-v4.0";
-				fsl,sec-era = <4>;
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <0x2100000 0x10000>;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 9ced589..a052198 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -842,7 +842,6 @@
 
 			crypto: caam at 30900000 {
 				compatible = "fsl,sec-v4.0";
-				fsl,sec-era = <8>;
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <0x30900000 0x40000>;
-- 
2.7.4
