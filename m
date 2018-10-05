From: robh@kernel.org (Rob Herring)
Date: Fri,  5 Oct 2018 11:58:18 -0500
Subject: [PATCH 06/36] dt-bindings: arm: zte: Move sysctrl bindings to their
 own doc
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Message-ID: <20181005165848.3474-7-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to convert board-level bindings to json-schema, move
various misc SoC bindings out to their own file.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Jun Nie <jun.nie@linaro.org>
Cc: Baoyou Xie <baoyou.xie@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/zte-sysctrl.txt   | 30 +++++++++++++++++++
 Documentation/devicetree/bindings/arm/zte.txt | 27 +----------------
 2 files changed, 31 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/zte-sysctrl.txt

diff --git a/Documentation/devicetree/bindings/arm/zte-sysctrl.txt b/Documentation/devicetree/bindings/arm/zte-sysctrl.txt
new file mode 100644
index 000000000000..7e66b7f7ba96
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/zte-sysctrl.txt
@@ -0,0 +1,30 @@
+ZTE sysctrl Registers
+
+Registers for 'zte,zx296702' SoC:
+
+System management required properties:
+      - compatible = "zte,sysctrl"
+
+Low power management required properties:
+      - compatible = "zte,zx296702-pcu"
+
+Bus matrix required properties:
+      - compatible = "zte,zx-bus-matrix"
+
+
+Registers for 'zte,zx296718' SoC:
+
+System management required properties:
+      - compatible = "zte,zx296718-aon-sysctrl"
+      - compatible = "zte,zx296718-sysctrl"
+
+Example:
+aon_sysctrl: aon-sysctrl at 116000 {
+	compatible = "zte,zx296718-aon-sysctrl", "syscon";
+	reg = <0x116000 0x1000>;
+};
+
+sysctrl: sysctrl at 1463000 {
+	compatible = "zte,zx296718-sysctrl", "syscon";
+	reg = <0x1463000 0x1000>;
+};
diff --git a/Documentation/devicetree/bindings/arm/zte.txt b/Documentation/devicetree/bindings/arm/zte.txt
index 83369785d29c..340612794a37 100644
--- a/Documentation/devicetree/bindings/arm/zte.txt
+++ b/Documentation/devicetree/bindings/arm/zte.txt
@@ -1,20 +1,10 @@
 ZTE platforms device tree bindings
----------------------------------------
 
+---------------------------------------
 -  ZX296702 board:
     Required root node properties:
       - compatible = "zte,zx296702-ad1", "zte,zx296702"
 
-System management required properties:
-      - compatible = "zte,sysctrl"
-
-Low power management required properties:
-      - compatible = "zte,zx296702-pcu"
-
-Bus matrix required properties:
-      - compatible = "zte,zx-bus-matrix"
-
-
 ---------------------------------------
 -  ZX296718 SoC:
     Required root node properties:
@@ -22,18 +12,3 @@ Bus matrix required properties:
 
 ZX296718 EVB board:
       - "zte,zx296718-evb"
-
-System management required properties:
-      - compatible = "zte,zx296718-aon-sysctrl"
-      - compatible = "zte,zx296718-sysctrl"
-
-Example:
-aon_sysctrl: aon-sysctrl at 116000 {
-	compatible = "zte,zx296718-aon-sysctrl", "syscon";
-	reg = <0x116000 0x1000>;
-};
-
-sysctrl: sysctrl at 1463000 {
-	compatible = "zte,zx296718-sysctrl", "syscon";
-	reg = <0x1463000 0x1000>;
-};
-- 
2.17.1
