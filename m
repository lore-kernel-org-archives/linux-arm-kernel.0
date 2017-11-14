From: rasmus.villemoes@prevas.dk (Rasmus Villemoes)
Date: Tue, 14 Nov 2017 13:39:43 +0100
Subject: [PATCH] arm: dts: ls1021a: Add label to USB controllers
Message-ID: <1510663184-19537-1-git-send-email-rasmus.villemoes@prevas.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Esben Haabendal <eha@deif.com>

Add usb2 and usb3 labels to USB2 and USB3 controller device tree nodes,
for easier modification in board dts files.

Signed-off-by: Esben Haabendal <eha@deif.com>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 arch/arm/boot/dts/ls1021a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 9cdec545decc..50ad4dccb22b 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -675,7 +675,7 @@
 			};
 		};
 
-		usb at 8600000 {
+		usb2: usb at 8600000 {
 			compatible = "fsl-usb2-dr-v2.5", "fsl-usb2-dr";
 			reg = <0x0 0x8600000 0x0 0x1000>;
 			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
@@ -683,7 +683,7 @@
 			phy_type = "ulpi";
 		};
 
-		usb3 at 3100000 {
+		usb3: usb3 at 3100000 {
 			compatible = "snps,dwc3";
 			reg = <0x0 0x3100000 0x0 0x10000>;
 			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.7.4
