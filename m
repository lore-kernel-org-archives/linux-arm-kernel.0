From: yinbo.zhu@nxp.com (yinbo.zhu at nxp.com)
Date: Thu, 17 Aug 2017 10:52:38 +0800
Subject: [PATCH] arm64: dts: ls1088a: Add USB support
Message-ID: <1502938358-23522-1-git-send-email-yinbo.zhu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "yinbo.zhu" <yinbo.zhu@nxp.com>

Fix the issue that usb is not detected on ls1088ardb

Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts |  8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi    | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
index e9276a5..949cd67 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
@@ -145,6 +145,14 @@
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
index 3a3be87..0dbff29 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -458,6 +458,24 @@
 			status = "disabled";
 		};
 
+		usb0: usb3 at 3100000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0x3100000 0x0 0x10000>;
+			interrupts = <0 80 0x4>; /* Level high type */
+			dr_mode = "host";
+			configure-gfladj;
+			snps,dis_rxdet_inp3_quirk;
+		};
+
+		usb1: usb3 at 3110000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0x3110000 0x0 0x10000>;
+			interrupts = <0 81 0x4>; /* Level high type */
+			dr_mode = "host";
+			configure-gfladj;
+			snps,dis_rxdet_inp3_quirk;
+		};
+
 		sata: sata at 3200000 {
 			compatible = "fsl,ls1088a-ahci";
 			reg = <0x0 0x3200000 0x0 0x10000>,
-- 
2.1.0.27.g96db324
