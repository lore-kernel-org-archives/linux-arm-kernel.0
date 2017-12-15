From: malat@debian.org (Mathieu Malaterre)
Date: Fri, 15 Dec 2017 13:46:51 +0100
Subject: [PATCH 18/25] arm: am3/am4/dra7/omap: dts: Remove leading 0x and 0s
 from bindings notation
Message-ID: <20171215124651.30793-1-malat@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Improve the DTS files by removing all the leading "0x" and zeros to fix the
following dtc warnings:

Warning (unit_address_format): Node /XXX unit name should not have leading "0x"

and

Warning (unit_address_format): Node /XXX unit name should not have leading 0s

Converted using the following command:

find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed -i -e "s/@\([0-9a-fA-FxX\.;:#]+\)\s*{/@\L\1 {/g" -e "s/@0x\(.*\) {/@\1 {/g" -e "s/@0+\(.*\) {/@\1 {/g" {} +^C

For simplicity, two sed expressions were used to solve each warnings separately.

To make the regex expression more robust a few other issues were resolved,
namely setting unit-address to lower case, and adding a whitespace before the
the opening curly brace:

https://elinux.org/Device_Tree_Linux#Linux_conventions

This will solve as a side effect warning:

Warning (simple_bus_reg): Node /XXX@<UPPER> simple-bus unit address format error, expected "<lower>"

This is a follow up to commit 4c9847b7375a ("dt-bindings: Remove leading 0x from bindings notation")

Reported-by: David Daney <ddaney@caviumnetworks.com>
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/arm/boot/dts/am33xx.dtsi           | 4 ++--
 arch/arm/boot/dts/am3517.dtsi           | 4 ++--
 arch/arm/boot/dts/am4372.dtsi           | 4 ++--
 arch/arm/boot/dts/dra62x-j5eco-evm.dts  | 8 ++++----
 arch/arm/boot/dts/dra7.dtsi             | 2 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi     | 8 ++++----
 arch/arm/boot/dts/omap3-evm-37xx.dts    | 8 ++++----
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi | 8 ++++----
 8 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index d37f95025807..6699fcb77509 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -496,7 +496,7 @@
 			status = "disabled";
 		};
 
-		mailbox: mailbox at 480C8000 {
+		mailbox: mailbox at 480c8000 {
 			compatible = "ti,omap4-mailbox";
 			reg = <0x480C8000 0x200>;
 			interrupts = <77>;
@@ -991,7 +991,7 @@
 			dma-names = "tx", "rx";
 		};
 
-		mcasp1: mcasp at 4803C000 {
+		mcasp1: mcasp at 4803c000 {
 			compatible = "ti,am33xx-mcasp-audio";
 			ti,hwmods = "mcasp1";
 			reg = <0x4803C000 0x2000>,
diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index 00da3f2c4072..76994165fb3a 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -26,7 +26,7 @@
 			interrupt-names = "mc";
 		};
 
-		davinci_emac: ethernet at 0x5c000000 {
+		davinci_emac: ethernet at 5c000000 {
 			compatible = "ti,am3517-emac";
 			ti,hwmods = "davinci_emac";
 			status = "disabled";
@@ -41,7 +41,7 @@
 			local-mac-address = [ 00 00 00 00 00 00 ];
 		};
 
-		davinci_mdio: ethernet at 0x5c030000 {
+		davinci_mdio: ethernet at 5c030000 {
 			compatible = "ti,davinci_mdio";
 			ti,hwmods = "davinci_mdio";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 4714a59fd86d..5aff7f01a513 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -325,7 +325,7 @@
 			status = "disabled";
 		};
 
-		mailbox: mailbox at 480C8000 {
+		mailbox: mailbox at 480c8000 {
 			compatible = "ti,omap4-mailbox";
 			reg = <0x480C8000 0x200>;
 			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
@@ -936,7 +936,7 @@
 			dma-names = "tx", "rx";
 		};
 
-		mcasp1: mcasp at 4803C000 {
+		mcasp1: mcasp at 4803c000 {
 			compatible = "ti,am33xx-mcasp-audio";
 			ti,hwmods = "mcasp1";
 			reg = <0x4803C000 0x2000>,
diff --git a/arch/arm/boot/dts/dra62x-j5eco-evm.dts b/arch/arm/boot/dts/dra62x-j5eco-evm.dts
index 155eb32ee213..fee0547f7302 100644
--- a/arch/arm/boot/dts/dra62x-j5eco-evm.dts
+++ b/arch/arm/boot/dts/dra62x-j5eco-evm.dts
@@ -74,19 +74,19 @@
 			label = "X-Loader";
 			reg = <0 0x80000>;
 		};
-		partition at 0x80000 {
+		partition at 80000 {
 			label = "U-Boot";
 			reg = <0x80000 0x1c0000>;
 		};
-		partition at 0x1c0000 {
+		partition at 1c0000 {
 			label = "Environment";
 			reg = <0x240000 0x40000>;
 		};
-		partition at 0x280000 {
+		partition at 280000 {
 			label = "Kernel";
 			reg = <0x280000 0x500000>;
 		};
-		partition at 0x780000 {
+		partition at 780000 {
 			label = "Filesystem";
 			reg = <0x780000 0xf880000>;
 		};
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index ac9216293b7c..f8f5206130d6 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1373,7 +1373,7 @@
 			ranges;
 			reg = <0x4a090000 0x20>;
 			ti,hwmods = "ocp2scp3";
-			sata_phy: phy at 4A096000 {
+			sata_phy: phy at 4a096000 {
 				compatible = "ti,phy-pipe3-sata";
 				reg = <0x4A096000 0x80>, /* phy_rx */
 				      <0x4A096400 0x64>, /* phy_tx */
diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index ab6003fe5a43..9dcb18d22cde 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -306,19 +306,19 @@
 			label = "xloader";
 			reg = <0 0x80000>;
 		};
-		partition at 0x80000 {
+		partition at 80000 {
 			label = "uboot";
 			reg = <0x80000 0x1e0000>;
 		};
-		partition at 0x260000 {
+		partition at 260000 {
 			label = "uboot environment";
 			reg = <0x260000 0x40000>;
 		};
-		partition at 0x2a0000 {
+		partition at 2a0000 {
 			label = "linux";
 			reg = <0x2a0000 0x400000>;
 		};
-		partition at 0x6a0000 {
+		partition at 6a0000 {
 			label = "rootfs";
 			reg = <0x6a0000 0x1f880000>;
 		};
diff --git a/arch/arm/boot/dts/omap3-evm-37xx.dts b/arch/arm/boot/dts/omap3-evm-37xx.dts
index 5a4ba0aea447..a14303b09ae2 100644
--- a/arch/arm/boot/dts/omap3-evm-37xx.dts
+++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
@@ -90,19 +90,19 @@
 			label = "X-Loader";
 			reg = <0 0x80000>;
 		};
-		partition at 0x80000 {
+		partition at 80000 {
 			label = "U-Boot";
 			reg = <0x80000 0x1c0000>;
 		};
-		partition at 0x1c0000 {
+		partition at 1c0000 {
 			label = "Environment";
 			reg = <0x240000 0x40000>;
 		};
-		partition at 0x280000 {
+		partition at 280000 {
 			label = "Kernel";
 			reg = <0x280000 0x500000>;
 		};
-		partition at 0x780000 {
+		partition at 780000 {
 			label = "Filesystem";
 			reg = <0x780000 0x1f880000>;
 		};
diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index 7ada1e93e166..cf7a2a72348d 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -405,22 +405,22 @@
 			reg = <0 0x80000>;
 		};
 
-		partition at 0x80000 {
+		partition at 80000 {
 			label = "u-boot";
 			reg = <0x80000 0x1e0000>;
 		};
 
-		partition at 0x260000 {
+		partition at 260000 {
 			label = "u-boot-environment";
 			reg = <0x260000 0x20000>;
 		};
 
-		partition at 0x280000 {
+		partition at 280000 {
 			label = "kernel";
 			reg = <0x280000 0x500000>;
 		};
 
-		partition at 0x780000 {
+		partition at 780000 {
 			label = "filesystem";
 			reg = <0x780000 0xf880000>;
 		};
-- 
2.11.0
