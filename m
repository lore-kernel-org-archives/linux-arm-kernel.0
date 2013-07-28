From: robherring2@gmail.com (Rob Herring)
Date: Sun, 28 Jul 2013 16:56:32 -0500
Subject: [PATCH 1/7] dt: update PSCI binding documentation for v0.2
In-Reply-To: <1375048598-15637-1-git-send-email-robherring2@gmail.com>
References: <1375048598-15637-1-git-send-email-robherring2@gmail.com>
Message-ID: <1375048598-15637-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

The PSCI spec from ARM has been updated to 0.2 version. Update the
binding document to reflect the spec changes. For the binding, the
major changes are addition of system reset and poweroff functions.
The recommended function id numbering has also changed.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: devicetree at vger.kernel.org
---
 Documentation/devicetree/bindings/arm/psci.txt | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
index 433afe9..b8b4d9f 100644
--- a/Documentation/devicetree/bindings/arm/psci.txt
+++ b/Documentation/devicetree/bindings/arm/psci.txt
@@ -21,7 +21,7 @@ to #0.
 
 Main node required properties:
 
- - compatible    : Must be "arm,psci"
+ - compatible    : Must be "arm,psci-0.2" or "arm,psci"
 
  - method        : The method of calling the PSCI firmware. Permitted
                    values are:
@@ -32,6 +32,9 @@ Main node required properties:
                    "hvc" : HVC #0, with the register assignments specified
 		           in this binding.
 
+ - psci_version  : Function ID for PSCI_VERSION operation. Required for
+                   "arm,psci-0.2" compatible version or later.
+
 Main node optional properties:
 
  - cpu_suspend   : Function ID for CPU_SUSPEND operation
@@ -42,14 +45,24 @@ Main node optional properties:
 
  - migrate       : Function ID for MIGRATE operation
 
+ - system_reset  : Function ID for SYSTEM_RESET operation
+
+ - system_off    : Function ID for SYSTEM_OFF operation
+
 
 Example:
 
 	psci {
-		compatible	= "arm,psci";
+		compatible	= "arm,psci-0.2";
 		method		= "smc";
-		cpu_suspend	= <0x95c10000>;
-		cpu_off		= <0x95c10001>;
-		cpu_on		= <0x95c10002>;
-		migrate		= <0x95c10003>;
+		psci_version	= <0x84000000>;
+		cpu_suspend	= <0x84000001>;
+		cpu_off		= <0x84000002>;
+		cpu_on		= <0x84000003>;
+		affinity_info	= <0x84000004>; 
+		migrate		= <0x84000005>;
+		migrate_info_type = <0x84000006>; 
+		migrate_info_up_cpu = <0x84000007>; 
+		system_off	= <0x84000008>; 
+		system_reset	= <0x84000009>; 
 	};
-- 
1.8.1.2
