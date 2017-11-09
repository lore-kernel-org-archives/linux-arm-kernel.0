From: robh@kernel.org (Rob Herring)
Date: Thu,  9 Nov 2017 16:26:09 -0600
Subject: [PATCH 1/6] dt-bindings: usb: add #phy-cells to usb-nop-xceiv
Message-ID: <20171109222614.5719-1-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Consumers of usb-nop-xceiv use the phy binding, but #phy-cells is missing
from the binding. This is probably because this binding predates the
common phy binding. So add #phy-cells as a required property. This should
not break any users as missing should be treated as 0 cells.

Signed-off-by: Rob Herring <robh@kernel.org>
---
I'll apply to DT tree.

 Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
index 5be01c859b7a..4dc6a8ee3071 100644
--- a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
+++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
@@ -2,6 +2,7 @@ USB NOP PHY
 
 Required properties:
 - compatible: should be usb-nop-xceiv
+- #phy-cells: Must be 0
 
 Optional properties:
 - clocks: phandle to the PHY clock. Use as per Documentation/devicetree
@@ -33,6 +34,7 @@ Example:
 		reset-gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
 		vbus-detect-gpio = <&gpio2 13 GPIO_ACTIVE_HIGH>;
 		vbus-regulator = <&vbus_regulator>;
+		#phy-cells = <0>;
 	};
 
 hsusb1_phy is a NOP USB PHY device that gets its clock from an oscillator
-- 
2.14.1
