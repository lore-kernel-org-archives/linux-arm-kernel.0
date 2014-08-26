From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 26 Aug 2014 08:14:02 +0200
Subject: [PATCH v3 1/3] of: Add NVIDIA Tegra flow controller bindings
Message-ID: <1409033644-24376-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Add device tree bindings for the flow controller found on NVIDIA Tegra
SoCs.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- collapse identical bindings into a single file

 .../bindings/arm/tegra/nvidia,tegra20-flowctrl.txt           | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt
new file mode 100644
index 000000000000..ccf0adddc820
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt
@@ -0,0 +1,12 @@
+NVIDIA Tegra Flow Controller
+
+Required properties:
+- compatible: Should be "nvidia,tegra<chip>-flowctrl"
+- reg: Should contain one register range (address and length)
+
+Example:
+
+	flow-controller at 60007000 {
+		compatible = "nvidia,tegra20-flowctrl";
+		reg = <0x60007000 0x1000>;
+	};
-- 
2.0.4
