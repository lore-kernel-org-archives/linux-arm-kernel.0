From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 27 Dec 2013 21:16:00 +0100
Subject: [PATCH v2 6/8] [RFC] Documentation: dt: Add Renesas RSPI/QSPI bindings
In-Reply-To: <1388175362-17132-1-git-send-email-geert@linux-m68k.org>
References: <1388175362-17132-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1388175362-17132-7-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Cc: devicetree at vger.kernel.org
---
v2:
  - Clarify RSPI/QSPI
  - Add interrupt-parent
  - s/should/must/ for #address-cells and #size-cells

 Documentation/devicetree/bindings/spi/spi-rspi.txt |   31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-rspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-rspi.txt b/Documentation/devicetree/bindings/spi/spi-rspi.txt
new file mode 100644
index 000000000000..504db8917927
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-rspi.txt
@@ -0,0 +1,31 @@
+Device tree configuration for Renesas RSPI/QSPI driver
+
+Required properties:
+- compatible       : For Renesas Serial Peripheral Interface:
+                     "renesas,rspi-<soctype>", "renesas,rspi-rz" as fallback.
+		     For Quad Serial Peripheral Interface:
+		     "renesas,qspi-<soctype>", "renesas,qspi-rcar" as fallback.
+- reg              : address start and address range size of device
+- interrupts       : 3 interrupts for RSPI (SPEI, SPRI, SPTI),
+		     1 interrupt for QSPI
+- interrupt-parent : the phandle for the interrupt controller that
+		     services interrupts for this device.
+- num-cs	   : Number of chip selects
+- #address-cells   : must be <1>
+- #size-cells      : must be <0>
+
+Pinctrl properties might be needed, too. See there.
+
+Example:
+
+	spi0: spi at e800c800 {
+		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
+		reg = <0xe800c800 0x24>;
+		interrupts = <0 238 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 239 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 240 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		num-cs = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
-- 
1.7.9.5
