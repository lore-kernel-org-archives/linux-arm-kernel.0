From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 23 Nov 2018 17:17:27 +0100
Subject: [PATCH v2 3/6] dt-bindings: ap806: document the thermal interrupt
 capabilities
In-Reply-To: <20181123161730.11289-1-miquel.raynal@bootlin.com>
References: <20181123161730.11289-1-miquel.raynal@bootlin.com>
Message-ID: <20181123161730.11289-4-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The thermal IP can produce interrupts on overheat situation.
Describe them.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../bindings/arm/marvell/ap806-system-controller.txt      | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
index 3fd21bb7cb37..35e8dd2edfd2 100644
--- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
@@ -114,12 +114,18 @@ Documentation/devicetree/bindings/thermal/thermal.txt
 The thermal IP can probe the temperature all around the processor. It
 may feature several channels, each of them wired to one sensor.
 
+It is possible to setup an overheat interrupt by giving at least one
+critical point to any subnode of the thermal-zone node.
+
 Required properties:
 - compatible: must be one of:
   * marvell,armada-ap806-thermal
 - reg: register range associated with the thermal functions.
 
 Optional properties:
+- interrupt-parent/interrupts: overheat interrupt handle. Should point to
+  line 18 of the SEI irqchip.
+  See interrupt-controller/interrupts.txt
 - #thermal-sensor-cells: shall be <1> when thermal-zones subnodes refer
   to this IP and represents the channel ID. There is one sensor per
   channel. O refers to the thermal IP internal channel, while positive
@@ -133,6 +139,8 @@ ap_syscon1: system-controller at 6f8000 {
 	ap_thermal: thermal-sensor at 80 {
 		compatible = "marvell,armada-ap806-thermal";
 		reg = <0x80 0x10>;
+		interrupt-parent = <&sei>;
+		interrupts = <18>;
 		#thermal-sensor-cells = <1>;
 	};
 };
-- 
2.19.1
