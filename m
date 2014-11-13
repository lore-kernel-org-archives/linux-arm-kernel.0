From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 13 Nov 2014 12:47:48 +0100
Subject: [PATCH v4 6/7] ARM: mvebu: add PHY support to the dts for the USB
 controllers on Armada 375
In-Reply-To: <1415879269-29711-1-git-send-email-gregory.clement@free-electrons.com>
References: <1415879269-29711-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1415879269-29711-7-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the USB cluster node has been added, use it as a PHY provider
for the USB controller linked to it: the first EHCI and the xHCI.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 8f45cf5d2a50..f344ec420c95 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -14,6 +14,7 @@
 #include "skeleton.dtsi"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/phy/phy.h>
 
 #define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
 
@@ -396,6 +397,8 @@
 				reg = <0x50000 0x500>;
 				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gateclk 18>;
+				phys = <&usbcluster PHY_TYPE_USB2>;
+				phy-names = "usb";
 				status = "disabled";
 			};
 
@@ -412,6 +415,8 @@
 				reg = <0x58000 0x20000>,<0x5b880 0x80>;
 				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gateclk 16>;
+				phys = <&usbcluster PHY_TYPE_USB3>;
+				phy-names = "usb";
 				status = "disabled";
 			};
 
-- 
1.9.1
