From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 20 Sep 2017 23:18:08 +0800
Subject: [RFC PATCH 1/7] dt-bindings: add compatibles for AXP803 Battery/USB
 power supplies
In-Reply-To: <20170920151814.22461-1-icenowy@aosc.io>
References: <20170920151814.22461-1-icenowy@aosc.io>
Message-ID: <20170920151814.22461-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXP803 PMIC has different Battery and USB power supplies than the
AXP series PMICs already supported by the kernel, but the AC power
supply is the same as AXP22x (as it can only detect the present/online
state of the AC power supply on both AXP22x and AXP803).

Add compatible strings for the AXP803 Battery/USB power supplies. For AC
power supply the one on AXP803 is compatible with the one on AXP22x.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt   | 1 +
 Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
index c24886676a60..091e5471a8c6 100644
--- a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
@@ -4,6 +4,7 @@ Required Properties:
  - compatible, one of:
 			"x-powers,axp209-battery-power-supply"
 			"x-powers,axp221-battery-power-supply"
+			"x-powers,axp803-battery-power-supply"
 
 This node is a subnode of the axp20x/axp22x PMIC.
 
diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
index ba8d35f66cbe..f30e3bf8d23f 100644
--- a/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
+++ b/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
@@ -4,6 +4,7 @@ Required Properties:
 -compatible: One of: "x-powers,axp202-usb-power-supply"
                      "x-powers,axp221-usb-power-supply"
                      "x-powers,axp223-usb-power-supply"
+                     "x-powers,axp803-usb-power-supply"
 
 The AXP223 PMIC shares most of its behaviour with the AXP221 but has slight
 variations such as the former being able to set the VBUS power supply max
-- 
2.13.5
