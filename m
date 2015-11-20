From: yrdreddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Fri, 20 Nov 2015 12:56:31 -0500
Subject: [PATCH 1/3] pinctrl: Broadcom NSP pinctrl device tree bindings
Message-ID: <1448042191-1982-1-git-send-email-yrdreddy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree binding documentation for Broadcom NSP IOMUX driver

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yrdreddy@broadcom.com>
---
 .../bindings/pinctrl/brcm,nsp-pinmux.txt           | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,nsp-pinmux.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,nsp-pinmux.txt b/Documentation/devicetree/bindings/pinctrl/brcm,nsp-pinmux.txt
new file mode 100644
index 0000000..603564e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,nsp-pinmux.txt
@@ -0,0 +1,79 @@
+Broadcom NSP (Northstar plus) IOMUX Controller
+
+The NSP IOMUX controller supports group based mux configuration. In
+addition, certain pins can be muxed to GPIO function individually.
+
+Required properties:
+- compatible:
+    Must be "brcm,nsp-pinmux"
+
+- reg:
+    Should contain the register physical address and length for each of
+    GPIO_CONTROL0, GP_AUX_SEL and IPROC_CONFIG IOMUX registers
+
+Properties in subnodes:
+- function:
+    The mux function to select
+
+- groups:
+    The list of groups to select with a given function
+
+For more details, refer to
+Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+
+For example:
+
+	pinmux: pinmux at 1803f1c0 {
+		compatible = "brcm,nsp-pinmux";
+		reg = <0x1803f1c0 0x04>,
+		      <0x18030028 0x04>,
+		      <0x1803f408 0x04>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm &gpio_b &nand_sel>;
+
+		pwm: pwm {
+			function = "pwm";
+			groups = "pwm0_grp", "pwm1_grp";
+		};
+
+		gpio_b: gpio_b {
+			function = "gpio_b";
+			groups = "gpio_b_0_grp", "gpio_b_1_grp";
+		};
+
+		nand_sel: nand_sel {
+			function = "nand";
+			groups = "nand_grp";
+		};
+	};
+
+List of supported functions and groups in Northstar Plus:
+
+"spi": "spi_grp"
+
+"i2c": "i2c_grp"
+
+"mdio": "mdio_grp"
+
+"pwm": "pwm0_grp", "pwm1_grp", "pwm2_grp", "pwm3_grp"
+
+"gpio_b": "gpio_b_0_grp", "gpio_b_1_grp", "gpio_b_2_grp", "gpio_b_3_grp"
+
+"uart1": "uart1_grp"
+
+"uart2": "uart2_grp"
+
+"synce": "synce_grp"
+
+"sata_led_grps": "sata0_led_grp", "sata1_led_grp"
+
+"xtal_out": "xtal_out_grp"
+
+"sdio": "sdio_pwr_grp", "sdio_1p8v_grp"
+
+"switch_led": "switch_p05_led0_grp", "switch_p05_led1_grp"
+
+"nand": "nand_grp"
+
+"emmc": "emmc_grp"
-- 
2.1.0
