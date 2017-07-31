From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:04:28 +0200
Subject: [PATCH 2/5] dt-bindings: sram: Document renesas,smp-sram
In-Reply-To: <cover.1501512759.git.horms+renesas@verge.net.au>
References: <cover.1501512759.git.horms+renesas@verge.net.au>
Message-ID: <d5f2ac6ae9931227d8ccd71c12182e547ec28c21.1501512759.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Document reserved SRAM for the SMP jump stub on Renesas R-Car Gen2 and
RZ/G1 SoCs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../devicetree/bindings/sram/renesas,smp-sram.txt  | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sram/renesas,smp-sram.txt

diff --git a/Documentation/devicetree/bindings/sram/renesas,smp-sram.txt b/Documentation/devicetree/bindings/sram/renesas,smp-sram.txt
new file mode 100644
index 000000000000..712d05e3e15e
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
2.1.4
