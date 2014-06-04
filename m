From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Wed,  4 Jun 2014 18:03:44 +0200
Subject: [PATCH v2 3/5] Documentation: bindings: add the marvell,
 berlin-smp CPU enable method
In-Reply-To: <1401897826-11711-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1401897826-11711-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1401897826-11711-4-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the CPU enable method used by Marvell Berlin SoCs.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 .../arm/cpu-enable-method/marvell,berlin-smp       | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cpu-enable-method/marvell,berlin-smp

diff --git a/Documentation/devicetree/bindings/arm/cpu-enable-method/marvell,berlin-smp b/Documentation/devicetree/bindings/arm/cpu-enable-method/marvell,berlin-smp
new file mode 100644
index 000000000000..cd236b727e2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cpu-enable-method/marvell,berlin-smp
@@ -0,0 +1,41 @@
+========================================================
+Secondary CPU enable-method "marvell,berlin-smp" binding
+========================================================
+
+This document describes the "marvell,berlin-smp" method for enabling secondary
+CPUs. To apply to all CPUs, a single "marvell,berlin-smp" enable method should
+be defined in the "cpus" node.
+
+Enable method name:	"marvell,berlin-smp"
+Compatible machines:	"marvell,berlin2" and "marvell,berlin2q"
+Compatible CPUs:	"marvell,pj4b" and "arm,cortex-a9"
+Related properties:	(none)
+
+Note:
+This enable method needs valid nodes compatible with "arm,cortex-a9-scu" and
+"marvell,berlin-cpu-ctrl"[1].
+
+Example:
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "marvell,berlin-smp";
+
+		cpu at 0 {
+			compatible = "marvell,pj4b";
+			device_type = "cpu";
+			next-level-cache = <&l2>;
+			reg = <0>;
+		};
+
+		cpu at 1 {
+			compatible = "marvell,pj4b";
+			device_type = "cpu";
+			next-level-cache = <&l2>;
+			reg = <1>;
+		};
+	};
+
+--
+[1] arm/marvell,berlin.txt
-- 
1.9.1
