From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 16 Aug 2015 20:10:17 +0200
Subject: [PATCH v2 2/2] doc: dt: add documentation for nxp,lpc1788-i2c
In-Reply-To: <1439748617-7683-1-git-send-email-manabian@gmail.com>
References: <1439748617-7683-1-git-send-email-manabian@gmail.com>
Message-ID: <1439748617-7683-3-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding documentation for the nxp,lpc1788-i2c controller
which also can be found on LPC2xxx, LPC178x/7x and LPC18xx/43xx
devices.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 .../devicetree/bindings/i2c/i2c-lpc2k.txt          | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-lpc2k.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-lpc2k.txt b/Documentation/devicetree/bindings/i2c/i2c-lpc2k.txt
new file mode 100644
index 000000000000..4101aa621ad4
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-lpc2k.txt
@@ -0,0 +1,33 @@
+NXP I2C controller for LPC2xxx/178x/18xx/43xx
+
+Required properties:
+ - compatible: must be "nxp,lpc1788-i2c"
+ - reg: physical address and length of the device registers
+ - interrupts: a single interrupt specifier
+ - clocks: clock for the device
+ - #address-cells: should be <1>
+ - #size-cells: should be <0>
+
+Optional properties:
+- clock-frequency: the desired I2C bus clock frequency in Hz; in
+  absence of this property the default value is used (100 kHz).
+
+Example:
+i2c0: i2c at 400a1000 {
+	compatible = "nxp,lpc1788-i2c";
+	reg = <0x400a1000 0x1000>;
+	interrupts = <18>;
+	clocks = <&ccu1 CLK_APB1_I2C0>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+};
+
+&i2c0 {
+	clock-frequency = <400000>;
+
+	lm75 at 48 {
+		compatible = "nxp,lm75";
+		reg = <0x48>;
+	};
+};
+
-- 
1.8.0
