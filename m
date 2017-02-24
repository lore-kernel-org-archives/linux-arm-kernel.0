From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 24 Feb 2017 04:40:41 +0100
Subject: [RFC v2 03/17] dt-bindings: timer: Document Owl timer
In-Reply-To: <20170224034055.18807-1-afaerber@suse.de>
References: <20170224034055.18807-1-afaerber@suse.de>
Message-ID: <20170224034055.18807-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Actions Semi S500 SoC contains a timer block with two timers.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: new
 
 .../devicetree/bindings/timer/actions,owl-timer.txt      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/actions,owl-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/actions,owl-timer.txt b/Documentation/devicetree/bindings/timer/actions,owl-timer.txt
new file mode 100644
index 0000000..141bc7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/actions,owl-timer.txt
@@ -0,0 +1,16 @@
+Actions Semi Owl Timer
+
+Required properties:
+- compatible :  "actions,owl-timer"
+- reg        :  Offset and length of the register set for the device.
+- interrupts :  Should contain two timer interrupts.
+
+
+Example:
+
+		timer at b0168000 {
+			compatible = "actions,owl-timer";
+			reg = <0xb0168000 0x100>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		};
-- 
2.10.2
