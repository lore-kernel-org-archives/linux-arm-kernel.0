From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jun 2017 15:30:46 +0200
Subject: [PATCH 6/6] ARM: dts: r8a779x: Fix PCI bus dtc warnings
In-Reply-To: <cover.1497618353.git.horms+renesas@verge.net.au>
References: <cover.1497618353.git.horms+renesas@verge.net.au>
Message-ID: <f7d569c1e6a6fa731fc34083a9f0191b7360eeb1.1497618353.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

The bogus 'device_type = "pci"' confuses dtc, causing lots of totally
unrelated warnings.  After fixing that, real warnings like

    arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_device_reg): Node /pci at ee090000/usb at 0,1 PCI unit address format error, expected "1,0"

are left.  Correct the unit-addresses and reg properties of the subnodes
to fix these.

Signed-off-by: Rob Herring <robh@kernel.org>
[geert: Improve description]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 16 ++++++----------
 arch/arm/boot/dts/r8a7791.dtsi | 16 ++++++----------
 arch/arm/boot/dts/r8a7794.dtsi | 16 ++++++----------
 3 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 416956a42c93..2805a8608d4b 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1602,16 +1602,14 @@
 				 0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
 				 0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 
-		usb at 0,1 {
+		usb at 1,0 {
 			reg = <0x800 0 0 0 0>;
-			device_type = "pci";
 			phys = <&usb0 0>;
 			phy-names = "usb";
 		};
 
-		usb at 0,2 {
+		usb at 2,0 {
 			reg = <0x1000 0 0 0 0>;
-			device_type = "pci";
 			phys = <&usb0 0>;
 			phy-names = "usb";
 		};
@@ -1658,16 +1656,14 @@
 				 0x0800 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
 				 0x1000 0 0 2 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 
-		usb at 0,1 {
-			reg = <0x800 0 0 0 0>;
-			device_type = "pci";
+		usb at 1,0 {
+			reg = <0x20800 0 0 0 0>;
 			phys = <&usb2 0>;
 			phy-names = "usb";
 		};
 
-		usb at 0,2 {
-			reg = <0x1000 0 0 0 0>;
-			device_type = "pci";
+		usb at 2,0 {
+			reg = <0x21000 0 0 0 0>;
 			phys = <&usb2 0>;
 			phy-names = "usb";
 		};
diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index b730c889a404..bd93f699ad84 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1613,16 +1613,14 @@
 				 0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
 				 0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 
-		usb at 0,1 {
+		usb at 1,0 {
 			reg = <0x800 0 0 0 0>;
-			device_type = "pci";
 			phys = <&usb0 0>;
 			phy-names = "usb";
 		};
 
-		usb at 0,2 {
+		usb at 2,0 {
 			reg = <0x1000 0 0 0 0>;
-			device_type = "pci";
 			phys = <&usb0 0>;
 			phy-names = "usb";
 		};
@@ -1648,16 +1646,14 @@
 				 0x0800 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
 				 0x1000 0 0 2 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 
-		usb at 0,1 {
-			reg = <0x800 0 0 0 0>;
-			device_type = "pci";
+		usb at 1,0 {
+			reg = <0x10800 0 0 0 0>;
 			phys = <&usb2 0>;
 			phy-names = "usb";
 		};
 
-		usb at 0,2 {
-			reg = <0x1000 0 0 0 0>;
-			device_type = "pci";
+		usb at 2,0 {
+			reg = <0x11000 0 0 0 0>;
 			phys = <&usb2 0>;
 			phy-names = "usb";
 		};
diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index a19b884fb258..7d9a81d970d8 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -820,16 +820,14 @@
 				 0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
 				 0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 
-		usb at 0,1 {
+		usb at 1,0 {
 			reg = <0x800 0 0 0 0>;
-			device_type = "pci";
 			phys = <&usb0 0>;
 			phy-names = "usb";
 		};
 
-		usb at 0,2 {
+		usb at 2,0 {
 			reg = <0x1000 0 0 0 0>;
-			device_type = "pci";
 			phys = <&usb0 0>;
 			phy-names = "usb";
 		};
@@ -855,16 +853,14 @@
 				 0x0800 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
 				 0x1000 0 0 2 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 
-		usb at 0,1 {
-			reg = <0x800 0 0 0 0>;
-			device_type = "pci";
+		usb at 1,0 {
+			reg = <0x10800 0 0 0 0>;
 			phys = <&usb2 0>;
 			phy-names = "usb";
 		};
 
-		usb at 0,2 {
-			reg = <0x1000 0 0 0 0>;
-			device_type = "pci";
+		usb at 2,0 {
+			reg = <0x11000 0 0 0 0>;
 			phys = <&usb2 0>;
 			phy-names = "usb";
 		};
-- 
2.1.4
