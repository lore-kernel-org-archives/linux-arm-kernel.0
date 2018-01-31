From: ryder.lee@mediatek.com (Ryder Lee)
Date: Wed, 31 Jan 2018 15:41:50 +0800
Subject: [PATCH 2/2] dt-bindings: PCI: MediaTek: Correct the interrupt-map
 properties
In-Reply-To: <31c765c53e85e41bfc001d110d69e46c9967f4e7.1516961656.git.ryder.lee@mediatek.com>
References: <31c765c53e85e41bfc001d110d69e46c9967f4e7.1516961656.git.ryder.lee@mediatek.com>
Message-ID: <9d247a4fba54ba90d07df32fd89a8bb2c8bdb0f9.1516961656.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the interrupt-map properties from the child nodes to the root node
and update each entry accordingly.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../devicetree/bindings/pci/mediatek-pcie.txt      | 28 ++++++++++++----------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
index 3a6ce55..b15ea2d 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
@@ -89,10 +89,21 @@ Examples for MT7623:
 		#address-cells = <3>;
 		#size-cells = <2>;
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0xf800 0 0 0>;
-		interrupt-map = <0x0000 0 0 0 &sysirq GIC_SPI 193 IRQ_TYPE_LEVEL_LOW>,
-				<0x0800 0 0 0 &sysirq GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>,
-				<0x1000 0 0 0 &sysirq GIC_SPI 195 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0x0000 0 0 1 &sysirq GIC_SPI 193 IRQ_TYPE_LEVEL_LOW
+				0x0000 0 0 2 &sysirq GIC_SPI 193 IRQ_TYPE_LEVEL_LOW
+				0x0000 0 0 3 &sysirq GIC_SPI 193 IRQ_TYPE_LEVEL_LOW
+				0x0000 0 0 4 &sysirq GIC_SPI 193 IRQ_TYPE_LEVEL_LOW
+
+				0x0800 0 0 1 &sysirq GIC_SPI 194 IRQ_TYPE_LEVEL_LOW
+				0x0800 0 0 2 &sysirq GIC_SPI 194 IRQ_TYPE_LEVEL_LOW
+				0x0800 0 0 3 &sysirq GIC_SPI 194 IRQ_TYPE_LEVEL_LOW
+				0x0800 0 0 4 &sysirq GIC_SPI 194 IRQ_TYPE_LEVEL_LOW
+
+				0x1000 0 0 1 &sysirq GIC_SPI 195 IRQ_TYPE_LEVEL_LOW
+				0x1000 0 0 2 &sysirq GIC_SPI 195 IRQ_TYPE_LEVEL_LOW
+				0x1000 0 0 3 &sysirq GIC_SPI 195 IRQ_TYPE_LEVEL_LOW
+				0x1000 0 0 4 &sysirq GIC_SPI 195 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&topckgen CLK_TOP_ETHIF_SEL>,
 			 <&hifsys CLK_HIFSYS_PCIE0>,
 			 <&hifsys CLK_HIFSYS_PCIE1>,
@@ -115,9 +126,6 @@ Examples for MT7623:
 			reg = <0x0000 0 0 0 0>;
 			#address-cells = <3>;
 			#size-cells = <2>;
-			#interrupt-cells = <1>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &sysirq GIC_SPI 193 IRQ_TYPE_LEVEL_LOW>;
 			ranges;
 			num-lanes = <1>;
 		};
@@ -127,9 +135,6 @@ Examples for MT7623:
 			reg = <0x0800 0 0 0 0>;
 			#address-cells = <3>;
 			#size-cells = <2>;
-			#interrupt-cells = <1>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &sysirq GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
 			ranges;
 			num-lanes = <1>;
 		};
@@ -139,9 +144,6 @@ Examples for MT7623:
 			reg = <0x1000 0 0 0 0>;
 			#address-cells = <3>;
 			#size-cells = <2>;
-			#interrupt-cells = <1>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &sysirq GIC_SPI 195 IRQ_TYPE_LEVEL_LOW>;
 			ranges;
 			num-lanes = <1>;
 		};
-- 
1.9.1
