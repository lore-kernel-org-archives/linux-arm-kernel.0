From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 11 Jun 2014 17:18:36 +0100
Subject: [PATCH v4 2/6] Documentation: devicetree: psci: define CPU suspend
 parameter
In-Reply-To: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1402503520-8611-3-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OS layers built on top of PSCI to enter low-power states require the
power_state parameter to be passed to the PSCI CPU suspend method.

This parameter is specific to a power state and platform specific,
therefore must be provided by firmware to the OS in order to enable
proper call sequence.

This patch adds a property in the PSCI bindings that describes how
the CPU suspend power_state parameter should be defined in DT in
all device nodes that rely on PSCI CPU suspend method usage.

Reviewed-by: Sebastian Capella <sebcape@gmail.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/psci.txt | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
index b4a58f3..fae3eed 100644
--- a/Documentation/devicetree/bindings/arm/psci.txt
+++ b/Documentation/devicetree/bindings/arm/psci.txt
@@ -50,6 +50,14 @@ Main node optional properties:
 
  - migrate       : Function ID for MIGRATE operation
 
+Device tree nodes that require usage of PSCI CPU_SUSPEND function (ie idle
+states bindings[1]) must specify the following properties:
+
+- entry-method-param
+		Usage: Required for idle states bindings [1].
+		Value type: <u32>
+		Definition: power_state parameter to pass to the PSCI
+			    suspend call.
 
 Example:
 
@@ -64,7 +72,6 @@ Case 1: PSCI v0.1 only.
 		migrate		= <0x95c10003>;
 	};
 
-
 Case 2: PSCI v0.2 only
 
 	psci {
@@ -88,3 +95,6 @@ Case 3: PSCI v0.2 and PSCI v0.1.
 
 		...
 	};
+
+[1] Kernel documentation - ARM idle states bindings
+    Documentation/devicetree/bindings/arm/idle-states.txt
-- 
1.8.4
