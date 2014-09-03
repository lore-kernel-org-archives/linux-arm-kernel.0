From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed,  3 Sep 2014 10:45:34 +0200
Subject: [PATCH 5/5] rtc: at91sam9: add DT bindings documentation
In-Reply-To: <1409733934-14465-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1409733934-14465-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1409733934-14465-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 .../devicetree/bindings/rtc/atmel,at91sam9-rtc.txt   | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
new file mode 100644
index 0000000..9ca455f
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
@@ -0,0 +1,20 @@
+Atmel AT91SAM9260 Real Time Timer
+
+Required properties:
+- compatible: should be: "atmel,at91sam9260-rtt"
+- reg: should contain 2 memory regions
+  * the first one encodes the memory region of the RTT controller
+  * the second one encodes the GPBR (General Purpose Backup Resgisters)
+    memory region used to store the current time
+- interrupts: rtc alarm/event interrupt
+- clocks: should contain one clock pointing the the slow clk
+
+Example:
+
+rtc at fffffe00 {
+	compatible = "atmel,at91sam9260-rtt";
+	reg = <0xfffffd20 0x10
+	       0xfffffd50 0x4>;
+	interrupts = <1 4 7>;
+	clocks = <&clk32k>;
+};
-- 
1.9.1
