From: george.cherian@ti.com (George Cherian)
Date: Tue, 9 Jul 2013 14:47:26 +0530
Subject: [PATCH v2] arm: dts: AM43x: Add usb_otg_hs node
Message-ID: <1373361446-30050-1-git-send-email-george.cherian@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds device node for HS USB Host module for AM437x

changes from v1

renamed synopsis to snps
removed flag tx-fifo-resize

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index ddc1df7..c9e0da8 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -64,5 +64,23 @@
 			compatible = "ti,am4372-counter32k","ti,omap-counter32k";
 			reg = <0x44e86000 0x40>;
 		};
+
+		usb_otg_hs1: am4372_dwc3 at 48380000 {
+			compatible = "ti,am437x-dwc3";
+			reg = <0x48380000 0x1ff>;
+			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			utmi-mode = <1>;
+			ranges;
+
+			dwc3 at 48390000 {
+				compatible = "snps,dwc3";
+				reg = <0x48390000 0xcfff>;
+				interrupts = <GIC_SPI  168 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+		};
+		
 	};
 };
-- 
1.8.1.4
