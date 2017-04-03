From: david@lechnology.com (David Lechner)
Date: Mon,  3 Apr 2017 15:23:47 -0500
Subject: [PATCH 1/3] dt-bindings: power: supply: New bindings for LEGO
 MINDSTORMS EV3 battery
In-Reply-To: <1491251029-23256-1-git-send-email-david@lechnology.com>
References: <1491251029-23256-1-git-send-email-david@lechnology.com>
Message-ID: <1491251029-23256-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This add a new device tree binding for LEGO MINDSTORMS EV3 battery. The EV3
has some built-in capability for monitoring the attached battery.

Signed-off-by: David Lechner <david@lechnology.com>
---
 .../bindings/power/supply/lego_ev3_battery.txt      | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/lego_ev3_battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/lego_ev3_battery.txt b/Documentation/devicetree/bindings/power/supply/lego_ev3_battery.txt
new file mode 100644
index 0000000..5485633
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/lego_ev3_battery.txt
@@ -0,0 +1,21 @@
+LEGO MINDSTORMS EV3 Battery
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+LEGO MINDSTORMS EV3 has some built-in capability for monitoring the battery.
+It uses 6 AA batteries or a special Li-ion rechargeable battery pack that is
+detected by a key switch in the battery compartment.
+
+Required properties:
+ - compatible: Must be "lego,ev3-battery"
+ - io-channels: phandles to analog inputs for reading voltage and current
+ - io-channel-names: Must be "voltage", "current"
+ - rechargeable-gpios: phandle to the rechargeable battery indication gpio
+
+Example:
+
+	battery {
+		compatible = "lego,ev3-battery";
+		io-channels = <&adc 4>, <&adc 3>;
+		io-channel-names = "voltage", "current";
+		rechargeable-gpios = <&gpio 136 GPIO_ACTIVE_LOW>;
+	};
-- 
2.7.4
