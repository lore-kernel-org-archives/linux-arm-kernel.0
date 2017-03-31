From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Fri, 31 Mar 2017 09:41:15 +0200
Subject: [PATCH] ARM: dts: armada-38x: label USB and SATA nodes
Message-ID: <20170331074115.8111-1-ralph.sennhauser@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recently most nodes got labels to make them referenceable. The USB 3.0
nodes as well as the nodes for the SATA controllers were left out,
rectify the omission.

Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
---

Hi everybody

In preparation to add support for the Linksys WRT3200ACM (Rango) some
rework of the "dts-stack" is highly desirable. This patch is part of the
preparatory work but independent.

The label for the USB 2.0 port is "usb0:", so using "usb1:" and "usb2:"
would be the logical continuation. Guess you realized the catch already,
"usb2:" for an USB 3.0 controller might be very confusing.

I'm sending this patch ahead of the rest so the labels can be discussed
and finalized.

Ralph

---

 arch/arm/boot/dts/armada-38x.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index ba27ec1..78c838a 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -530,7 +530,7 @@
 				interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
-			sata at a8000 {
+			satac0: sata at a8000 {
 				compatible = "marvell,armada-380-ahci";
 				reg = <0xa8000 0x2000>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
@@ -546,7 +546,7 @@
 				status = "disabled";
 			};
 
-			sata at e0000 {
+			satac1: sata at e0000 {
 				compatible = "marvell,armada-380-ahci";
 				reg = <0xe0000 0x2000>;
 				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
@@ -590,7 +590,7 @@
 				status = "disabled";
 			};
 
-			usb3 at f0000 {
+			usb3_0: usb3 at f0000 {
 				compatible = "marvell,armada-380-xhci";
 				reg = <0xf0000 0x4000>,<0xf4000 0x4000>;
 				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
@@ -598,7 +598,7 @@
 				status = "disabled";
 			};
 
-			usb3 at f8000 {
+			usb3_1: usb3 at f8000 {
 				compatible = "marvell,armada-380-xhci";
 				reg = <0xf8000 0x4000>,<0xfc000 0x4000>;
 				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.10.2
