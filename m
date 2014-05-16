From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 16 May 2014 18:22:56 +0200
Subject: [PATCH 5/5] ARM: mvebu: add PHY support to the dts for the USB
 controllers on Armada 375
In-Reply-To: <1400257376-13251-1-git-send-email-gregory.clement@free-electrons.com>
References: <1400257376-13251-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1400257376-13251-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the USB cluster node has been added, use it as a PHY provider
for the USB controller linked to it: the first EHCI and the xHCI.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 31b3ac0f9c77..0896b0daf7be 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -14,6 +14,7 @@
 #include "skeleton.dtsi"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/phy/armada-375-usb-cluster.h>
 
 #define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
 
@@ -331,6 +332,8 @@
 				reg = <0x50000 0x500>;
 				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gateclk 18>;
+				phys = <&usbcluster PHY_USB2>;
+				phy-names = "usb";
 				status = "disabled";
 			};
 
@@ -347,6 +350,8 @@
 				reg = <0x58000 0x20000>,<0x5b880 0x80>;
 				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gateclk 16>;
+				phys = <&usbcluster PHY_USB3>;
+				phy-names = "usb";
 				status = "disabled";
 			};
 
-- 
1.8.1.2
