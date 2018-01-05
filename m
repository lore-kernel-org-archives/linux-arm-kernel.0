From: ran.wang_1@nxp.com (Ran Wang)
Date: Fri, 5 Jan 2018 17:40:07 +0800
Subject: [PATCH 2/4] arm64: dts: ls1043a: Enable usb3-lpm-capable for usb3 node
In-Reply-To: <20180105094009.22599-1-ran.wang_1@nxp.com>
References: <20180105094009.22599-1-ran.wang_1@nxp.com>
Message-ID: <20180105094009.22599-2-ran.wang_1@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable USB3 HW LPM feature for ls1043a and active patch for
snps erratum A-010131. It will disable U1/U2 temperary when
initiate U3 request.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index e4fed04..686c7db 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -698,6 +698,8 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			usb3-lpm-capable;
+			snps,dis-u1u2-when-u3-quirk;
 		};
 
 		usb1: usb3 at 3000000 {
@@ -707,6 +709,8 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			usb3-lpm-capable;
+			snps,dis-u1u2-when-u3-quirk;
 		};
 
 		usb2: usb3 at 3100000 {
@@ -716,6 +720,8 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			usb3-lpm-capable;
+			snps,dis-u1u2-when-u3-quirk;
 		};
 
 		sata: sata at 3200000 {
-- 
1.7.1
