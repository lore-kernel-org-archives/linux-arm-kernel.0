From: george.cherian@ti.com (George Cherian)
Date: Tue, 25 Nov 2014 18:41:51 +0530
Subject: [PATCH 15/19] arm: dts: am4372: Add named interrupt property for dwc3
In-Reply-To: <1416921115-10467-1-git-send-email-george.cherian@ti.com>
References: <1416921115-10467-1-git-send-email-george.cherian@ti.com>
Message-ID: <1416921115-10467-16-git-send-email-george.cherian@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

Add interrupt names so that the same can be used for OTG easily.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: George Cherian <george.cherian@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index e19068d..3dda4c8 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -810,8 +810,13 @@
 
 			usb1: usb at 48390000 {
 				compatible = "synopsys,dwc3";
-				reg = <0x48390000 0x10000>;
-				interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x48390000 0x17000>;
+				interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "peripheral",
+						  "host",
+						  "otg";
 				phys = <&usb2_phy1>;
 				phy-names = "usb2-phy";
 				maximum-speed = "high-speed";
@@ -834,8 +839,13 @@
 
 			usb2: usb at 483d0000 {
 				compatible = "synopsys,dwc3";
-				reg = <0x483d0000 0x10000>;
-				interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x483d0000 0x17000>;
+				interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "peripheral",
+						  "host",
+						  "otg";
 				phys = <&usb2_phy2>;
 				phy-names = "usb2-phy";
 				maximum-speed = "high-speed";
-- 
1.8.3.1
