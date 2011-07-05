From: swarren@nvidia.com (Stephen Warren)
Date: Tue,  5 Jul 2011 14:29:22 -0600
Subject: [PATCH 3/3] dt: docs: tegra: Use engineering names in DT compatible
	property
In-Reply-To: <1309897762-23564-1-git-send-email-swarren@nvidia.com>
References: <1309897762-23564-1-git-send-email-swarren@nvidia.com>
Message-ID: <1309897762-23564-4-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Engineering names are more stable than marketing names. Hence, use them
for Device Tree compatible properties instead.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 Documentation/devicetree/usage-model |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/usage-model b/Documentation/devicetree/usage-model
index 03a56b3..45e03b8 100644
--- a/Documentation/devicetree/usage-model
+++ b/Documentation/devicetree/usage-model
@@ -240,7 +240,7 @@ About now is a good time to lay out an example.  Here is part of the
 device tree for the NVIDIA Tegra board.
 
 /{
-	compatible = "nvidia,harmony", "nvidia,tegra250";
+	compatible = "nvidia,harmony", "nvidia,tegra20";
 	#address-cells = <1>;
 	#size-cells = <1>;
 	interrupt-parent = <&intc>;
@@ -254,33 +254,33 @@ device tree for the NVIDIA Tegra board.
 	};
 
 	soc {
-		compatible = "nvidia,tegra250-soc", "simple-bus";
+		compatible = "nvidia,tegra20-soc", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
 
 		intc: interrupt-controller at 50041000 {
-			compatible = "nvidia,tegra250-gic";
+			compatible = "nvidia,tegra20-gic";
 			interrupt-controller;
 			#interrupt-cells = <1>;
 			reg = <0x50041000 0x1000>, < 0x50040100 0x0100 >;
 		};
 
 		serial at 70006300 {
-			compatible = "nvidia,tegra250-uart";
+			compatible = "nvidia,tegra20-uart";
 			reg = <0x70006300 0x100>;
 			interrupts = <122>;
 		};
 
 		i2s-1: i2s at 70002800 {
-			compatible = "nvidia,tegra250-i2s";
+			compatible = "nvidia,tegra20-i2s";
 			reg = <0x70002800 0x100>;
 			interrupts = <77>;
 			codec = <&wm8903>;
 		};
 
 		i2c at 7000c000 {
-			compatible = "nvidia,tegra250-i2c";
+			compatible = "nvidia,tegra20-i2c";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			reg = <0x7000c000 0x100>;
-- 
1.7.0.4
