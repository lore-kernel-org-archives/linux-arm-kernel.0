From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 11 Jun 2018 15:47:14 -0700
Subject: [PATCH 3/3] ARM: dts: HR2: Fix interrupt types for i2c and PCIe
In-Reply-To: <20180611224714.7007-1-f.fainelli@gmail.com>
References: <20180611224714.7007-1-f.fainelli@gmail.com>
Message-ID: <20180611224714.7007-4-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2c and PCIe controllers had an incorrect type which should have
been set to IRQ_TYPE_LEVEL_HIGH, fix that.

Fixes: b9099ec754b5 ("ARM: dts: Add Broadcom Hurricane 2 DTS include file")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-hr2.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-hr2.dtsi b/arch/arm/boot/dts/bcm-hr2.dtsi
index 3f9cedd8011f..3084a7c95733 100644
--- a/arch/arm/boot/dts/bcm-hr2.dtsi
+++ b/arch/arm/boot/dts/bcm-hr2.dtsi
@@ -264,7 +264,7 @@
 			reg = <0x38000 0x50>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <GIC_SPI 95 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <100000>;
 		};
 
@@ -279,7 +279,7 @@
 			reg = <0x3b000 0x50>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <GIC_SPI 96 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <100000>;
 		};
 	};
@@ -300,7 +300,7 @@
 
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 186 IRQ_TYPE_NONE>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
 
 		linux,pci-domain = <0>;
 
@@ -322,10 +322,10 @@
 			compatible = "brcm,iproc-msi";
 			msi-controller;
 			interrupt-parent = <&gic>;
-			interrupts = <GIC_SPI 182 IRQ_TYPE_NONE>,
-				     <GIC_SPI 183 IRQ_TYPE_NONE>,
-				     <GIC_SPI 184 IRQ_TYPE_NONE>,
-				     <GIC_SPI 185 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
 			brcm,pcie-msi-inten;
 		};
 	};
@@ -336,7 +336,7 @@
 
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 192 IRQ_TYPE_NONE>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
 
 		linux,pci-domain = <1>;
 
@@ -358,10 +358,10 @@
 			compatible = "brcm,iproc-msi";
 			msi-controller;
 			interrupt-parent = <&gic>;
-			interrupts = <GIC_SPI 188 IRQ_TYPE_NONE>,
-				     <GIC_SPI 189 IRQ_TYPE_NONE>,
-				     <GIC_SPI 190 IRQ_TYPE_NONE>,
-				     <GIC_SPI 191 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
 			brcm,pcie-msi-inten;
 		};
 	};
-- 
2.14.1
