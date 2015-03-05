From: s-anna@ti.com (Suman Anna)
Date: Wed, 4 Mar 2015 20:01:15 -0600
Subject: [PATCH v8 3/4] Documentation: dt: add the omap hwspinlock bindings
 document
In-Reply-To: <1425520876-37826-1-git-send-email-s-anna@ti.com>
References: <1425520876-37826-1-git-send-email-s-anna@ti.com>
Message-ID: <1425520876-37826-4-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HwSpinlock IP is present only on OMAP4 and other newer SoCs,
which are all device-tree boot only. This patch adds the
DT bindings information for OMAP hwspinlock module.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
v8: Removed the previous information about hwlock-base-id, and added
    a reference to the base binding document.

 .../devicetree/bindings/hwlock/omap-hwspinlock.txt | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt

diff --git a/Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt b/Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
new file mode 100644
index 000000000000..2c9804f4f4ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
@@ -0,0 +1,26 @@
+OMAP4+ HwSpinlock Driver
+========================
+
+Required properties:
+- compatible:		Should be "ti,omap4-hwspinlock" for
+			    OMAP44xx, OMAP54xx, AM33xx, AM43xx, DRA7xx SoCs
+- reg:			Contains the hwspinlock module register address space
+			(base address and length)
+- ti,hwmods:		Name of the hwmod associated with the hwspinlock device
+- #hwlock-cells:	Should be 1. The OMAP hwspinlock users will use a
+			0-indexed relative hwlock number as the argument
+			specifier value for requesting a specific hwspinlock
+			within a hwspinlock bank.
+
+Please look at the generic hwlock binding for usage information for consumers,
+"Documentation/devicetree/bindings/hwlock/hwlock.txt"
+
+Example:
+
+/* OMAP4 */
+hwspinlock: spinlock at 4a0f6000 {
+	compatible = "ti,omap4-hwspinlock";
+	reg = <0x4a0f6000 0x1000>;
+	ti,hwmods = "spinlock";
+	#hwlock-cells = <1>;
+};
-- 
2.3.0
