From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Tue,  9 Jan 2018 14:31:24 -0800
Subject: [PATCH linux dev-4.10 4/6] Documentation: dt-bindings: Add a generic
 PECI hwmon
In-Reply-To: <20180109223126.13093-1-jae.hyun.yoo@linux.intel.com>
References: <20180109223126.13093-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20180109223126.13093-5-jae.hyun.yoo@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit add a dt-bindings document for a generic PECI hwmon
driver.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 .../devicetree/bindings/hwmon/peci-hwmon.txt       | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/peci-hwmon.txt

diff --git a/Documentation/devicetree/bindings/hwmon/peci-hwmon.txt b/Documentation/devicetree/bindings/hwmon/peci-hwmon.txt
new file mode 100644
index 0000000..20b86f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/peci-hwmon.txt
@@ -0,0 +1,33 @@
+* Generic PECI (Platform Environment Control Interface) hwmon driver.
+
+Dependency:
+- This driver uses a PECI misc driver as a controller interface so one of PECI
+  misc drivers which provides compatible ioctls has to be enabled.
+
+Required properties:
+- compatible: "peci-hwmon"
+- cpu-id: Should contain CPU socket ID
+	- 0 ~ 7
+
+Optional properties:
+- show-core: If this protperty is defined, core tmeperature attrubites will be
+	     enumerated.
+- dimm-nums: Should contain the number of DIMM slots that attached to each CPU
+	     which is indicated by cpu-id.
+	0 ~ 16 (default: 16)
+	     In case of 0, DIMM temperature attrubites will not be enumerated.
+
+Example:
+	peci-hwmon0 {
+		compatible = "peci-hwmon";
+		cpu-id = <0>;
+		show-core;
+		dimm-nums = <16>;
+	};
+
+	peci-hwmon1 {
+		compatible = "peci-hwmon";
+		cpu-id = <1>;
+		show-core;
+		dimm-nums = <16>;
+	};
-- 
2.7.4
