From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 11 Jan 2012 16:09:54 -0700
Subject: [PATCH V2 1/4] ARM: dt: tegra: Add Tegra APB DMA device tree binding
Message-ID: <1326323397-23931-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document binding, and add the node to tegra*.dtsi.

The driver isn't actually instantiated from this node yet, but the I2S
binding will rely on being able to refer to the APB DMA node using a
phandle.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: Added this to tegra30.dtsi too. Fixed interrupt IDs. Fixed reg to
include all the per-channel registers.
---
 .../devicetree/bindings/dma/tegra20-apbdma.txt     |   30 ++++++++++++++++
 arch/arm/boot/dts/tegra20.dtsi                     |   21 +++++++++++
 arch/arm/boot/dts/tegra30.dtsi                     |   37 ++++++++++++++++++++
 3 files changed, 88 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/tegra20-apbdma.txt

diff --git a/Documentation/devicetree/bindings/dma/tegra20-apbdma.txt b/Documentation/devicetree/bindings/dma/tegra20-apbdma.txt
new file mode 100644
index 0000000..90fa7da
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/tegra20-apbdma.txt
@@ -0,0 +1,30 @@
+* NVIDIA Tegra APB DMA controller
+
+Required properties:
+- compatible: Should be "nvidia,<chip>-apbdma"
+- reg: Should contain DMA registers location and length. This shuld include
+  all of the per-channel registers.
+- interrupts: Should contain all of the per-channel DMA interrupts.
+
+Examples:
+
+apbdma: dma at 6000a000 {
+	compatible = "nvidia,tegra20-apbdma";
+	reg = <0x6000a000 0x1200>;
+	interrupts = < 0 136 0x04
+		       0 137 0x04
+		       0 138 0x04
+		       0 139 0x04
+		       0 140 0x04
+		       0 141 0x04
+		       0 142 0x04
+		       0 143 0x04
+		       0 144 0x04
+		       0 145 0x04
+		       0 146 0x04
+		       0 147 0x04
+		       0 148 0x04
+		       0 149 0x04
+		       0 150 0x04
+		       0 151 0x04 >;
+};
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 853a5c6..0a5d092 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -12,6 +12,27 @@
 		      < 0x50040100 0x0100 >;
 	};
 
+	apbdma: dma at 6000a000 {
+		compatible = "nvidia,tegra20-apbdma";
+		reg = <0x6000a000 0x1200>;
+		interrupts = < 0 104 0x04
+			       0 105 0x04
+			       0 106 0x04
+			       0 107 0x04
+			       0 108 0x04
+			       0 109 0x04
+			       0 110 0x04
+			       0 111 0x04
+			       0 112 0x04
+			       0 113 0x04
+			       0 114 0x04
+			       0 115 0x04
+			       0 116 0x04
+			       0 117 0x04
+			       0 118 0x04
+			       0 119 0x04 >;
+	};
+
 	i2c at 7000c000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 368cbb3..537953a 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -12,6 +12,43 @@
 		      < 0x50040100 0x0100 >;
 	};
 
+	apbdma: dma at 6000a000 {
+		compatible = "nvidia,tegra30-apbdma", "nvidia,tegra20-apbdma";
+		reg = <0x6000a000 0x1400>;
+		interrupts = < 0 104 0x04
+			       0 105 0x04
+			       0 106 0x04
+			       0 107 0x04
+			       0 108 0x04
+			       0 109 0x04
+			       0 110 0x04
+			       0 111 0x04
+			       0 112 0x04
+			       0 113 0x04
+			       0 114 0x04
+			       0 115 0x04
+			       0 116 0x04
+			       0 117 0x04
+			       0 118 0x04
+			       0 119 0x04
+			       0 128 0x04
+			       0 129 0x04
+			       0 130 0x04
+			       0 131 0x04
+			       0 132 0x04
+			       0 133 0x04
+			       0 134 0x04
+			       0 135 0x04
+			       0 136 0x04
+			       0 137 0x04
+			       0 138 0x04
+			       0 139 0x04
+			       0 140 0x04
+			       0 141 0x04
+			       0 142 0x04
+			       0 143 0x04 >;
+	};
+
 	i2c at 7000c000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.7.0.4
