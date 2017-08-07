From: david@lechnology.com (David Lechner)
Date: Mon,  7 Aug 2017 12:39:38 -0500
Subject: [PATCH v4 2/5] dt-bindings: add binding for Sitronix ST7586 display
 panels
In-Reply-To: <1502127581-10517-1-git-send-email-david@lechnology.com>
References: <1502127581-10517-1-git-send-email-david@lechnology.com>
Message-ID: <1502127581-10517-3-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a new binding for Sitronix ST7586 display panels.

Using lego as the vendor prefix in the compatible string because the display
panel I am working with is an integral part of the LEGO MINDSTORMS EV3.

Signed-off-by: David Lechner <david@lechnology.com>
---

v4 changes:
* Dropped optional properties and only use pins actually used on LEGO EV3.
* Rename dc to a0 since that is what is on the datasheet/LEGO schematic.


 .../bindings/display/sitronix,st7586.txt           | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sitronix,st7586.txt

diff --git a/Documentation/devicetree/bindings/display/sitronix,st7586.txt b/Documentation/devicetree/bindings/display/sitronix,st7586.txt
new file mode 100644
index 0000000..1d0dad1
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sitronix,st7586.txt
@@ -0,0 +1,22 @@
+Sitronix ST7586 display panel
+
+Required properties:
+- compatible:	"lego,ev3-lcd".
+- a0-gpios:	The A0 signal (since this binding is for serial mode, this is
+                the pin labeled D1 on the controller, not the pin labeled A0)
+- reset-gpios:	Reset pin
+
+The node for this driver must be a child node of a SPI controller, hence
+all mandatory properties described in ../spi/spi-bus.txt must be specified.
+
+Optional properties:
+- rotation:	panel rotation in degrees counter clockwise (0,90,180,270)
+
+Example:
+	display at 0{
+		compatible = "lego,ev3-lcd";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+		a0-gpios = <&gpio 43 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio 80 GPIO_ACTIVE_HIGH>;
+	};
-- 
2.7.4
