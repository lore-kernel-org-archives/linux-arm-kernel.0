From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun,  1 Jun 2014 13:55:22 +0400
Subject: [PATCH 2/2] clk: clps711x: Add DT bindings documentation
Message-ID: <1401616522-13505-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DT binding documentation for the Cirrus Logic
CLPS711X-based CPUs clock subsystem.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 .../devicetree/bindings/clock/clps711x-clock.txt      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/clps711x-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/clps711x-clock.txt b/Documentation/devicetree/bindings/clock/clps711x-clock.txt
new file mode 100644
index 0000000..0fdf3c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/clps711x-clock.txt
@@ -0,0 +1,19 @@
+* Clock bindings for the Cirrus Logic CLPS711X CPUs
+
+Required properties:
+- compatible  : Shall contain "cirrus,clps711x-clk".
+- reg         : Address of the internal register set.
+- cpufreq     : Factory set default frequency in HZ.
+- #clock-cells: Should be <1>.
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell. See include/dt-bindings/clock/clps711x-clock.h
+for the full list of CLPS711X clock IDs.
+
+Example:
+	clks: clks at 80000000 {
+		#clock-cells = <1>;
+		compatible = "cirrus,ep7312-clk", "cirrus,clps711x-clk";
+		reg = <0x80000000 0xc000>;
+		cpufreq = <73728000>;
+	};
-- 
1.8.5.5
