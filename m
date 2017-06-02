From: ran.wang_1@nxp.com (Ran Wang)
Date: Fri, 2 Jun 2017 10:30:00 +0800
Subject: [PATCH] arm64: dts: ls1046a: Add dis_rxdet_inp3_quirk property to
 USB3 node
Message-ID: <1496370600-31442-1-git-send-email-ran.wang_1@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "dis_rxdet_inp3_quirk" boolean property to USB3 node. This property
is used to disable rx detection in P3 PHY mode.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index f4b8b7e..9137280 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -567,6 +567,7 @@
 			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
+			snps,dis_rxdet_inp3_quirk;
 		};
 
 		usb1: usb at 3000000 {
@@ -575,6 +576,7 @@
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
+			snps,dis_rxdet_inp3_quirk;
 		};
 
 		usb2: usb at 3100000 {
@@ -583,6 +585,7 @@
 			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
+			snps,dis_rxdet_inp3_quirk;
 		};
 
 		sata: sata at 3200000 {
-- 
2.1.0.27.g96db324
