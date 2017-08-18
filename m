From: martyn.welch@collabora.co.uk (Martyn Welch)
Date: Fri, 18 Aug 2017 16:53:47 +0100
Subject: [PATCH v6 1/2] dt-bindings: misc: achc: Add device tree binding for
 GE ACHC
In-Reply-To: <1503071628-11899-1-git-send-email-martyn.welch@collabora.co.uk>
References: <1503071628-11899-1-git-send-email-martyn.welch@collabora.co.uk>
Message-ID: <1503071628-11899-2-git-send-email-martyn.welch@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Device Tree binding document for GE Healthcare USB Management
Controller (ACHC).

Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
---
 Documentation/devicetree/bindings/misc/ge-achc.txt | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/ge-achc.txt

diff --git a/Documentation/devicetree/bindings/misc/ge-achc.txt b/Documentation/devicetree/bindings/misc/ge-achc.txt
new file mode 100644
index 0000000..77df94d
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/ge-achc.txt
@@ -0,0 +1,26 @@
+* GE Healthcare USB Management Controller
+
+A device which handles data aquisition from compatible USB based peripherals.
+SPI is used for device management.
+
+Note: This device does not expose the peripherals as USB devices.
+
+Required properties:
+
+- compatible : Should be "ge,achc"
+
+Required SPI properties:
+
+- reg : Should be address of the device chip select within
+  the controller.
+
+- spi-max-frequency : Maximum SPI clocking speed of device in Hz, should be
+  1MHz for the GE ACHC.
+
+Example:
+
+spidev0: spi at 0 {
+	compatible = "ge,achc";
+	reg = <0>;
+	spi-max-frequency = <1000000>;
+};
-- 
1.8.3.1
