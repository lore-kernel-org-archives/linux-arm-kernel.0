From: bay@hackerdom.ru (Alexander Bersenev)
Date: Sat, 21 Jun 2014 17:04:02 +0600
Subject: [PATCH v10 1/5] ARM: sunxi: Add documentation for sunxi consumer
 infrared devices
In-Reply-To: <1403348646-31091-1-git-send-email-bay@hackerdom.ru>
References: <1403348646-31091-1-git-send-email-bay@hackerdom.ru>
Message-ID: <1403348646-31091-2-git-send-email-bay@hackerdom.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation for Device-Tree bindings for sunxi IR
controller.

Signed-off-by: Alexander Bersenev <bay@hackerdom.ru>
Signed-off-by: Alexsey Shestacov <wingrime@linux-sunxi.org>
---
 .../devicetree/bindings/media/sunxi-ir.txt         |   23 ++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/sunxi-ir.txt

diff --git a/Documentation/devicetree/bindings/media/sunxi-ir.txt b/Documentation/devicetree/bindings/media/sunxi-ir.txt
new file mode 100644
index 0000000..014dd8b
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/sunxi-ir.txt
@@ -0,0 +1,23 @@
+Device-Tree bindings for SUNXI IR controller found in sunXi SoC family
+
+Required properties:
+- compatible	    : should be "allwinner,sun7i-a20-ir";
+- clocks	    : list of clock specifiers, corresponding to
+		      entries in clock-names property;
+- clock-names	    : should contain "apb" and "ir" entries;
+- interrupts	    : should contain IR IRQ number;
+- reg		    : should contain IO map address for IR.
+
+Optional properties:
+- linux,rc-map-name : Remote control map name.
+
+Example:
+
+ir0: ir at 01c21800 {
+	compatible = "allwinner,sun7i-a20-ir";
+	clocks = <&apb0_gates 6>, <&ir0_clk>;
+	clock-names = "apb", "ir";
+	interrupts = <0 5 1>;
+	reg = <0x01C21800 0x40>;
+	linux,rc-map-name = "rc-rc6-mce";
+};
-- 
1.7.1
