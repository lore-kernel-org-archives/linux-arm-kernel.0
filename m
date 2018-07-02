From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Mon, 2 Jul 2018 15:11:31 +0300
Subject: [PATCH v2 2/2] arm64: tegra: Add CPU nodes to Tegra194 device tree
In-Reply-To: <20180702121131.13461-1-mperttunen@nvidia.com>
References: <20180702121131.13461-1-mperttunen@nvidia.com>
Message-ID: <20180702121131.13461-2-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CPU and PSCI nodes to device tree. The Tegra194 SoC contains
eight NVIDIA Carmel CPUs.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---

Notes:
    v2:
    - Moved PSCI node/properties to SoC device tree

 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 67 ++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 6322ef265c2f..8c2b4671ef81 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -329,6 +329,73 @@
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
+			enable-method = "psci";
+		};
+
+		cpu at 1 {
+			compatible = "nvidia,tegra194-carmel", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x10001>;
+			enable-method = "psci";
+		};
+
+		cpu at 2 {
+			compatible = "nvidia,tegra194-carmel", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x100>;
+			enable-method = "psci";
+		};
+
+		cpu at 3 {
+			compatible = "nvidia,tegra194-carmel", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x101>;
+			enable-method = "psci";
+		};
+
+		cpu at 4 {
+			compatible = "nvidia,tegra194-carmel", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x200>;
+			enable-method = "psci";
+		};
+
+		cpu at 5 {
+			compatible = "nvidia,tegra194-carmel", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x201>;
+			enable-method = "psci";
+		};
+
+		cpu at 6 {
+			compatible = "nvidia,tegra194-carmel", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x10300>;
+			enable-method = "psci";
+		};
+
+		cpu at 7 {
+			compatible = "nvidia,tegra194-carmel", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x10301>;
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
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-- 
2.16.1
