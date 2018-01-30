From: embed3d@gmail.com (Philipp Rossak)
Date: Tue, 30 Jan 2018 18:46:52 +0100
Subject: [PATCH v5 2/6] media: dt: bindings: Update binding documentation for
 sunxi IR controller
In-Reply-To: <20180130174656.10657-1-embed3d@gmail.com>
References: <20180130174656.10657-1-embed3d@gmail.com>
Message-ID: <20180130174656.10657-3-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates documentation for Device-Tree bindings for sunxi IR
controller and adds the new optional property for the base clock
frequency.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/media/sunxi-ir.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/sunxi-ir.txt b/Documentation/devicetree/bindings/media/sunxi-ir.txt
index 91648c569b1e..278098987edb 100644
--- a/Documentation/devicetree/bindings/media/sunxi-ir.txt
+++ b/Documentation/devicetree/bindings/media/sunxi-ir.txt
@@ -11,6 +11,8 @@ Required properties:
 Optional properties:
 - linux,rc-map-name: see rc.txt file in the same directory.
 - resets : phandle + reset specifier pair
+- clock-frequency  : IR Receiver clock frequency, in Hertz. Defaults to 8 MHz
+		     if missing.
 
 Example:
 
@@ -18,6 +20,7 @@ ir0: ir at 1c21800 {
 	compatible = "allwinner,sun4i-a10-ir";
 	clocks = <&apb0_gates 6>, <&ir0_clk>;
 	clock-names = "apb", "ir";
+	clock-frequency = <3000000>;
 	resets = <&apb0_rst 1>;
 	interrupts = <0 5 1>;
 	reg = <0x01C21800 0x40>;
-- 
2.11.0
