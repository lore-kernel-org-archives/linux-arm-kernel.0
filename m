From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 28 Feb 2017 07:35:13 +0100
Subject: [PATCH v3 03/25] dt-bindings: timer: Document Owl timer
In-Reply-To: <20170228063535.32069-1-afaerber@suse.de>
References: <20170228063535.32069-1-afaerber@suse.de>
Message-ID: <20170228063535.32069-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Actions Semi S500 SoC contains a timer block with two 2 Hz and two
32-bit timers. The S900 SoC timer block has four 32-bit timers.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2 -> v3:
 * Adopted interrupt-names
 * Changed compatible for S500
 * Added S900 compatible and interrupt names
 
 v2: new
 
 .../devicetree/bindings/timer/actions,owl-timer.txt  | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/actions,owl-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/actions,owl-timer.txt b/Documentation/devicetree/bindings/timer/actions,owl-timer.txt
new file mode 100644
index 0000000..5b4834d
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/actions,owl-timer.txt
@@ -0,0 +1,20 @@
+Actions Semi Owl Timer
+
+Required properties:
+- compatible      :  "actions,s500-timer" for S500
+                     "actions,s900-timer" for S900
+- reg             :  Offset and length of the register set for the device.
+- interrupts      :  Should contain the interrupts.
+- interrupt-names :  Valid names are: "2Hz0", "2Hz1",
+                                      "Timer0", "Timer1", "Timer2", "Timer3"
+                     See ../resource-names.txt
+
+Example:
+
+		timer at b0168000 {
+			compatible = "actions,s500-timer";
+			reg = <0xb0168000 0x100>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "Timer0", "Timer1";
+		};
-- 
2.10.2
