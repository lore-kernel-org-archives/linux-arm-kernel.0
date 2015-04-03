From: manabian@gmail.com (Joachim Eastwood)
Date: Fri,  3 Apr 2015 23:16:03 +0200
Subject: [PATCH 2/6] doc: dt: add documentation for lpc1850-scu pinctrl driver
In-Reply-To: <1428095767-6286-1-git-send-email-manabian@gmail.com>
References: <1428095767-6286-1-git-send-email-manabian@gmail.com>
Message-ID: <1428095767-6286-3-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 .../bindings/pinctrl/nxp,lpc1850-scu.txt           | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,lpc1850-scu.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/nxp,lpc1850-scu.txt b/Documentation/devicetree/bindings/pinctrl/nxp,lpc1850-scu.txt
new file mode 100644
index 000000000000..b75eaa2517eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/nxp,lpc1850-scu.txt
@@ -0,0 +1,57 @@
+NXP LPC18xx/43xx SCU pin controller Device Tree Bindings
+--------------------------------------------------------
+
+Required properties:
+- compatible		: Should be "nxp,lpc1850-scu"
+- reg			: Address and length of the register set for the device
+- clocks		: Clock specifier (see clock bindings for details)
+
+The lpc1850-scu driver uses the generic pin multiplexing and generic pin
+configuration documented in pinctrl-bindings.txt.
+
+The following generic nodes are supported:
+ - function
+ - pins
+ - bias-disable
+ - bias-pull-up
+ - bias-pull-down
+ - drive-strength
+ - input-enable
+ - input-disable
+ - input-schmitt-enable
+ - input-schmitt-disable
+ - slew-rate
+
+Not all pins support all properties so either refer to the NXP 1850/4350
+user manual or the pin table in the pinctrl-lpc18xx driver for supported
+pin properties.
+
+Example:
+pinctrl: scu at 40086000 {
+	compatible = "nxp,lpc1850-scu";
+	reg = <0x40086000 0x1000>;
+	clocks = <&ccu1 CLK_CPU_SCU>;
+
+	i2c0_pins: i2c0-pins {
+		i2c0_pins_cfg {
+			pins = "i2c0_scl", "i2c0_sda";
+			function = "i2c0";
+			input-enable;
+		};
+	};
+
+	uart0_pins: uart0-pins {
+		uart0_rx_cfg {
+			pins = "pf_11";
+			function = "uart0";
+			bias-disable;
+			input-enable;
+		};
+
+		uart0_tx_cfg {
+			pins = "pf_10";
+			function = "uart0";
+			bias-disable;
+		};
+	};
+};
-- 
1.8.0
