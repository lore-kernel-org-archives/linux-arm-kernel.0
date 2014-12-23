From: Ying.Liu@freescale.com (Liu Ying)
Date: Tue, 23 Dec 2014 18:02:13 +0800
Subject: [PATCH RFC v4 15/21] Documentation: dt-bindings: Add bindings for
 HIMAX HX8369A DRM panel driver
In-Reply-To: <1419328939-22758-1-git-send-email-Ying.Liu@freescale.com>
References: <1419328939-22758-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1419328939-22758-16-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree bindings for HIMAX HX8369A DRM panel driver.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
v3->v4:
 * Newly introduced in v4.  This is separated from the relevant driver patch
   in v3 to address Stefan Wahren's comment.

 .../devicetree/bindings/panel/himax,hx8369a.txt    | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/panel/himax,hx8369a.txt

diff --git a/Documentation/devicetree/bindings/panel/himax,hx8369a.txt b/Documentation/devicetree/bindings/panel/himax,hx8369a.txt
new file mode 100644
index 0000000..36a2f11
--- /dev/null
+++ b/Documentation/devicetree/bindings/panel/himax,hx8369a.txt
@@ -0,0 +1,41 @@
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
+  - reg: the virtual channel number of a DSI peripheral as described in [1]
+  - reset-gpios: a GPIO spec for the reset pin
+
+Optional properties:
+  - vdd1-supply: I/O and interface power supply
+  - vdd2-supply: analog power supply
+  - vdd3-supply: logic power supply
+  - dsi-vcc-supply: DSI and MDDI power supply
+  - vpp-supply: OTP programming voltage
+  - bs0-gpios: a GPIO spec for the pin BS0
+  - bs1-gpios: a GPIO spec for the pin BS1
+  - bs2-gpios: a GPIO spec for the pin BS2
+  - bs3-gpios: a GPIO spec for the pin BS3
+
+[1] Documentation/devicetree/bindings/mipi/dsi/mipi-dsi-bus.txt
+
+Example:
+	panel {
+		compatible = "truly,tft480800-16-e-dsi";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_mipi_panel>;
+		reset-gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
+		bs2-gpios = <&gpio6 14 GPIO_ACTIVE_HIGH>;
+	};
-- 
2.1.0
