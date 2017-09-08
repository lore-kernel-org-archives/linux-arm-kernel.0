From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Fri, 8 Sep 2017 13:41:31 -0500
Subject: [PATCH v2 1/2] ARM: dts: k2g: Add USB instances
In-Reply-To: <20170908184132.6155-1-fcooper@ti.com>
References: <20170908184132.6155-1-fcooper@ti.com>
Message-ID: <20170908184132.6155-2-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vitaly Andrianov <vitalya@ti.com>

Add nodes for both USB instances supported by 66AK2G.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/boot/dts/keystone-k2g.dtsi | 56 +++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index a789f75..c8f3b93 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -139,5 +139,61 @@
 			interrupts = <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		usb0_phy: usb-phy at 0 {
+			compatible = "usb-nop-xceiv";
+			status = "disabled";
+		};
+
+		keystone_usb0: keystone-dwc3 at 2680000 {
+			compatible = "ti,keystone-dwc3";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x2680000 0x10000>;
+			interrupts = <GIC_SPI 128 IRQ_TYPE_EDGE_RISING>;
+			ranges;
+			dma-coherent;
+			dma-ranges;
+			status = "disabled";
+			power-domains = <&k2g_pds 0x0016>;
+
+			usb0: usb at 2690000 {
+				compatible = "snps,dwc3";
+				reg = <0x2690000 0x10000>;
+				interrupts = <GIC_SPI 128 IRQ_TYPE_EDGE_RISING>;
+				maximum-speed = "high-speed";
+				dr_mode = "otg";
+				usb-phy = <&usb0_phy>;
+				status = "disabled";
+			};
+		};
+
+		usb1_phy: usb-phy at 1 {
+			compatible = "usb-nop-xceiv";
+			status = "disabled";
+		};
+
+		keystone_usb1: keystone-dwc3 at 2580000 {
+			compatible = "ti,keystone-dwc3";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x2580000 0x10000>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_EDGE_RISING>;
+			ranges;
+			dma-coherent;
+			dma-ranges;
+			status = "disabled";
+			power-domains = <&k2g_pds 0x0017>;
+
+			usb1: usb at 2590000 {
+				compatible = "snps,dwc3";
+				reg = <0x2590000 0x10000>;
+				interrupts = <GIC_SPI 144 IRQ_TYPE_EDGE_RISING>;
+				maximum-speed = "high-speed";
+				dr_mode = "otg";
+				usb-phy = <&usb1_phy>;
+				status = "disabled";
+			};
+		};
 	};
 };
-- 
2.9.4.dirty
