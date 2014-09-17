From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 17 Sep 2014 16:30:49 +0200
Subject: [PATCH 1/2] devicetree: cadence_ttc: Document binding for timer width
Message-ID: <3537996136ec435ea660da869102d0a019214979.1410964243.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Crosthwaite <peter.crosthwaite@xilinx.com>

Modern TTC implementations can extend the timer width to 32 bit. This
feature is not self identifying so the driver needs to be made aware
via device tree.

Signed-off-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 Documentation/devicetree/bindings/timer/cadence,ttc-timer.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/cadence,ttc-timer.txt b/Documentation/devicetree/bindings/timer/cadence,ttc-timer.txt
index 993695c659e1..5439976eca6b 100644
--- a/Documentation/devicetree/bindings/timer/cadence,ttc-timer.txt
+++ b/Documentation/devicetree/bindings/timer/cadence,ttc-timer.txt
@@ -6,6 +6,9 @@ Required properties:
 - interrupts : A list of 3 interrupts; one per timer channel.
 - clocks: phandle to the source clock

+Optional properties:
+- timer-width: Bit width of the timer. Either 16 or 32 (default 16).
+
 Example:

 ttc0: ttc0 at f8001000 {
@@ -14,4 +17,5 @@ ttc0: ttc0 at f8001000 {
 	compatible = "cdns,ttc";
 	reg = <0xF8001000 0x1000>;
 	clocks = <&cpu_clk 3>;
+	timer-width = <32>;
 };
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140917/5d826bf5/attachment-0001.sig>
