From: balbi@ti.com (Felipe Balbi)
Date: Wed, 3 Sep 2014 16:22:24 -0500
Subject: [PATCH] arm: boot: dts: am4372: fix USB regs size
Message-ID: <1409779344-27823-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Size should be 64KiB instead of 92KiB.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 9b3d2ba..8689949 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -804,7 +804,7 @@
 
 			usb1: usb at 48390000 {
 				compatible = "synopsys,dwc3";
-				reg = <0x48390000 0x17000>;
+				reg = <0x48390000 0x10000>;
 				interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&usb2_phy1>;
 				phy-names = "usb2-phy";
@@ -826,7 +826,7 @@
 
 			usb2: usb at 483d0000 {
 				compatible = "synopsys,dwc3";
-				reg = <0x483d0000 0x17000>;
+				reg = <0x483d0000 0x10000>;
 				interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&usb2_phy2>;
 				phy-names = "usb2-phy";
-- 
2.0.1.563.g66f467c
