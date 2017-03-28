From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 28 Mar 2017 12:48:38 +0100
Subject: [PATCH] arm64: tegra: Add CPU and PSCI nodes for NVIDIA Tegra210
 platforms
Message-ID: <1490701718-16571-1-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the CPU and PSCI nodes for the NVIDIA Tegra210 platforms so that
all CPUs can be enabled on boot. This assumes that the PSCI firmware
has been loaded during the initial bootstrap on the device before the
kernel starts (which is typically the case for these platforms). The
PSCI firmware version is set to v0.2 which aligns with the current
shipping version for Tegra.

Reported-by: Martin Michlmayr <tbm@cyrius.com>
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi | 23 +++++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-p2530.dtsi | 24 ++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
index 906fb836d241..de1696c28140 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
@@ -296,6 +296,29 @@
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
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
 	regulators {
 		vdd_gpu: regulator at 100 {
 			compatible = "pwm-regulator";
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2530.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2530.dtsi
index 0ec92578cacb..67cb039965fd 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2530.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2530.dtsi
@@ -51,4 +51,28 @@
 			clock-frequency = <32768>;
 		};
 	};
+
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
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
 };
-- 
2.7.4
