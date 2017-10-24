From: yinbo.zhu@nxp.com (yinbo.zhu at nxp.com)
Date: Tue, 24 Oct 2017 17:31:18 +0800
Subject: [PATCH v3] arm64: dts: ls1088a: Add USB support
Message-ID: <20171024093118.31238-1-yinbo.zhu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "yinbo.zhu" <yinbo.zhu@nxp.com>

Fix the issue that usb is not detected on ls1088ardb

Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---

Change in v3:
		- Change status from "enable" to "disabled" then enable it on dts file. 
		- Add the version history.

 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts |  8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi    | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
index 213abb72de93..6c3c3bc4b681 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
@@ -118,6 +118,14 @@
 	status = "okay";
 };
 
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
+
 &esdhc {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index c144d06a6e33..c23fede8cf5d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -359,6 +359,26 @@
 			status = "disabled";
 		};
 
+		usb0: usb3 at 3100000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0x3100000 0x0 0x10000>;
+			interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode = "host";
+			snps,quirk-frame-length-adjustment = <0x20>;
+			snps,dis_rxdet_inp3_quirk;
+			status = "disabled";
+		};
+
+		usb1: usb3 at 3110000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0x3110000 0x0 0x10000>;
+			interrupts = <0 81 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode = "host";
+			snps,quirk-frame-length-adjustment = <0x20>;
+			snps,dis_rxdet_inp3_quirk;
+			status = "disabled";
+		};
+
 		sata: sata at 3200000 {
 			compatible = "fsl,ls1088a-ahci";
 			reg = <0x0 0x3200000 0x0 0x10000>,
-- 
2.14.1
