From: manabian@gmail.com (Joachim Eastwood)
Date: Fri,  3 Apr 2015 23:16:05 +0200
Subject: [PATCH 4/6] doc: dt: add documentation for lpc1850-gpio driver
In-Reply-To: <1428095767-6286-1-git-send-email-manabian@gmail.com>
References: <1428095767-6286-1-git-send-email-manabian@gmail.com>
Message-ID: <1428095767-6286-5-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 .../devicetree/bindings/gpio/nxp,lpc1850-gpio.txt  | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/nxp,lpc1850-gpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/nxp,lpc1850-gpio.txt b/Documentation/devicetree/bindings/gpio/nxp,lpc1850-gpio.txt
new file mode 100644
index 000000000000..9326873c887f
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/nxp,lpc1850-gpio.txt
@@ -0,0 +1,23 @@
+NXP LPC18xx/43xx GPIO controller Device Tree Bindings
+-----------------------------------------------------
+
+Required properties:
+- compatible		: Should be "nxp,lpc1850-gpio"
+- reg			: Address and length of the register set for the device
+- clocks		: Clock specifier (see clock bindings for details)
+- gpio-controller	: Marks the device node as a GPIO controller.
+- #gpio-cells 		: Should be two
+			  - First cell is the GPIO line number
+			  - Second cell is used to specify polarity
+
+Optional properties:
+- gpio-ranges		: Mapping between GPIO and logic pin for pinctrl
+
+Examples:
+gpio: gpio at 400f4000 {
+	compatible = "nxp,lpc1850-gpio";
+	reg = <0x400f4000 0x4000>;
+	clocks = <&ccu1 CLK_CPU_GPIO>;
+	gpio-controller;
+	#gpio-cells = <2>;
+}
-- 
1.8.0
