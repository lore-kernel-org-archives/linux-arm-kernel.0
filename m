From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Tue, 21 Feb 2017 14:55:03 +0800
Subject: [PATCH V2 2/3] Documentation: sprd: Add bindings for SP9860G
In-Reply-To: <1487660104-15693-1-git-send-email-chunyan.zhang@spreadtrum.com>
References: <1487660104-15693-1-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <1487660104-15693-3-git-send-email-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added support for Spreadtrum SP9860G board and SC9860 SoC.
This patch also revised bindings of SC9836 to make the format
more clear.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 Documentation/devicetree/bindings/arm/sprd.txt         | 13 ++++++++-----
 Documentation/devicetree/bindings/serial/sprd-uart.txt | 16 +++++++++++++++-
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/sprd.txt b/Documentation/devicetree/bindings/arm/sprd.txt
index 31a629d..3df034b 100644
--- a/Documentation/devicetree/bindings/arm/sprd.txt
+++ b/Documentation/devicetree/bindings/arm/sprd.txt
@@ -1,11 +1,14 @@
 Spreadtrum SoC Platforms Device Tree Bindings
 ----------------------------------------------------
 
-Sharkl64 is a Spreadtrum's SoC Platform which is based
-on ARM 64-bit processor.
+SC9836 openphone Board
+Required root node properties:
+	- compatible = "sprd,sc9836-openphone", "sprd,sc9836";
 
-SC9836 openphone board with SC9836 SoC based on the
-Sharkl64 Platform shall have the following properties.
+SC9860 SoC
+Required root node properties:
+	- compatible = "sprd,sc9860"
 
+SP9860G 3GFHD Board
 Required root node properties:
-        - compatible = "sprd,sc9836-openphone", "sprd,sc9836";
+	- compatible = "sprd,sp9860g-1h10", "sprd,sc9860";
diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.txt b/Documentation/devicetree/bindings/serial/sprd-uart.txt
index 2aff0f2..f530cbb 100644
--- a/Documentation/devicetree/bindings/serial/sprd-uart.txt
+++ b/Documentation/devicetree/bindings/serial/sprd-uart.txt
@@ -1,7 +1,21 @@
 * Spreadtrum serial UART
 
 Required properties:
-- compatible: must be "sprd,sc9836-uart"
+- compatible must contain:
+  * "sprd,sc9836-uart" for SC9836 and all Spreadtrum SoCs
+  This also can be specific with:
+  * "sprd, sc9860-uart" for SC9860
+
 - reg: offset and length of the register set for the device
 - interrupts: exactly one interrupt specifier
 - clocks: phandles to input clocks.
+
+Example:
+	uart0: serial at 70000000 {
+		compatible = "sprd,sc9838-uart",
+			     "sprd,sc9836-uart";
+		reg = <0x000000 0x100>;
+		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&ext_26m>;
+		status = "disabled";
+	};
-- 
2.7.4
