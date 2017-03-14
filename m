From: andy.tang@nxp.com (Yuantian Tang)
Date: Tue, 14 Mar 2017 10:29:34 +0800
Subject: [PATCH] arm64: dts: updated sata node on ls1012a platform
Message-ID: <1489458574-5556-1-git-send-email-andy.tang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Updated sata node to add ecc register address and dma coherence
property.
Enable sata on ls1012a platforms as well.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts  | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts  | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     | 5 ++++-
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
index a619f64..17fae81 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
@@ -113,3 +113,7 @@
 &sai2 {
 	status = "okay";
 };
+
+&sata {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
index 14a67f1..e2a93d5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
@@ -126,3 +126,7 @@
 &sai2 {
 	status = "okay";
 };
+
+&sata {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
index 62c5c71..ed77f6b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
@@ -57,3 +57,7 @@
 &i2c0 {
 	status = "okay";
 };
+
+&sata {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index d9d9b0f..65939bd 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -314,9 +314,12 @@
 
 		sata: sata at 3200000 {
 			compatible = "fsl,ls1012a-ahci", "fsl,ls1043a-ahci";
-			reg = <0x0 0x3200000 0x0 0x10000>;
+			reg = <0x0 0x3200000 0x0 0x10000>,
+				<0x0 0x20140520 0x0 0x4>;
+			reg-names = "ahci", "sata-ecc";
 			interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 0>;
+			dma-coherent;
 			status = "disabled";
 		};
 	};
-- 
2.1.0.27.g96db324
