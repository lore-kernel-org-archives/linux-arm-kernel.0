From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:53:22 +0200
Subject: [PATCH 30/48] ARM: dts: r8a7743: Link PCI USB devices to USB PHY
In-Reply-To: <cover.1506683482.git.horms+renesas@verge.net.au>
References: <cover.1506683482.git.horms+renesas@verge.net.au>
Message-ID: <96963454655c10663f1bc2eea57ac734cab171a7.1506683482.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Describe the PCI USB devices that are behind the PCI bridges, adding
necessary links to the USB PHY device.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7743.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index a81d70e713ea..665a5152951f 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -865,6 +865,18 @@
 			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
 					 0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
 					 0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+
+			usb at 1,0 {
+				reg = <0x800 0 0 0 0>;
+				phys = <&usb0 0>;
+				phy-names = "usb";
+			};
+
+			usb at 2,0 {
+				reg = <0x1000 0 0 0 0>;
+				phys = <&usb0 0>;
+				phy-names = "usb";
+			};
 		};
 
 		pci1: pci at ee0d0000 {
@@ -888,6 +900,18 @@
 			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
 					 0x0800 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
 					 0x1000 0 0 2 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+
+			usb at 1,0 {
+				reg = <0x10800 0 0 0 0>;
+				phys = <&usb2 0>;
+				phy-names = "usb";
+			};
+
+			usb at 2,0 {
+				reg = <0x11000 0 0 0 0>;
+				phys = <&usb2 0>;
+				phy-names = "usb";
+			};
 		};
 	};
 
-- 
2.1.4
