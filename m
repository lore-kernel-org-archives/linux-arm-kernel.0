From: pengbo.mu@nxp.com (Pengbo Mu)
Date: Mon, 23 Jul 2018 18:32:39 +0800
Subject: [PATCH v6 4/4] arm: arm64: dts: add property snps incr burst type
 adjustment
In-Reply-To: <1532341959-3478-1-git-send-email-pengbo.mu@nxp.com>
References: <1532341959-3478-1-git-send-email-pengbo.mu@nxp.com>
Message-ID: <1532341959-3478-4-git-send-email-pengbo.mu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Property "snps,incr-burst-type-adjustment = <x>, <y>..." for USB3.0
DWC3.When only one value means INCRx mode with fix burst type.
When more than one value, means undefined length burst mode, USB
controller can use the length less than or equal to the largest
enabled burst length.

While enabling undefined length INCR burst type and INCR16 burst type,
get better write performance on NXP Layerscape platforms: around 3%
improvement (from 364MB/s to 375MB/s).

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Signed-off-by: Pengbo Mu <pengbo.mu@nxp.com>
---
Changes in v6:
 - delete snps,incr-burst-type-adjustment = <1>
Changes in v5:
 - add support for ls1021a, ls1012a, ls1046a, ls1088a, ls1021a
 - update ls208xa support according to code base change
Changes in v4:
 - change definition for this property.
Changes in v3:
 - add new property for INCR burst in usb node.
---
 arch/arm/boot/dts/ls1021a.dtsi                 | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 2 ++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 2 ++
 6 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c55d479..7c328f3 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -706,6 +706,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		pcie at 3400000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 205f0f4..8e3d66f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -482,6 +482,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		sata: sata at 3200000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 1109f22..f826d20 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -643,6 +643,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb1: usb3 at 3000000 {
@@ -652,6 +653,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb2: usb3 at 3100000 {
@@ -661,6 +663,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		sata: sata at 3200000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 136ebfa..9226be8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -604,6 +604,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb1: usb at 3000000 {
@@ -613,6 +614,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb2: usb at 3100000 {
@@ -622,6 +624,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		sata: sata at 3200000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 1c6556b..34671ee0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -479,6 +479,7 @@
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 			status = "disabled";
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb1: usb3 at 3110000 {
@@ -489,6 +490,7 @@
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 			status = "disabled";
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		sata: sata at 3200000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 137ef4d..c0762cc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -754,6 +754,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb1: usb3 at 3110000 {
@@ -764,6 +765,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		ccn at 4000000 {
-- 
2.7.4
