From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  6 Jun 2017 02:54:01 +0200
Subject: [PATCH v4 03/28] dt-bindings: timer: Document Owl timer
In-Reply-To: <20170606005426.26446-1-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
Message-ID: <20170606005426.26446-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Actions Semi S500 SoC contains a timer block with two 2 Hz and two
32-bit timers. The S900 SoC timer block has four 32-bit timers.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3 -> v4:
 * Changed interrupt names to lower-case (Mark)
 
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
index 000000000000..e3c28da80cb2
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
+- interrupt-names :  Valid names are: "2hz0", "2hz1",
+                                      "timer0", "timer1", "timer2", "timer3"
+                     See ../resource-names.txt
+
+Example:
+
+		timer at b0168000 {
+			compatible = "actions,s500-timer";
+			reg = <0xb0168000 0x100>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "timer0", "timer1";
+		};
-- 
2.12.3
