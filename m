From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 23 Aug 2012 16:01:26 +0100
Subject: [PATCH 2/3] Documentation: Device Tree binding information for
 i2c-nomadik driver
In-Reply-To: <1345734087-21803-1-git-send-email-lee.jones@linaro.org>
References: <1345734087-21803-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1345734087-21803-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This document describes each of the non-standard Device Tree bindings
used in the Nomadik I2C driver.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/i2c/nomadik.txt |   23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/nomadik.txt

diff --git a/Documentation/devicetree/bindings/i2c/nomadik.txt b/Documentation/devicetree/bindings/i2c/nomadik.txt
new file mode 100644
index 0000000..72065b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/nomadik.txt
@@ -0,0 +1,23 @@
+I2C for Nomadik based systems
+
+Required (non-standard) properties:
+ - Nil
+
+Recommended (non-standard) properties:
+ - clock-frequency : Maximum bus clock frequency for the device
+
+Optional (non-standard) properties:
+ - Nil
+
+Example :
+
+i2c at 80004000 {
+        compatible = "stericsson,db8500-i2c", "st,nomadik-i2c";
+        reg = <0x80004000 0x1000>;
+        interrupts = <0 21 0x4>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        v-i2c-supply = <&db8500_vape_reg>;
+
+        clock-frequency = <400000>;
+};
-- 
1.7.9.5
