From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Tue,  6 Jun 2017 16:08:47 -0500
Subject: [PATCH v8 12/24] drivers/fsi: Add documentation for GPIO bindings
In-Reply-To: <20170606210859.80431-1-cbostic@linux.vnet.ibm.com>
References: <20170606210859.80431-1-cbostic@linux.vnet.ibm.com>
Message-ID: <20170606210859.80431-13-cbostic@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add fsi master gpio device tree binding documentation.

Includes changes from Jeremy Kerr <jk@ozlabs.org>.

Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/fsi/fsi-master-gpio.txt    | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt

diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt b/Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt
new file mode 100644
index 0000000..a767259
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt
@@ -0,0 +1,24 @@
+Device-tree bindings for gpio-based FSI master driver
+-----------------------------------------------------
+
+Required properties:
+ - compatible = "fsi-master-gpio";
+ - clock-gpios = <gpio-descriptor>;	: GPIO for FSI clock
+ - data-gpios = <gpio-descriptor>;	: GPIO for FSI data signal
+
+Optional properties:
+ - enable-gpios = <gpio-descriptor>;	: GPIO for enable signal
+ - trans-gpios = <gpio-descriptor>;	: GPIO for voltage translator enable
+ - mux-gpios = <gpio-descriptor>;	: GPIO for pin multiplexing with other
+                                          functions (eg, external FSI masters)
+
+Examples:
+
+    fsi-master {
+        compatible = "fsi-master-gpio", "fsi-master";
+        clock-gpios = <&gpio 0>;
+        data-gpios = <&gpio 1>;
+        enable-gpios = <&gpio 2>;
+        trans-gpios = <&gpio 3>;
+        mux-gpios = <&gpio 4>;
+    }
-- 
1.8.2.2
