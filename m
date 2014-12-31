From: Ying.Liu@freescale.com (Liu Ying)
Date: Wed, 31 Dec 2014 16:23:33 +0800
Subject: [PATCH RFC v8 15/21] Documentation: dt-bindings: Add bindings for
 Himax HX8369A DRM panel driver
In-Reply-To: <1420014219-915-1-git-send-email-Ying.Liu@freescale.com>
References: <1420014219-915-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1420014219-915-16-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree bindings for Himax HX8369A DRM panel driver.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
v7->v8:
 * None.

v6->v7:
 * None.

v5->v6:
 * None.

v4->v5:
 * Merge the bs[3:0]-gpios properties into one property - bs-gpios.
   This addresses Andrzej Hajda's comment.

v3->v4:
 * Newly introduced in v4.  This is separated from the relevant driver patch
   in v3 to address Stefan Wahren's comment.

 .../devicetree/bindings/panel/himax,hx8369a.txt    | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/panel/himax,hx8369a.txt

diff --git a/Documentation/devicetree/bindings/panel/himax,hx8369a.txt b/Documentation/devicetree/bindings/panel/himax,hx8369a.txt
new file mode 100644
index 0000000..3a44b70
--- /dev/null
+++ b/Documentation/devicetree/bindings/panel/himax,hx8369a.txt
@@ -0,0 +1,39 @@
+Himax HX8369A WVGA 16.7M color TFT single chip driver with internal GRAM
+
+Himax HX8369A is a WVGA resolution driving controller.
+It is designed to provide a single chip solution that combines a source
+driver and power supply circuits to drive a TFT dot matrix LCD with
+480RGBx864 dots at the maximum.
+
+The HX8369A supports several interface modes, including MPU MIPI DBI Type
+A/B mode, MIPI DPI/DBI Type C mode, MIPI DSI video mode, MIPI DSI command
+mode and MDDI mode. The interface mode is selected by the external hardware
+pins BS[3:0].
+
+Currently, only the MIPI DSI video mode is supported.
+
+Required properties:
+  - compatible: should be a panel's compatible string
+  - reg: the virtual channel number of a DSI peripheral, as described in [1]
+  - reset-gpios: a GPIO spec for the reset pin, as described in [2]
+
+Optional properties:
+  - vdd1-supply: I/O and interface power supply
+  - vdd2-supply: analog power supply
+  - vdd3-supply: logic power supply
+  - dsi-vcc-supply: DSI and MDDI power supply
+  - vpp-supply: OTP programming voltage
+  - bs-gpios: a GPIO spec for the pins BS[3:0], as described in [2]
+
+[1] Documentation/devicetree/bindings/mipi/dsi/mipi-dsi-bus.txt
+[2] Documentation/devicetree/bindings/gpio/gpio.txt
+
+Example:
+	panel {
+		compatible = "truly,tft480800-16-e-dsi";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_mipi_panel>;
+		reset-gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
+		bs-gpios = <0>, <0>, <&gpio6 14 GPIO_ACTIVE_HIGH>, <0>;
+	};
-- 
2.1.0
