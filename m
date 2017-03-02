From: akurz@blala.de (Alexander Kurz)
Date: Thu,  2 Mar 2017 22:03:48 +0100
Subject: [PATCH v2] ARM: dts: imx50: imx50-esdhc use imx53-esdhc
Message-ID: <1488488628-11711-1-git-send-email-akurz@blala.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the reference manuals, both imx50/imx53 SOC seem to share
the same eSDHC controller, especially the section on "Multi-block Read"
mentioned in commit 361b8482026c ("mmc: sdhci-esdhc-imx: fix multiblock
reads on i.MX53") is identical for both SOC.
Hence, let imx50 use imx53-esdhc.

Signed-off-by: Alexander Kurz <akurz@blala.de>
---
 arch/arm/boot/dts/imx50.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index ceae909..2a98afc 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -109,7 +109,7 @@
 				ranges;
 
 				esdhc1: esdhc at 50004000 {
-					compatible = "fsl,imx50-esdhc";
+					compatible = "fsl,imx50-esdhc", "fsl,imx53-esdhc";
 					reg = <0x50004000 0x4000>;
 					interrupts = <1>;
 					clocks = <&clks IMX5_CLK_ESDHC1_IPG_GATE>,
@@ -121,7 +121,7 @@
 				};
 
 				esdhc2: esdhc at 50008000 {
-					compatible = "fsl,imx50-esdhc";
+					compatible = "fsl,imx50-esdhc", "fsl,imx53-esdhc";
 					reg = <0x50008000 0x4000>;
 					interrupts = <2>;
 					clocks = <&clks IMX5_CLK_ESDHC2_IPG_GATE>,
@@ -170,7 +170,7 @@
 				};
 
 				esdhc3: esdhc at 50020000 {
-					compatible = "fsl,imx50-esdhc";
+					compatible = "fsl,imx50-esdhc", "fsl,imx53-esdhc";
 					reg = <0x50020000 0x4000>;
 					interrupts = <3>;
 					clocks = <&clks IMX5_CLK_ESDHC3_IPG_GATE>,
@@ -182,7 +182,7 @@
 				};
 
 				esdhc4: esdhc at 50024000 {
-					compatible = "fsl,imx50-esdhc";
+					compatible = "fsl,imx50-esdhc", "fsl,imx53-esdhc";
 					reg = <0x50024000 0x4000>;
 					interrupts = <4>;
 					clocks = <&clks IMX5_CLK_ESDHC4_IPG_GATE>,
-- 
2.1.4
