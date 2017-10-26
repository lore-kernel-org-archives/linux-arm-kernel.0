From: yinbo.zhu@nxp.com (yinbo.zhu at nxp.com)
Date: Thu, 26 Oct 2017 10:05:52 +0800
Subject: [PATCH v4] arm64: dts: ls1088a: Add USB support
Message-ID: <20171026020552.42153-1-yinbo.zhu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "yinbo.zhu" <yinbo.zhu@nxp.com>

Add USB support on ls1088ardb

Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Change in v4:
                - Change status from "enable" to "disabled" then enable it on dts file.
                - Add the version history.
		- Update the subject.

 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts |  8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi    | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
index 0f6fcda36b9e..a84b49ec76ec 100644
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
index 33797b373674..64968def0890 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -385,6 +385,26 @@
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
