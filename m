From: carlo.caione@gmail.com (Carlo Caione)
Date: Sat, 16 Nov 2013 18:33:53 +0100
Subject: [PATCH v4 1/2] ARM: sun4i/sun7i: DT documentation for RTC driver
Message-ID: <1384623234-9334-1-git-send-email-carlo.caione@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT documentation for SUNXI RTC driver

Signed-off-by: Carlo Caione <carlo.caione@gmail.com>
---
 Documentation/devicetree/bindings/rtc/sunxi-rtc.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/sunxi-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/sunxi-rtc.txt b/Documentation/devicetree/bindings/rtc/sunxi-rtc.txt
new file mode 100644
index 0000000..7cb9dbf
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/sunxi-rtc.txt
@@ -0,0 +1,17 @@
+* sun4i/sun7i Real Time Clock
+
+RTC controller for the Allwinner A10/A20
+
+Required properties:
+- compatible : Should be "allwinner,sun4i-rtc" or "allwinner,sun7i-a20-rtc"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: IRQ line for the RTC.
+
+Example:
+
+rtc: rtc at 01c20d00 {
+	compatible = "allwinner,sun4i-rtc";
+	reg = <0x01c20d00 0x20>;
+	interrupts = <24>;
+};
-- 
1.8.4.2
