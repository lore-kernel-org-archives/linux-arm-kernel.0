From: carlo@caione.org (Carlo Caione)
Date: Sun, 17 Aug 2014 12:49:54 +0200
Subject: [PATCH 7/7] ARM: meson: update documentation (uart, timer and vendors)
In-Reply-To: <1408272594-10814-1-git-send-email-carlo@caione.org>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
Message-ID: <1408272594-10814-8-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New UART and timer bindings are documented. A new vendor is added to the
vendors list.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 .../devicetree/bindings/serial/amlogic,meson-uart.txt   | 17 +++++++++++++++++
 .../devicetree/bindings/timer/amlogic,meson6-timer.txt  | 16 ++++++++++++++++
 Documentation/devicetree/bindings/vendor-prefixes.txt   |  1 +
 3 files changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
 create mode 100644 Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
new file mode 100644
index 0000000..fa1935a
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
@@ -0,0 +1,17 @@
+Amlogic Meson UART
+
+Required properties:
+- compatible : Should be "amlogic,meson-uart"
+- reg : Address and length of the register set
+- interrupts : Should contain uart interrupt
+- clocks: phandle to the source clock
+
+Example:
+
+uart0: serial at c81004c0 {
+	compatible = "amlogic,meson-uart";
+	reg = <0xc81004c0 0x14>;
+	interrupts = <0 90 1>;
+	clocks = <&clk81>;
+};
+
diff --git a/Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt b/Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt
new file mode 100644
index 0000000..cf89894
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt
@@ -0,0 +1,16 @@
+Amlogic Meson6 SoCs Timer Controller
+
+Required properties:
+
+- compatible : should be "amlogic,meson6-timer.txt"
+- reg : Specifies base physical address and size of the registers.
+- interrupts : The interrupt of the first timer
+
+Example:
+
+timer at c1109940 {
+	compatible = "amlogic,meson6-timer";
+	reg = <0xc1109940 0x14>;
+	interrupts = <0 10 1>;
+};
+
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ac7269f..5cf0618 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -14,6 +14,7 @@ allwinner	Allwinner Technology Co., Ltd.
 altr	Altera Corp.
 amcc	Applied Micro Circuits Corporation (APM, formally AMCC)
 amd	Advanced Micro Devices (AMD), Inc.
+amlogic	Amlogic, Inc.
 ams	AMS AG
 amstaos	AMS-Taos Inc.
 apm	Applied Micro Circuits Corporation (APM)
-- 
1.9.1
