From: carlo@caione.org (Carlo Caione)
Date: Thu,  9 Mar 2017 11:17:58 +0100
Subject: [PATCH v3 1/2] Documentation: bindings: Introduce scpi,sensors-scale
In-Reply-To: <20170309101759.18081-1-carlo@caione.org>
References: <20170309101759.18081-1-carlo@caione.org>
Message-ID: <20170309101759.18081-2-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Document the new property `scpi,sensors-scale` used by the hwmon-scpi
driver to convert the sensor readings to the correct / expected scale.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 Documentation/devicetree/bindings/arm/arm,scpi.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Documentation/devicetree/bindings/arm/arm,scpi.txt
index 4018319..35c621c 100644
--- a/Documentation/devicetree/bindings/arm/arm,scpi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
@@ -84,6 +84,24 @@ Required properties:
 			 as used by the firmware. Refer to  platform details
 			 for your implementation for the IDs to use.
 
+Optional properties:
+- scpi,sensors-scale: array of 5 elements defining the unit scale used by the
+                      SCP for the 5 different sensor classes (temperature,
+                      voltage, current, power, energy) such that 1 == unit,
+                      1000 == milli, 1000000 == micro, ...
+
+                      Example:
+                         scpi,sensors-scale = <1 1000 1000 1000000 1000000>
+                      In this case the values reported by SCP are:
+                      -> temperature in degree Celsius
+                      -> voltage in millivolts
+                      -> current in milliamperes
+                      -> power in microwatts
+                      -> energy in microjoules
+
+                      The default value is:
+                         scpi,sensors-scale = <1000 1000 1000 1000000 1000000>
+
 Power domain bindings for the power domains based on SCPI Message Protocol
 ------------------------------------------------------------
 
-- 
2.9.3
