From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  5 Oct 2012 16:31:42 +0100
Subject: [PATCH 06/10] Documentation: Describe bindings for STMPE
 Multi-Functional Device driver
In-Reply-To: <1349451107-8009-1-git-send-email-lee.jones@linaro.org>
References: <1349451107-8009-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1349451107-8009-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we add the required documentation for the STMPE Multi-Functional
Device (MFD) Device Tree bindings. It describes all of the bindings
currently supported by the driver.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/mfd/stmpe.txt |   25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/stmpe.txt

diff --git a/Documentation/devicetree/bindings/mfd/stmpe.txt b/Documentation/devicetree/bindings/mfd/stmpe.txt
new file mode 100644
index 0000000..8f0aeda
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/stmpe.txt
@@ -0,0 +1,25 @@
+* STMPE Multi-Functional Device
+
+Required properties:
+ - compatible                   : "st,stmpe[811|1601|2401|2403]"
+ - reg                          : I2C address of the device
+
+Optional properties:
+ - interrupts                   : The interrupt outputs from the controller
+ - interrupt-controller         : Marks the device node as an interrupt controller
+ - interrupt-parent             : Specifies which IRQ controller we're connected to
+ - i2c-client-wake              : Marks the input device as wakable
+ - st,autosleep-timeout         : Valid entries (ms); 4, 16, 32, 64, 128, 256, 512 and 1024
+
+Example:
+
+	stmpe1601: stmpe1601 at 40 {
+		compatible = "st,stmpe1601";
+		reg = <0x40>;
+		interrupts = <26 0x4>;
+		interrupt-parent = <&gpio6>;
+		interrupt-controller;
+
+		i2c-client-wake;
+		st,autosleep-timeout = <1024>;
+	};
-- 
1.7.9.5
