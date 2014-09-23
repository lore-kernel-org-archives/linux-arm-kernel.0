From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue, 23 Sep 2014 16:48:44 +0200
Subject: [PATCH v9 09/10] rtc: at91sam9: add DT bindings documentation
In-Reply-To: <1411483725-31532-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1411483725-31532-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1411483725-31532-10-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add RTT bindings documentation.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Johan Hovold <johan@kernel.org>
---
 .../devicetree/bindings/rtc/atmel,at91sam9-rtc.txt | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
new file mode 100644
index 0000000..6ae79d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
@@ -0,0 +1,23 @@
+Atmel AT91SAM9260 Real Time Timer
+
+Required properties:
+- compatible: should be: "atmel,at91sam9260-rtt"
+- reg: should encode the memory region of the RTT controller
+- interrupts: rtt alarm/event interrupt
+- clocks: should contain the 32 KHz slow clk that will drive the RTT block.
+- atmel,rtt-rtc-time-reg: should encode the GPBR register used to store
+	the time base when the RTT is used as an RTC.
+	The first cell should point to the GPBR node and the second one
+	encode the offset within the GPBR block (or in other words, the
+	GPBR register used to store the time base).
+
+
+Example:
+
+rtt at fffffd20 {
+	compatible = "atmel,at91sam9260-rtt";
+	reg = <0xfffffd20 0x10>;
+	interrupts = <1 4 7>;
+	clocks = <&clk32k>;
+	atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
+};
-- 
1.9.1
