From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 11 Jul 2015 19:28:50 +0200
Subject: [PATCH v3 2/2] doc: dt: add documentation for nxp,lpc1788-rtc
In-Reply-To: <1436635730-15617-1-git-send-email-manabian@gmail.com>
References: <1436635730-15617-1-git-send-email-manabian@gmail.com>
Message-ID: <1436635730-15617-3-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 .../devicetree/bindings/rtc/nxp,lpc1788-rtc.txt     | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.txt b/Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.txt
new file mode 100644
index 000000000000..ad41a040432c
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,lpc1788-rtc.txt
@@ -0,0 +1,21 @@
+NXP LPC1788 real-time clock
+
+The LPC1788 RTC provides calendar and clock functionality
+together with periodic tick and alarm interrupt support.
+
+Required properties:
+- compatible	: must contain "nxp,lpc1788-rtc"
+- reg		: Specifies base physical address and size of the registers.
+- interrupts	: A single interrupt specifier.
+- clocks	: Must contain entries for rtc and register clock
+- clock-names	: Must contain "rtc" and "reg"
+  See ../clocks/clock-bindings.txt for details.
+
+Example:
+rtc: rtc at 40046000 {
+	compatible = "nxp,lpc1788-rtc";
+	reg = <0x40046000 0x1000>;
+	interrupts = <47>;
+	clocks = <&creg_clk 0>, <&ccu1 CLK_CPU_BUS>;
+	clock-names = "rtc", "reg";
+};
-- 
1.8.0
