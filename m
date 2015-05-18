From: eric@anholt.net (Eric Anholt)
Date: Mon, 18 May 2015 12:43:33 -0700
Subject: [PATCH 1/7] dt/bindings: Add binding for the Raspberry Pi clock
 provider
In-Reply-To: <1431978219-14226-1-git-send-email-eric@anholt.net>
References: <1431978219-14226-1-git-send-email-eric@anholt.net>
Message-ID: <1431978219-14226-2-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hardware clocks are not controllable by the ARM, so we have to
make requests to the firmware to do so from the VPU side.  This will
let us replace fixed clocks in our DT with actual clock control (and
correct frequency information).

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../bindings/clock/raspberrypi,firmware-clocks.txt | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/raspberrypi,firmware-clocks.txt

diff --git a/Documentation/devicetree/bindings/clock/raspberrypi,firmware-clocks.txt b/Documentation/devicetree/bindings/clock/raspberrypi,firmware-clocks.txt
new file mode 100644
index 0000000..9e1f21b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/raspberrypi,firmware-clocks.txt
@@ -0,0 +1,24 @@
+Raspberry Pi firmware clock provider.
+
+The Raspberry Pi architecture doesn't provide direct access to the
+CLOCKMAN peripheral from the ARM side, so Linux has to make requests
+to the VPU firmware to program them.
+
+This binding uses the common clock binding:
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible:	Should be "raspberrypi,firmware-clocks"
+
+- #clock-cells:	Shall have value <1>.  The permitted clock-specifier values
+		  can be found in include/dt-bindings/clk/raspberrypi.h.
+
+- firmware:	Phandle to the firmware driver node.
+
+Example:
+
+firmware_clocks: firmware-clocks {
+	compatible = "raspberrypi,firmware-clocks";
+	#clock-cells = <1>;
+	firmware = <&firmware>;
+};
-- 
2.1.4
