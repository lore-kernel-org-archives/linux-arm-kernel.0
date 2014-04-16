From: leigh@solinno.co.uk (Leigh Brown)
Date: Wed, 16 Apr 2014 12:26:35 +0100
Subject: [PATCH RFC] ARM: dts: am335x: update USB DT references
Message-ID: <1397647595-10927-1-git-send-email-leigh@solinno.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In "ARM: dts: am33xx: correcting dt node unit address for usb", the
usb_ctrl_mod and cppi41dma nodes were updated with the correct register
addresses.  However, the dts files that reference these nodes were not
updated, and those devices are no longer being enabled.

This patch corrects the references for the affected dts files.

Signed-off-by: Leigh Brown <leigh@solinno.co.uk>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 4 ++--
 arch/arm/boot/dts/am335x-evm.dts          | 4 ++--
 arch/arm/boot/dts/am335x-evmsk.dts        | 4 ++--
 arch/arm/boot/dts/am335x-igep0033.dtsi    | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index e3f27ec..2e7d932 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -183,7 +183,7 @@
 &usb {
 	status = "okay";
 
-	control at 44e10000 {
+	control at 44e10620 {
 		status = "okay";
 	};
 
@@ -204,7 +204,7 @@
 		dr_mode = "host";
 	};
 
-	dma-controller at 07402000  {
+	dma-controller at 47402000  {
 		status = "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 28ae040..77df10d 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -331,7 +331,7 @@
 &usb {
 	status = "okay";
 
-	control at 44e10000 {
+	control at 44e10620 {
 		status = "okay";
 	};
 
@@ -352,7 +352,7 @@
 		dr_mode = "host";
 	};
 
-	dma-controller at 07402000  {
+	dma-controller at 47402000  {
 		status = "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index ec08f6f..ab23885 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -364,7 +364,7 @@
 &usb {
 	status = "okay";
 
-	control at 44e10000 {
+	control at 44e10620 {
 		status = "okay";
 	};
 
@@ -385,7 +385,7 @@
 		dr_mode = "host";
 	};
 
-	dma-controller at 07402000  {
+	dma-controller at 47402000  {
 		status = "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
index 7063311..5942e7d 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -202,7 +202,7 @@
 &usb {
 	status = "okay";
 
-	control at 44e10000 {
+	control at 44e10620 {
 		status = "okay";
 	};
 
@@ -223,7 +223,7 @@
 		dr_mode = "host";
 	};
 
-	dma-controller at 07402000  {
+	dma-controller at 47402000  {
 		status = "okay";
 	};
 };
-- 
1.9.1
