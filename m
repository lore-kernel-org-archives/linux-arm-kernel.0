From: linux@baker-net.org.uk (Adam Baker)
Date: Sat,  5 Mar 2016 15:34:55 +0000
Subject: [PATCH v4 1/3] hwmon: Define binding for the nsa320-hwmon driver
In-Reply-To: <1457192097-32538-1-git-send-email-linux@baker-net.org.uk>
References: <1457192097-32538-1-git-send-email-linux@baker-net.org.uk>
Message-ID: <1457192097-32538-2-git-send-email-linux@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define a binding for the hardware monitoring chip present in the Zyxel
NSA-320 and some of the other Zyxel NAS devices.

Signed-off-by: Adam Baker <linux@baker-net.org.uk>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes for v3, Add Robs Ack
---
 .../devicetree/bindings/hwmon/nsa320-mcu.txt        | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/nsa320-mcu.txt

diff --git a/Documentation/devicetree/bindings/hwmon/nsa320-mcu.txt b/Documentation/devicetree/bindings/hwmon/nsa320-mcu.txt
new file mode 100644
index 0000000..7b346d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/nsa320-mcu.txt
@@ -0,0 +1,21 @@
+Bindings for the fan / temperature monitor microcontroller used on
+the Zyxel NSA 320 and several subsequent models.
+
+Required properties:
+- compatible	: "zyxel,nsa320-mcu"
+- data-gpios	: The GPIO pin connected to the data line on the MCU
+- clk-gpios	: The GPIO pin connected to the clock line on the MCU
+- act-gpios	: The GPIO pin connected to the active line on the MCU
+
+Example:
+
+	hwmon {
+		compatible = "zyxel,nsa320-mcu";
+		pinctrl-0 = <&pmx_mcu_data &pmx_mcu_clk &pmx_mcu_act>;
+		pinctrl-names = "default";
+
+		data-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+		clk-gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
+		act-gpios = <&gpio0 17 GPIO_ACTIVE_LOW>;
+	};
+
-- 
2.1.4
