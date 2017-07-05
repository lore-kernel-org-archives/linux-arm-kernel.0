From: ran.wang_1@nxp.com (Ran Wang)
Date: Wed, 5 Jul 2017 10:54:03 +0800
Subject: [PATCH] arm64: dts: ls1012a: add USB host controller nodes
Message-ID: <1499223243-13253-1-git-send-email-ran.wang_1@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LS1012A has one USB 3.0(DWC3) controller and
one USB 2.0 controller.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index b497ac1..8aa2dcf 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -411,6 +411,23 @@
 				 <&clockgen 4 3>;
 		};
 
+		usb0: usb3 at 2f00000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0x2f00000 0x0 0x10000>;
+			interrupts = <0 60 0x4>;
+			dr_mode = "host";
+			snps,quirk-frame-length-adjustment = <0x20>;
+			snps,dis_rxdet_inp3_quirk;
+		};
+
+		usb1: usb2 at 8600000 {
+			compatible = "fsl-usb2-dr-v2.5", "fsl-usb2-dr";
+			reg = <0x0 0x8600000 0x0 0x1000>;
+			interrupts = <0 139 0x4>;
+			dr_mode = "host";
+			phy_type = "ulpi";
+		};
+
 		sata: sata at 3200000 {
 			compatible = "fsl,ls1012a-ahci", "fsl,ls1043a-ahci";
 			reg = <0x0 0x3200000 0x0 0x10000>,
-- 
2.1.0.27.g96db324
