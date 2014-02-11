From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 11 Feb 2014 14:17:51 +0000
Subject: [PATCH RFC v3 1/3] Documentation: devicetree: psci: define CPU
 suspend parameter
In-Reply-To: <1392128273-8614-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1392128273-8614-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1392128273-8614-2-git-send-email-lorenzo.pieralisi@arm.com>
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
 Documentation/devicetree/bindings/arm/psci.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
index 433afe9..6fc32a5 100644
--- a/Documentation/devicetree/bindings/arm/psci.txt
+++ b/Documentation/devicetree/bindings/arm/psci.txt
@@ -42,6 +42,13 @@ Main node optional properties:
 
  - migrate       : Function ID for MIGRATE operation
 
+Device tree nodes that require usage of PSCI CPU_SUSPEND function (ie idle
+states bindings) must specify the following properties:
+
+- power-state
+		Value type: <u32>
+		Definition: power_state parameter to pass to the PSCI
+			    suspend call.
 
 Example:
 
-- 
1.8.4
