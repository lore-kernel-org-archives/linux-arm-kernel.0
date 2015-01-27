From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 27 Jan 2015 14:59:20 +0100
Subject: [PATCHv6 1/2] leds: tlc591xx: Document binding for the TI 8/16
 Channel i2c LED driver
In-Reply-To: <1422367161-16487-1-git-send-email-andrew@lunn.ch>
References: <1422367161-16487-1-git-send-email-andrew@lunn.ch>
Message-ID: <1422367161-16487-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the binding for the TLC591xx LED driver.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Matthew.Fatheree at belkin.com
---
 .../devicetree/bindings/leds/leds-tlc591xx.txt     | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-tlc591xx.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-tlc591xx.txt b/Documentation/devicetree/bindings/leds/leds-tlc591xx.txt
new file mode 100644
index 000000000000..3bbbf7024411
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-tlc591xx.txt
@@ -0,0 +1,40 @@
+LEDs connected to tlc59116 or tlc59108
+
+Required properties
+- compatible: should be "ti,tlc59116" or "ti,tlc59108"
+- #address-cells: must be 1
+- #size-cells: must be 0
+- reg: typically 0x68
+
+Each led is represented as a sub-node of the ti,tlc59116.
+See Documentation/devicetree/bindings/leds/common.txt
+
+LED sub-node properties:
+- reg: number of LED line, 0 to 15 or 0 to 7
+- label: (optional) name of LED
+- linux,default-trigger : (optional)
+
+Examples:
+
+tlc59116 at 68 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "ti,tlc59116";
+	reg = <0x68>;
+
+	wan at 0 {
+		label = "wrt1900ac:amber:wan";
+		reg = <0x0>;
+	};
+
+	2g at 2 {
+		label = "wrt1900ac:white:2g";
+		reg = <0x2>;
+	};
+
+	alive at 9 {
+		label = "wrt1900ac:green:alive";
+		reg = <0x9>;
+		linux,default_trigger = "heartbeat";
+	};
+};
-- 
2.1.4
