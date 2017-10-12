From: m.purski@samsung.com (Maciej Purski)
Date: Thu, 12 Oct 2017 15:18:01 +0200
Subject: [PATCH v3 3/4] dt-bindings: hwmon: Add
 ti-max-expected-current-milliamp property to ina2xx
In-Reply-To: <1507814282-1486-1-git-send-email-m.purski@samsung.com>
References: <1507814282-1486-1-git-send-email-m.purski@samsung.com>
 <CGME20171012131816eucas1p292bc0e20f141cfd21fe27c40700d82fb@eucas1p2.samsung.com>
Message-ID: <1507814282-1486-4-git-send-email-m.purski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add optional max expected current property which allows calibrating
the ina sensor in order to achieve requested measure scale. Document
the changes in Documentation/hwmon/ina2xx.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 Documentation/devicetree/bindings/hwmon/ina2xx.txt | 4 +++-
 Documentation/hwmon/ina2xx                         | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ina2xx.txt b/Documentation/devicetree/bindings/hwmon/ina2xx.txt
index 02af0d9..9268595 100644
--- a/Documentation/devicetree/bindings/hwmon/ina2xx.txt
+++ b/Documentation/devicetree/bindings/hwmon/ina2xx.txt
@@ -14,11 +14,13 @@ Optional properties:
 
 - shunt-resistor
 	Shunt resistor value in micro-Ohm
-
+- ti-max-expected-current-milliamp
+	Max expected current value in mA
 Example:
 
 ina220 at 44 {
 	compatible = "ti,ina220";
 	reg = <0x44>;
 	shunt-resistor = <1000>;
+	ti-max-expected-current-milliamp = <3000>;
 };
diff --git a/Documentation/hwmon/ina2xx b/Documentation/hwmon/ina2xx
index cfd31d9..30620e8 100644
--- a/Documentation/hwmon/ina2xx
+++ b/Documentation/hwmon/ina2xx
@@ -55,6 +55,9 @@ The shunt value in micro-ohms can be set via platform data or device tree at
 compile-time or via the shunt_resistor attribute in sysfs at run-time. Please
 refer to the Documentation/devicetree/bindings/i2c/ina2xx.txt for bindings
 if the device tree is used.
+The max expected current value in miliamp can be set via platform data
+or device tree at compile-time or via currX_max attribute in sysfs
+at run-time.
 
 Additionally ina226 supports update_interval attribute as described in
 Documentation/hwmon/sysfs-interface. Internally the interval is the sum of
-- 
2.7.4
