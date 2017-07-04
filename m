From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  4 Jul 2017 17:41:35 +0200
Subject: [PATCH 1/9] dt-bindings: sram: Document renesas,smp-sram
In-Reply-To: <1499182903-31339-1-git-send-email-geert+renesas@glider.be>
References: <1499182903-31339-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1499182903-31339-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document reserved SRAM for the SMP jump stub on Renesas R-Car Gen2 and
RZ/G1 SoCs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/sram/renesas,smp-sram.txt  | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sram/renesas,smp-sram.txt

diff --git a/Documentation/devicetree/bindings/sram/renesas,smp-sram.txt b/Documentation/devicetree/bindings/sram/renesas,smp-sram.txt
new file mode 100644
index 0000000000000000..712d05e3e15eeb65
--- /dev/null
+++ b/Documentation/devicetree/bindings/sram/renesas,smp-sram.txt
@@ -0,0 +1,27 @@
+* Renesas SMP SRAM
+
+Renesas R-Car Gen2 and RZ/G1 SoCs need a small piece of SRAM for the jump stub
+for secondary CPU bringup and CPU hotplug.
+This memory is reserved by adding a child node to a "mmio-sram" node, cfr.
+Documentation/devicetree/bindings/sram/sram.txt.
+
+Required child node properties:
+  - compatible: Must be "renesas,smp-sram",
+  - reg: Address and length of the reserved SRAM.
+    The full physical (bus) address must be aligned to a 256 KiB boundary.
+
+
+Example:
+
+	icram1:	sram at e63c0000 {
+		compatible = "mmio-sram";
+		reg = <0 0xe63c0000 0 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0xe63c0000 0x1000>;
+
+		smp-sram at 0 {
+			compatible = "renesas,smp-sram";
+			reg = <0 0x10>;
+		};
+	};
-- 
2.7.4
