From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Thu,  5 Jun 2014 17:48:42 +0200
Subject: [PATCH 5/9] Documentation: bindings: add doc for the Berlin USB PHY
In-Reply-To: <1401983326-19205-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1401983326-19205-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1401983326-19205-6-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the bindings of the Marvell Berlin USB PHY driver.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 .../devicetree/bindings/usb/berlin-usbphy.txt          | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/berlin-usbphy.txt

diff --git a/Documentation/devicetree/bindings/usb/berlin-usbphy.txt b/Documentation/devicetree/bindings/usb/berlin-usbphy.txt
new file mode 100644
index 000000000000..d97eb1f9d53f
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/berlin-usbphy.txt
@@ -0,0 +1,18 @@
+* Marvell Berlin USB PHY
+
+Required properties:
+- compatible: should be "marvell,berlin-usbphy"
+- reg: base address and length of the registers
+- #phys-cells: should be 0
+- reset: reference to the reset controller
+- power-gpio: reference the GPIO pin to power the PHY
+
+Example:
+
+	usbphy at f774000 {
+		compatible = "marvell,berlin-usbphy";
+		reg = <0xf774000 0x128>;
+		#phy-cells = <0>;
+		resets = <&chip 14>;
+		power-gpio = <&portb 8 GPIO_ACTIVE_HIGH>;
+	};
-- 
1.9.1
