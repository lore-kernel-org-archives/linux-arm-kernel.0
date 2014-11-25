From: george.cherian@ti.com (George Cherian)
Date: Tue, 25 Nov 2014 18:41:53 +0530
Subject: [PATCH 17/19] arm: dts: dra7: Add named interrupt property for dwc3
In-Reply-To: <1416921115-10467-1-git-send-email-george.cherian@ti.com>
References: <1416921115-10467-1-git-send-email-george.cherian@ti.com>
Message-ID: <1416921115-10467-18-git-send-email-george.cherian@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add interrupt names so that the same can be used for OTG easily.

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 9cc9843..78f1761 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1153,7 +1153,12 @@
 			usb1: usb at 48890000 {
 				compatible = "snps,dwc3";
 				reg = <0x48890000 0x17000>;
-				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "peripheral",
+						  "host",
+						  "otg";
 				phys = <&usb2_phy1>, <&usb3_phy1>;
 				phy-names = "usb2-phy", "usb3-phy";
 				tx-fifo-resize;
@@ -1174,7 +1179,12 @@
 			usb2: usb at 488d0000 {
 				compatible = "snps,dwc3";
 				reg = <0x488d0000 0x17000>;
-				interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "peripheral",
+						  "host",
+						  "otg";
 				phys = <&usb2_phy2>;
 				phy-names = "usb2-phy";
 				tx-fifo-resize;
@@ -1197,7 +1207,12 @@
 			usb3: usb at 48910000 {
 				compatible = "snps,dwc3";
 				reg = <0x48910000 0x17000>;
-				interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "peripheral",
+						  "host",
+						  "otg";
 				tx-fifo-resize;
 				maximum-speed = "high-speed";
 				dr_mode = "otg";
@@ -1217,7 +1232,12 @@
 			usb4: usb at 48950000 {
 				compatible = "snps,dwc3";
 				reg = <0x48950000 0x17000>;
-				interrupts = <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "peripheral",
+						  "host",
+						  "otg";
 				tx-fifo-resize;
 				maximum-speed = "high-speed";
 				dr_mode = "otg";
-- 
1.8.3.1
