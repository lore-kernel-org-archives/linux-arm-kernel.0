From: acourbot@nvidia.com (Alexandre Courbot)
Date: Thu, 30 Mar 2017 18:18:31 +0900
Subject: [PATCH 2/2] arm64: tegra: Add GPU node for Tegra 186
In-Reply-To: <20170330091831.18322-1-acourbot@nvidia.com>
References: <20170330091831.18322-1-acourbot@nvidia.com>
Message-ID: <20170330091831.18322-2-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DT node for the GP10B GPU on Tegra 186.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index b4c71b519289..7ada0c5b0581 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -660,6 +660,24 @@
 		};
 	};
 
+	gpu at 17000000 {
+		compatible = "nvidia,gp10b";
+		reg = <0x0 0x17000000 0x0 0x1000000>
+		      <0x0 0x18000000 0x0 0x1000000>;
+		interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "stall", "nonstall";
+
+		clocks = <&bpmp TEGRA186_CLK_GPCCLK>,
+			 <&bpmp TEGRA186_CLK_GPU>;
+		clock-names = "gpu", "pwr";
+		resets = <&bpmp TEGRA186_RESET_GPU>;
+		reset-names = "gpu";
+		status = "disabled";
+
+		power-domains = <&bpmp TEGRA186_POWER_DOMAIN_GPU>;
+	};
+
 	sysram at 30000000 {
 		compatible = "nvidia,tegra186-sysram", "mmio-sram";
 		reg = <0x0 0x30000000 0x0 0x50000>;
-- 
2.12.0
