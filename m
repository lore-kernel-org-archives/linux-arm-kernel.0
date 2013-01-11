From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 11 Jan 2013 15:26:55 +0200
Subject: [PATCH 1'/2] ARM: tegra20: Add cpu node
In-Reply-To: <1357909914-28994-2-git-send-email-hdoyu@nvidia.com>
References: <1357909914-28994-2-git-send-email-hdoyu@nvidia.com>
Message-ID: <1357910815-31603-1-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add cpu node for tegra20.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
Update: To be honest, T20 doesn't have four cores but two:)
---
 arch/arm/boot/dts/tegra20.dtsi |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 6e13d13..10dfb83 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -430,6 +430,23 @@
 		status = "disabled";
 	};
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
 		interrupts = <0 56 0x04
-- 
1.7.9.5
