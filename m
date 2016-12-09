From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Fri, 9 Dec 2016 14:29:11 +0800
Subject: [PATCH] arm64: ls1012a: dts: add eSDHC nodes
Message-ID: <1481264951-29073-1-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two eSDHC controllers in LS1012A. This patch is to add
eSDHC nodes for ls1012a dts. Also enable eSDHC for RDB/QDS boards.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- Added 'broken-cd' in esdhc2 node
	- Enabled esdhc in board dts
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts |  8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts |  8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi    | 25 +++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
index b841251..cc35114 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
@@ -126,3 +126,11 @@
 &sai2 {
 	status = "okay";
 };
+
+&esdhc0 {
+	status = "okay";
+};
+
+&esdhc1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
index 62c5c71..0eef319 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
@@ -57,3 +57,11 @@
 &i2c0 {
 	status = "okay";
 };
+
+&esdhc0 {
+	status = "okay";
+};
+
+&esdhc1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 24874d7..18310ca 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -128,6 +128,31 @@
 			clocks = <&sysclk>;
 		};
 
+		esdhc0: esdhc at 1560000 {
+			compatible = "fsl,ls1012a-esdhc", "fsl,esdhc";
+			reg = <0x0 0x1560000 0x0 0x10000>;
+			interrupts = <0 62 0x4>;
+			clock-frequency = <0>;
+			voltage-ranges = <1800 1800 3300 3300>;
+			sdhci,auto-cmd12;
+			big-endian;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
+		esdhc1: esdhc at 1580000 {
+			compatible = "fsl,ls1012a-esdhc", "fsl,esdhc";
+			reg = <0x0 0x1580000 0x0 0x10000>;
+			interrupts = <0 65 0x4>;
+			clock-frequency = <0>;
+			voltage-ranges = <1800 1800 3300 3300>;
+			sdhci,auto-cmd12;
+			big-endian;
+			broken-cd;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
 		i2c0: i2c at 2180000 {
 			compatible = "fsl,vf610-i2c";
 			#address-cells = <1>;
-- 
2.1.0.27.g96db324
