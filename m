From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 23 Jul 2013 15:38:26 +0800
Subject: [PATCH] ARM: dts: imx: ocram size is different between imx6q and
 imx6dl
Message-ID: <1374565107-9658-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ocram on imx6q is 256 KiB while on imx6dl it's 128 KiB.  Let's
have separate node for imx6q and imx6dl.  It also changes imx6q size
0x3f000 to 0x40000 to match the hardware.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6dl.dtsi  |    6 ++++++
 arch/arm/boot/dts/imx6q.dtsi   |    6 ++++++
 arch/arm/boot/dts/imx6qdl.dtsi |    6 ------
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index e9cb589..9e8ae11 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -32,6 +32,12 @@
 	};
 
 	soc {
+		ocram: sram at 00900000 {
+			compatible = "mmio-sram";
+			reg = <0x00900000 0x20000>;
+			clocks = <&clks 142>;
+		};
+
 		aips1: aips-bus at 02000000 {
 			iomuxc: iomuxc at 020e0000 {
 				compatible = "fsl,imx6dl-iomuxc";
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 76a84e8..f024ef2 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -61,6 +61,12 @@
 	};
 
 	soc {
+		ocram: sram at 00900000 {
+			compatible = "mmio-sram";
+			reg = <0x00900000 0x40000>;
+			clocks = <&clks 142>;
+		};
+
 		aips-bus at 02000000 { /* AIPS1 */
 			spba-bus at 02000000 {
 				ecspi5: ecspi at 02018000 {
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index bc4ca03..ccd55c2 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -99,12 +99,6 @@
 			status = "disabled";
 		};
 
-		ocram: sram at 00900000 {
-			compatible = "mmio-sram";
-			reg = <0x00900000 0x3f000>;
-			clocks = <&clks 142>;
-		};
-
 		timer at 00a00600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x00a00600 0x20>;
-- 
1.7.9.5
