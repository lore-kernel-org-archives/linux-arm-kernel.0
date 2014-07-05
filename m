From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 05 Jul 2014 11:38:53 +0100
Subject: [PATCH RFC 12/15] dt-bindings: add Marvell Dove LCD controller
 documentation
In-Reply-To: <20140705103724.GN21766@n2100.arm.linux.org.uk>
References: <20140705103724.GN21766@n2100.arm.linux.org.uk>
Message-ID: <E1X3NMr-0000AU-Ez@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Marvell Dove LCD controller DT binding documentation.  The
clock names used here are intentionally taken from the specification
for the Dove SoC.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 .../bindings/drm/armada/marvell,dove-lcd.txt       | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/drm/armada/marvell,dove-lcd.txt

diff --git a/Documentation/devicetree/bindings/drm/armada/marvell,dove-lcd.txt b/Documentation/devicetree/bindings/drm/armada/marvell,dove-lcd.txt
new file mode 100644
index 000000000000..46525ea3e646
--- /dev/null
+++ b/Documentation/devicetree/bindings/drm/armada/marvell,dove-lcd.txt
@@ -0,0 +1,30 @@
+Device Tree bindings for Armada DRM CRTC driver
+
+Required properties:
+ - compatible: value should be "marvell,dove-lcd".
+ - reg: base address and size of the LCD controller
+ - interrupts: single interrupt number for the LCD controller
+ - port: video output port with endpoints, as described by graph.txt
+
+Optional properties:
+
+ - clocks: as described by clock-bindings.txt
+ - clock-names: as described by clock-bindings.txt
+	"axiclk" - axi bus clock for pixel clock
+	"plldivider" - pll divider clock for pixel clock
+	"ext_ref_clk0" - external clock 0 for pixel clock
+	"ext_ref_clk1" - external clock 1 for pixel clock
+
+Note: all clocks are optional but at least one must be specified.
+Further clocks may be added in the future according to requirements of
+different SoCs.
+
+Example:
+
+	lcd0: lcd-controller at 820000 {
+		compatible = "marvell,dove-lcd";
+		reg = <0x820000 0x1000>;
+		interrupts = <47>;
+		clocks = <&si5351 0>;
+		clock-names = "ext_ref_clk_1";
+	};
-- 
1.8.3.1
