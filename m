From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 20 Jun 2018 15:28:27 +0300
Subject: [PATCH 2/2] arm64: tegra: Add CPU nodes to Tegra194 device tree
In-Reply-To: <20180620122827.14165-1-mperttunen@nvidia.com>
References: <20180620122827.14165-1-mperttunen@nvidia.com>
Message-ID: <20180620122827.14165-2-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CPU and PSCI nodes to device tree. The Tegra194 SoC contains
eight NVIDIA Carmel CPUs.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 40 +++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi       | 53 ++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
index ecb034177fc2..859ab5af17c1 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -229,6 +229,46 @@
 		};
 	};
 
+	cpus {
+		cpu at 0 {
+			enable-method = "psci";
+		};
+
+		cpu at 1 {
+			enable-method = "psci";
+		};
+
+		cpu at 2 {
+			enable-method = "psci";
+		};
+
+		cpu at 3 {
+			enable-method = "psci";
+		};
+
+		cpu at 4 {
+			enable-method = "psci";
+		};
+
+		cpu at 5 {
+			enable-method = "psci";
+		};
+
+		cpu at 6 {
+			enable-method = "psci";
+		};
+
+		cpu at 7 {
+			enable-method = "psci";
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		status = "okay";
+		method = "smc";
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 6322ef265c2f..6d699815a84f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -329,6 +329,59 @@
 		};
 	};
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "nvidia,tegra194-carmel", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x10000>;
+		};
+
+		cpu at 1 {
+			compatible = "nvidia,tegra194-carmel", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x10001>;
+		};
+
+		cpu at 2 {
+			compatible = "nvidia,tegra194-carmel", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x100>;
+		};
+
+		cpu at 3 {
+			compatible = "nvidia,tegra194-carmel", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x101>;
+		};
+
+		cpu at 4 {
+			compatible = "nvidia,tegra194-carmel", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x200>;
+		};
+
+		cpu at 5 {
+			compatible = "nvidia,tegra194-carmel", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x201>;
+		};
+
+		cpu at 6 {
+			compatible = "nvidia,tegra194-carmel", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x10300>;
+		};
+
+		cpu at 7 {
+			compatible = "nvidia,tegra194-carmel", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x10301>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-- 
2.16.1
