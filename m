From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 18 Mar 2014 11:28:50 +0000
Subject: [PATCH RFC v5 1/3] Documentation: devicetree: psci: define CPU
 suspend parameter
In-Reply-To: <1395142132-20788-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1395142132-20788-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1395142132-20788-2-git-send-email-lorenzo.pieralisi@arm.com>
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

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/devicetree/bindings/arm/psci.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
index 433afe9..797c48f 100644
--- a/Documentation/devicetree/bindings/arm/psci.txt
+++ b/Documentation/devicetree/bindings/arm/psci.txt
@@ -42,6 +42,14 @@ Main node optional properties:
 
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
 
@@ -53,3 +61,6 @@ Example:
 		cpu_on		= <0x95c10002>;
 		migrate		= <0x95c10003>;
 	};
+
+[1] Kernel documentation - ARM idle states bindings
+    Documentation/devicetree/bindings/arm/idle-states.txt
-- 
1.8.4
