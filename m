From: rogerq@ti.com (Roger Quadros)
Date: Tue, 21 Oct 2014 13:41:18 +0300
Subject: [PATCH 2/4] ARM: dts: DRA7: Move USB_OTG 4 to dra74x.dtsi
In-Reply-To: <1413888080-2669-1-git-send-email-rogerq@ti.com>
References: <1413888080-2669-1-git-send-email-rogerq@ti.com>
Message-ID: <1413888080-2669-3-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 4th USB controller instance present only on the DRA74x family of
devices so move it there.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi   | 20 --------------------
 arch/arm/boot/dts/dra74x.dtsi | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 9cc9843..ea243e0 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1204,26 +1204,6 @@
 			};
 		};
 
-		omap_dwc3_4 at 48940000 {
-			compatible = "ti,dwc3";
-			ti,hwmods = "usb_otg_ss4";
-			reg = <0x48940000 0x10000>;
-			interrupts = <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			utmi-mode = <2>;
-			ranges;
-			status = "disabled";
-			usb4: usb at 48950000 {
-				compatible = "snps,dwc3";
-				reg = <0x48950000 0x17000>;
-				interrupts = <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>;
-				tx-fifo-resize;
-				maximum-speed = "high-speed";
-				dr_mode = "otg";
-			};
-		};
-
 		elm: elm at 48078000 {
 			compatible = "ti,am3352-elm";
 			reg = <0x48078000 0xfc0>;      /* device IO registers */
diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index 3be544c..5667b92 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -44,4 +44,26 @@
 		interrupts = <GIC_SPI DIRECT_IRQ(131) IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI DIRECT_IRQ(132) IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	ocp {
+		omap_dwc3_4 at 48940000 {
+			compatible = "ti,dwc3";
+			ti,hwmods = "usb_otg_ss4";
+			reg = <0x48940000 0x10000>;
+			interrupts = <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			utmi-mode = <2>;
+			ranges;
+			status = "disabled";
+			usb4: usb at 48950000 {
+				compatible = "snps,dwc3";
+				reg = <0x48950000 0x17000>;
+				interrupts = <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>;
+				tx-fifo-resize;
+				maximum-speed = "high-speed";
+				dr_mode = "otg";
+			};
+		};
+	};
 };
-- 
1.8.3.2
