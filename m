From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Thu, 27 Apr 2017 13:31:50 +0800
Subject: [PATCH] arm64: dts: ls1088a: add esdhc node
Message-ID: <1493271110-6361-1-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add esdhc node for ls1088a and enable it on both RDB and QDS boards.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts |  4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts |  4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi    | 12 ++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
index 8c3cae5..466c91b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
@@ -121,3 +121,7 @@
 &sata {
 	status = "okay";
 };
+
+&esdhc {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
index 8a04fbb..130cc3b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
@@ -105,3 +105,7 @@
 &sata {
 	status = "okay";
 };
+
+&esdhc {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 2946fd7..ef62aca 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -223,6 +223,18 @@
 			status = "disabled";
 		};
 
+		esdhc: esdhc at 2140000 {
+			compatible = "fsl,ls1088a-esdhc", "fsl,esdhc";
+			reg = <0x0 0x2140000 0x0 0x10000>;
+			interrupts = <0 28 0x4>; /* Level high type */
+			clock-frequency = <0>;
+			voltage-ranges = <1800 1800 3300 3300>;
+			sdhci,auto-cmd12;
+			little-endian;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
 		i2c0: i2c at 2000000 {
 			compatible = "fsl,vf610-i2c";
 			#address-cells = <1>;
-- 
2.1.0.27.g96db324
