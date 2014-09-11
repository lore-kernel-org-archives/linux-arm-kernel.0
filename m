From: carlo@caione.org (Carlo Caione)
Date: Thu, 11 Sep 2014 22:11:33 +0200
Subject: [PATCH v2 2/9] ARM: meson: documentation: add UART documentation
In-Reply-To: <1410466300-19168-1-git-send-email-carlo@caione.org>
References: <1410466300-19168-1-git-send-email-carlo@caione.org>
Message-ID: <1410466300-19168-3-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 .../devicetree/bindings/serial/amlogic,meson-uart.txt   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt

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
-- 
1.9.1
