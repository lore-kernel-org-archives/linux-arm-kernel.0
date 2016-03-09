From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  9 Mar 2016 11:24:10 +0100
Subject: [PATCH v2 08/18] dt-bindings: Add PLX Technology Reset Controller
 bindings
In-Reply-To: <1457519060-6038-1-git-send-email-narmstrong@baylibre.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457519060-6038-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1457519060-6038-9-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/reset/plxtech,reset.txt    | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/plxtech,reset.txt

diff --git a/Documentation/devicetree/bindings/reset/plxtech,reset.txt b/Documentation/devicetree/bindings/reset/plxtech,reset.txt
new file mode 100644
index 0000000..581c974
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/plxtech,reset.txt
@@ -0,0 +1,58 @@
+PLX Technology OXNAS SoC Family RESET Controller
+================================================
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required properties:
+- compatible: Should be "oxsemi,ox810se-reset"
+- #reset-cells: 1, see below
+
+Parent node should have the following properties :
+- compatible: Should be "oxsemi,ox810se-sys-ctrl", "syscon", "simple-mfd"
+
+For OX810SE, the indices are :
+ - 0 : ARM
+ - 1 : COPRO
+ - 2 : Reserved
+ - 3 : Reserved
+ - 4 : USBHS
+ - 5 : USBHSPHY
+ - 6 : MAC
+ - 7 : PCI
+ - 8 : DMA
+ - 9 : DPE
+ - 10 : DDR
+ - 11 : SATA
+ - 12 : SATA_LINK
+ - 13 : SATA_PHY
+ - 14 : Reserved
+ - 15 : NAND
+ - 16 : GPIO
+ - 17 : UART1
+ - 18 : UART2
+ - 19 : MISC
+ - 20 : I2S
+ - 21 : AHB_MON
+ - 22 : UART3
+ - 23 : UART4
+ - 24 : SGDMA
+ - 25 : Reserved
+ - 26 : Reserved
+ - 27 : Reserved
+ - 28 : Reserved
+ - 29 : Reserved
+ - 30 : Reserved
+ - 31 : BUS
+
+example:
+
+sys: sys-ctrl at 000000 {
+	compatible = "oxsemi,ox810se-sys-ctrl", "syscon", "simple-mfd";
+	reg = <0x000000 0x100000>;
+
+	reset: reset-controller {
+		compatible = "oxsemi,ox810se-reset";
+		#reset-cells = <1>;
+	};
+};
-- 
1.9.1
