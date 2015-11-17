From: jonmason@broadcom.com (Jon Mason)
Date: Tue, 17 Nov 2015 14:55:26 -0500
Subject: [PATCH 1/2] ARM: dts: NSP: Device Tree clean-ups
In-Reply-To: <1447790127-27237-1-git-send-email-jonmason@broadcom.com>
References: <1447790127-27237-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1447790127-27237-2-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minor changes to the Broadcom Northstar Plus device tree to make it more
organized and clean.  Firstly, move the GIC and L2 cache entries to be
sequential with respect to the memory addresses.  Secondly, modify the
address portion of the entry names to reflect the difference from the
range modification.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 50 +++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 4bcdd28..7335a74 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -58,30 +58,14 @@
 			};
 		};
 
-		L2: l2-cache {
-			compatible = "arm,pl310-cache";
-			reg = <0x2000 0x1000>;
-			cache-unified;
-			cache-level = <2>;
-		};
-
-		gic: interrupt-controller at 19021000 {
-			compatible = "arm,cortex-a9-gic";
-			#interrupt-cells = <3>;
-			#address-cells = <0>;
-			interrupt-controller;
-			reg = <0x1000 0x1000>,
-			      <0x0100 0x100>;
-		};
-
-		timer at 19020200 {
+		timer at 0200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x0200 0x100>;
 			interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&periph_clk>;
 		};
 
-		twd-timer at 19020600 {
+		twd-timer at 0600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x0600 0x20>;
 			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
@@ -89,13 +73,29 @@
 			clocks = <&periph_clk>;
 		};
 
-		twd-watchdog at 19020620 {
+		twd-watchdog at 0620 {
 			compatible = "arm,cortex-a9-twd-wdt";
 			reg = <0x0620 0x20>;
 			interrupts = <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) |
 						  IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&periph_clk>;
 		};
+
+		gic: interrupt-controller at 1000 {
+			compatible = "arm,cortex-a9-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x1000 0x1000>,
+			      <0x0100 0x100>;
+		};
+
+		L2: l2-cache {
+			compatible = "arm,pl310-cache";
+			reg = <0x2000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
+		};
 	};
 
 	clocks {
@@ -116,7 +116,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		uart0: serial at 18000300 {
+		uart0: serial at 0300 {
 			compatible = "ns16550a";
 			reg = <0x0300 0x100>;
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
@@ -124,7 +124,7 @@
 			status = "disabled";
 		};
 
-		uart1: serial at 18000400 {
+		uart1: serial at 0400 {
 			compatible = "ns16550a";
 			reg = <0x0400 0x100>;
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
@@ -132,7 +132,7 @@
 			status = "disabled";
 		};
 
-		pcie0: pcie at 18012000 {
+		pcie0: pcie at 12000 {
 			compatible = "brcm,iproc-pcie";
 			reg = <0x12000 0x1000>;
 
@@ -156,7 +156,7 @@
 			status = "disabled";
 		};
 
-		pcie1: pcie at 18013000 {
+		pcie1: pcie at 13000 {
 			compatible = "brcm,iproc-pcie";
 			reg = <0x13000 0x1000>;
 
@@ -180,7 +180,7 @@
 			status = "disabled";
 		};
 
-		pcie2: pcie at 18014000 {
+		pcie2: pcie at 14000 {
 			compatible = "brcm,iproc-pcie";
 			reg = <0x14000 0x1000>;
 
@@ -204,7 +204,7 @@
 			status = "disabled";
 		};
 
-		nand: nand at 18026000 {
+		nand: nand at 26000 {
 			compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1";
 			reg = <0x026000 0x600>,
 			      <0x11b408 0x600>,
-- 
1.9.1
