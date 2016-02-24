From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Feb 2016 16:14:23 +0100
Subject: [PATCH v2 3/6] dt-bindings: clock: add DT bindings for AP806 ring
 clocks
In-Reply-To: <1456326866-30854-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1456326866-30854-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1456326866-30854-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the Device Tree binding description for the AP806
ring clocks, used on Marvell Armada 7K/8K SOCs.

Since the AP806 ring clocks register is part of the "DFX Server"
register area, the DT binding is meant to be used as a sub-node of the
DFX Server DT binding, which is described separately.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../clock/mvebu-armada-ap806-ring-clock.txt        | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mvebu-armada-ap806-ring-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/mvebu-armada-ap806-ring-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-armada-ap806-ring-clock.txt
new file mode 100644
index 0000000..8c8030a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mvebu-armada-ap806-ring-clock.txt
@@ -0,0 +1,36 @@
+* Clock bindings for Marvell MVEBU AP806 Ring clocks
+
+The Marvell MVEBU Armada 7K/8K SoCs contain a block called AP806,
+hosting the CPU and other core components of the CPU. This Device Tree
+binding allows to describe the ring clocks of the AP806, which are
+derived from the Ring Core clock, after a dividing factor.
+
+The register giving the dividing factors is part of the DFX server
+register area, covered by the DT binding described at
+Documentation/devicetree/bindings/arm/marvell/marvell,ap806-dfx-server.txt. Therefore,
+the DT node for the AP806 Ring clocks must appear as a child node of
+the DFX server Device Tree node.
+
+The following is a list of provided IDs and clock names on Armada
+AP806 RING dividers:
+
+ 0 = Ring 0
+ 1 = Ring 2
+ 2 = Ring 3
+ 3 = Ring 4
+ 4 = Ring 5
+
+Required properties:
+- compatible: must be one of the following:
+	"marvell,armada-ap806-ring-clock"
+- #clock-cells : from common clock binding; shall be set to 1
+- clock-output-names: name of the output clocks
+
+Example:
+
+	ringclk: clk at 250 {
+		compatible = "marvell,armada-ap806-ring-clock";
+		#clock-cells = <1>;
+		clock-output-names = "ring-0", "ring-2", "ring-3", "ring-4", "ring-5";
+		clocks = <&coreclk 1>;
+	};
-- 
2.6.4
