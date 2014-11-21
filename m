From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 22 Nov 2014 00:45:35 +0100
Subject: [PATCHv6 02/10] arm: mvebu: add uartX labels for Armada SoC serial
 nodes
In-Reply-To: <cover.1416613429.git.arno@natisbad.org>
References: <cover.1416613429.git.arno@natisbad.org>
Message-ID: <0683d1a823fe9b75849f3dafcf1cf6ee291cdca6.1416613429.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch adds uartX labels for Armada SoC serial nodes. This is
a preliminary work to be able to easily reference the serial lines
in Device Tree files. One expected use is when providing stdout-path
property for barebox.

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 5 +++--
 arch/arm/boot/dts/armada-xp.dtsi     | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 83286ec9702c..2be9723bcdf3 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -151,7 +151,7 @@
 				status = "disabled";
 			};
 
-			serial at 12000 {
+			uart0: serial at 12000 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0x12000 0x100>;
 				reg-shift = <2>;
@@ -160,7 +160,8 @@
 				clocks = <&coreclk 0>;
 				status = "disabled";
 			};
-			serial at 12100 {
+
+			uart1: serial at 12100 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0x12100 0x100>;
 				reg-shift = <2>;
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index a3919b644737..e4ba27ef109b 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -53,7 +53,7 @@
 				reg = <0x11100 0x100>;
 			};
 
-			serial at 12200 {
+			uart2: serial at 12200 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0x12200 0x100>;
 				reg-shift = <2>;
@@ -62,7 +62,8 @@
 				clocks = <&coreclk 0>;
 				status = "disabled";
 			};
-			serial at 12300 {
+
+			uart3: serial at 12300 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0x12300 0x100>;
 				reg-shift = <2>;
-- 
2.1.1
