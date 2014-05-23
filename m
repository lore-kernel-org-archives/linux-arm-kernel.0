From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Fri, 23 May 2014 18:43:28 +0300
Subject: [Patch v7 3/7] mfd: ti-keystone-devctrl: add bindings for device
 state control
In-Reply-To: <1400859812-5761-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1400859812-5761-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <1400859812-5761-4-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Keystone II devices have a set of registers that are used to control
the status of its peripherals. This node is intended to allow access to
this functionality.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 .../devicetree/bindings/mfd/ti-keystone-devctrl.txt   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti-keystone-devctrl.txt

diff --git a/Documentation/devicetree/bindings/mfd/ti-keystone-devctrl.txt b/Documentation/devicetree/bindings/mfd/ti-keystone-devctrl.txt
new file mode 100644
index 0000000..20963c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti-keystone-devctrl.txt
@@ -0,0 +1,19 @@
+* Device tree bindings for Texas Instruments keystone device state control
+
+The Keystone II devices have a set of registers that are used to control
+the status of its peripherals. This node is intended to allow access to
+this functionality.
+
+Required properties:
+
+- compatible:		"ti,keystone-devctrl", "syscon"
+
+- reg:			contains offset/length value for device state control
+			registers space.
+
+Example:
+
+devctrl: device-state-control at 0x02620000 {
+	compatible = "ti,keystone-devctrl", "syscon";
+	reg = <0x02620000 0x1000>;
+};
-- 
1.8.3.2
