From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 24 Jan 2015 16:05:00 +0100
Subject: [PATCH v4 1/4] dt-bindings: mfd: add lubbock-cplds binding
Message-ID: <1422111903-22176-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a binding for lubbock motherboard IO board.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v3: name change to lubbock-cplds,
          Lee's comments taken into account.
---
 .../devicetree/bindings/mfd/lubbock-cplds.txt      | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/lubbock-cplds.txt

diff --git a/Documentation/devicetree/bindings/mfd/lubbock-cplds.txt b/Documentation/devicetree/bindings/mfd/lubbock-cplds.txt
new file mode 100644
index 0000000..211ed9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/lubbock-cplds.txt
@@ -0,0 +1,26 @@
+Intel XScale PXA255 development platform (Lubbock).
+
+This regroups all the CPLDs on the Lubbock motherboard, providing interrupt
+muxing, leds handling, ...
+
+Required properties:
+  - compatible : should be "intel,lubbock-cplds"
+
+  - interrupts : The first interrupt is the SoC input interrupt connected to the
+                 lubbock IO board interrupt multiplexer output. The only known
+                 working conifguration is GPIO0 on the PXA25X SoC.
+
+Optional properties:
+  - interrupts : The second optional interrupt is the base of the interrupts
+                 multiplexed by the lubbock motherboard. If unspecified, the
+                 range is fully dynamic, and the irqdomain will generate its
+                 interrupt base on the fly.
+
+Example:
+
+mb: lubbock-mb at 0 {
+	compatible = "intel,lubbock-cplds";
+	interrupts = <0 IRQ_TYPE_EDGE_FALLING 400 IRQ_TYPE_NONE>;
+	#interrupt-cells = <2>;
+	interrupt-parent = <&pxairq>;
+};
-- 
2.1.0
