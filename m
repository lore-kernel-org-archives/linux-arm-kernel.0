From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 23 Jan 2014 19:30:28 +1300
Subject: [PATCH] serial: vt8500: Add missing binding document for arch-vt8500
 serial driver.
Message-ID: <1390458628-30152-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The binding document for the vt8500/wm8xxx SoC UART driver is missing.
This patch adds the binding document.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 .../devicetree/bindings/serial/vt8500-uart.txt     |   26 ++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/vt8500-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/vt8500-uart.txt b/Documentation/devicetree/bindings/serial/vt8500-uart.txt
new file mode 100644
index 0000000..795c393
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/vt8500-uart.txt
@@ -0,0 +1,26 @@
+* VIA VT8500 and WonderMedia WM8xxx UART Controller
+
+Required properties:
+- compatible: should be "via,vt8500-uart"
+
+- reg: base physical address of the controller and length of memory mapped
+	region.
+
+- interrupts: hardware interrupt number
+
+- clocks: shall be the input parent clock phandle for the clock. This should
+	be the 24Mhz reference clock.
+
+Aliases may be defined to ensure the correct ordering of the uarts.
+
+Example:
+	aliases {
+		serial0 = &uart0;
+	};
+
+	uart0: serial at d8200000 {
+		compatible = "via,vt8500-uart";
+		reg = <0xd8200000 0x1040>;
+		interrupts = <32>;
+		clocks = <&clkuart0>;
+	};
-- 
1.7.9.5
