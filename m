From: yinbo.zhu@nxp.com (yinbo.zhu at nxp.com)
Date: Fri, 22 Dec 2017 16:38:07 +0800
Subject: [PATCH v5] arm64: dts: ls1088a: Add USB support
Message-ID: <20171222083807.5660-1-yinbo.zhu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: yinbo.zhu <yinbo.zhu@nxp.com>

Add USB support on ls1088ardb

Signed-off-by: yinbo zhu <yinbo.zhu@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Change in v5:
                The usb node was sorted alphabetically in label name.
		Remove the point in "yinbo.zhu".	

 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts |    8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi    |   20 ++++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
index 0f6fcda..4f17601 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
@@ -125,3 +125,11 @@
 &sata {
 	status = "okay";
 };
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index bd80e9a..caf2bdd 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -394,6 +394,26 @@
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
1.7.1
