From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Wed, 21 Feb 2018 08:16:03 -0800
Subject: [PATCH v2 5/8] [PATCH [5/8] Documentation: dt-bindings: Add a
 document for PECI hwmon client driver
In-Reply-To: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20180221161606.32247-6-jae.hyun.yoo@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds a dt-bindings document for a generic PECI hwmon client
driver.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 .../devicetree/bindings/hwmon/peci-hwmon.txt       | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/peci-hwmon.txt

diff --git a/Documentation/devicetree/bindings/hwmon/peci-hwmon.txt b/Documentation/devicetree/bindings/hwmon/peci-hwmon.txt
new file mode 100644
index 000000000000..831813158884
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/peci-hwmon.txt
@@ -0,0 +1,27 @@
+Bindings for Intel PECI (Platform Environment Control Interface) hwmon driver.
+
+Required properties:
+- compatible
+	Should be "intel,peci-hwmon".
+
+- reg
+	Should contain address of a client CPU. Address range of CPU clients is
+	starting from 0x30 based on PECI specification.
+	<0x30> .. <0x37> (depends on the PECI_OFFSET_MAX definition)
+
+Example:
+	peci-bus at 0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		< more properties >
+
+		peci-hwmon at cpu0 {
+			compatible = "intel,peci-hwmon";
+			reg = <0x30>;
+		};
+
+		peci-hwmon at cpu1 {
+			compatible = "intel,peci-hwmon";
+			reg = <0x31>;
+		};
+	};
-- 
2.16.1
