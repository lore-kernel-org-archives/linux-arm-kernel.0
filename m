From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 11 Apr 2014 16:04:05 +0800
Subject: [PATCH 2/4] ARM: dts: imx6: define input clocks to CCM block
In-Reply-To: <1397203447-22965-1-git-send-email-shawn.guo@freescale.com>
References: <1397203447-22965-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1397203447-22965-3-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Inspired by commit 1771b10 (clk: respect the clock dependencies in
of_clk_init), we should define the input clocks to CCM block to reflect
the dependencies on those fixed rate clocks.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 8 +++++---
 arch/arm/boot/dts/imx6sl.dtsi  | 6 ++++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 8ee6361..2a35b08 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -57,19 +57,19 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		ckil {
+		ckil: ckil {
 			compatible = "fsl,imx-ckil", "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <32768>;
 		};
 
-		ckih1 {
+		ckih1: ckih1 {
 			compatible = "fsl,imx-ckih1", "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <0>;
 		};
 
-		osc {
+		osc: osc {
 			compatible = "fsl,imx-osc", "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <24000000>;
@@ -483,6 +483,8 @@
 				interrupts = <0 87 IRQ_TYPE_LEVEL_HIGH>,
 					     <0 88 IRQ_TYPE_LEVEL_HIGH>;
 				#clock-cells = <1>;
+				clocks = <&ckil>, <&ckih1>, <&osc>;
+				clock-names = "ckil", "ckih1", "osc";
 			};
 
 			anatop: anatop at 020c8000 {
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index ebaad63..a6d3afb 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -79,13 +79,13 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		ckil {
+		ckil: ckil {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <32768>;
 		};
 
-		osc {
+		osc: osc {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <24000000>;
@@ -427,6 +427,8 @@
 				interrupts = <0 87 IRQ_TYPE_LEVEL_HIGH>,
 					     <0 88 IRQ_TYPE_LEVEL_HIGH>;
 				#clock-cells = <1>;
+				clocks = <&ckil>, <&osc>;
+				clock-names = "ckil", "osc";
 			};
 
 			anatop: anatop at 020c8000 {
-- 
1.8.3.2
