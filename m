From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Fri, 21 Apr 2017 11:52:36 +0800
Subject: [PATCH 3/3] arm64: dts: ls1012a: add eSDHC nodes
In-Reply-To: <1492746756-12024-1-git-send-email-yangbo.lu@nxp.com>
References: <1492746756-12024-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <1492746756-12024-4-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two eSDHC controllers in LS1012A. This patch is to add
eSDHC nodes for ls1012a dts. Also enable eSDHC for RDB/QDS boards.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts |  8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts | 13 ++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi    | 25 +++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
index e2a93d5..a21a587 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
@@ -130,3 +130,11 @@
 &sata {
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
index ed77f6b..57669b0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
@@ -61,3 +61,16 @@
 &sata {
 	status = "okay";
 };
+
+&esdhc0 {
+	sd-uhs-sdr104;
+	sd-uhs-sdr50;
+	sd-uhs-sdr25;
+	sd-uhs-sdr12;
+	status = "okay";
+};
+
+&esdhc1 {
+	mmc-hs200-1_8v;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index b497ac1..e3a1943 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -302,6 +302,31 @@
 			};
 		};
 
+		esdhc0: esdhc at 1560000 {
+			compatible = "fsl,ls1012a-esdhc", "fsl,esdhc";
+			reg = <0x0 0x1560000 0x0 0x10000>;
+			interrupts = <0 62 0x4>;
+			clocks = <&clockgen 4 0>;
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
+			clocks = <&clockgen 4 0>;
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
