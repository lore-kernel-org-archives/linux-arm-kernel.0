From: linux@roeck-us.net (Guenter Roeck)
Date: Tue,  5 Jul 2016 09:44:31 -0700
Subject: [PATCH 1/3] dt/bindings: Add bindings for JC-42.4 compatible
 temperature sensors
Message-ID: <1467737073-7949-1-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide generic bindings for all Jedec JC-42.4 compatible temperature
sensor chips.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/devicetree/bindings/hwmon/jc42.txt | 42 ++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/jc42.txt

diff --git a/Documentation/devicetree/bindings/hwmon/jc42.txt b/Documentation/devicetree/bindings/hwmon/jc42.txt
new file mode 100644
index 000000000000..07a250498fbb
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/jc42.txt
@@ -0,0 +1,42 @@
+Properties for Jedec JC-42.4 compatible temperature sensors
+
+Required properties:
+- compatible: May include a device-specific string consisting of the
+	      manufacturer and the name of the chip. A list of supported
+	      chip names follows.
+	      Must include "jedec,jc-42.4-temp" for any Jedec JC-42.4
+	      compatible temperature sensor.
+
+	      Supported chip names:
+		adi,adt7408
+		atmel,at30ts00
+		atmel,at30tse004
+		onnn,cat6095
+		onnn,cat34ts02
+		maxim,max6604
+		microchip,mcp9804
+		microchip,mcp9805
+		microchip,mcp9808
+		microchip,mcp98243
+		microchip,mcp98244
+		microchip,mcp9843
+		nxp,se97
+		nxp,se98
+		st,stts2002
+		st,stts2004
+		st,stts3000
+		st,stts424
+		st,stts424e
+		idt,tse2002
+		idt,tse2004
+		idt,ts3000
+		idt,ts3001
+
+- reg: I2C address
+
+Example:
+
+temp-sensor at 1a {
+	compatible = "jedec,jc-42.4-temp";
+	reg = <0x1a>;
+};
-- 
2.5.0
