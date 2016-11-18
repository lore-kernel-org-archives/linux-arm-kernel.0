From: robertcnelson@gmail.com (Robert Nelson)
Date: Thu, 17 Nov 2016 20:44:33 -0600
Subject: [RFC 3/6] Documentation: dt: add bindings for ti bb2d
In-Reply-To: <20161118024436.13447-1-robertcnelson@gmail.com>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
Message-ID: <20161118024436.13447-3-robertcnelson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gowtham Tammana <g-tammana@ti.com>

Add documentation for device tree bindings description for
2D GPU blitter module present in Texas Instruments family of SoCs.

Signed-off-by: Gowtham Tammana <g-tammana@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 Documentation/devicetree/bindings/gpu/ti-bb2d.txt | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/ti-bb2d.txt

diff --git a/Documentation/devicetree/bindings/gpu/ti-bb2d.txt b/Documentation/devicetree/bindings/gpu/ti-bb2d.txt
new file mode 100644
index 0000000..af47488
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/ti-bb2d.txt
@@ -0,0 +1,27 @@
+* Texas Instruments BB2D blitter module
+
+This binding describes the 2D BitBlit (BB2D) graphics accelerator
+subsystem based on the GC320 core from Vivante Corporation available
+in Texas Instruments SoCs.
+
+Required properties:
+  - compatible: value should take the following format:
+        "ti,<soc>-bb2d", "vivante,<gpuversion>"
+    accepted values:
+     (a) "ti,dra7-bb2d", "vivante,gc320" for TI DRA7xx / AM57x
+
+  - reg : base address and length of BB2D IP registers
+  - interrupts : BB2D interrupt line number
+  - ti,hwmods : name of the hwmod associated with BB2D module
+  - clocks : handle to BB2D functional clock
+  - clock-names : fclk
+
+Example for DRA7x SoC:
+        bb2d: bb2d at 59000000 {
+            compatible = "ti,dra7-bb2d", "vivante,gc320";
+            reg = <0x59000000 0x0700>;
+            interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+            ti,hwmods = "bb2d";
+            clocks = <&dpll_core_h24x2_ck>;
+            clock-names = "fclk";
+        };
-- 
2.10.2
