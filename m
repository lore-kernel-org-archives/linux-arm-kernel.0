From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Thu, 4 May 2017 18:49:00 +0800
Subject: [v2, 5/5] arm64: dts: ls1088a: add esdhc node
In-Reply-To: <1493894940-47452-1-git-send-email-yangbo.lu@nxp.com>
References: <1493894940-47452-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <1493894940-47452-6-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add esdhc node for ls1088a and enable it on both RDB and QDS boards.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- Sorted the node.
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts |  4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts |  4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi    | 12 ++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
index 8c3cae5..ff21055 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
@@ -118,6 +118,10 @@
 	status = "okay";
 };
 
+&esdhc {
+	status = "okay";
+};
+
 &sata {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
index 8a04fbb..ab62ef6 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
@@ -102,6 +102,10 @@
 	status = "okay";
 };
 
+&esdhc {
+	status = "okay";
+};
+
 &sata {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 2946fd7..10b5775 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -263,6 +263,18 @@
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
 		sata: sata at 3200000 {
 			compatible = "fsl,ls1088a-ahci", "fsl,ls1043a-ahci";
 			reg = <0x0 0x3200000 0x0 0x10000>;
-- 
2.1.0.27.g96db324
