From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 11 Sep 2014 10:56:07 +0200
Subject: [PATCH v3 8/8] rtc: at91sam9: add DT bindings documentation
In-Reply-To: <1410425767-17874-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1410425767-17874-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1410425767-17874-9-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 .../devicetree/bindings/rtc/atmel,at91sam9-rtc.txt | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
new file mode 100644
index 0000000..258a036
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
@@ -0,0 +1,24 @@
+Atmel AT91SAM9260 Real Time Timer
+
+Required properties:
+- compatible: should be: "atmel,at91sam9260-rtt"
+- reg: should encode the memory region of the RTT controller
+- interrupts: rtc alarm/event interrupt
+- clocks: should contain one clock pointing the the slow clk
+- atmel,time-reg: should encode the GPBR register used to store the RTC
+		  time. The first cell should point to the GPBR node and
+		  the second one encode the offset within the GPBR block
+		  (or in other terms, the GPBR register used to store the
+		  current time value).
+
+
+
+Example:
+
+rtc at fffffe00 {
+	compatible = "atmel,at91sam9260-rtt";
+	reg = <0xfffffd20 0x10>;
+	interrupts = <1 4 7>;
+	clocks = <&clk32k>;
+	atmel,time-reg = <&gpbr 0x0>;
+};
-- 
1.9.1
