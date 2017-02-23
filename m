From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 23 Feb 2017 18:30:45 +0100
Subject: [PATCH 03/11] arm64: tegra: Invert the PMC interrupt on P3310
In-Reply-To: <20170223173053.19701-1-thierry.reding@gmail.com>
References: <20170223173053.19701-1-thierry.reding@gmail.com>
Message-ID: <20170223173053.19701-3-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The PMC interrupt is inverted on P3310, so mark it as such in the device
tree to avoid a flood of interrupts when the PMIC is enabled.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
index 1abe2eceb3d1..3653d0dd5f4f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
@@ -26,6 +26,10 @@
 		status = "okay";
 	};
 
+	pmc at c360000 {
+		nvidia,invert-interrupt;
+	};
+
 	cpus {
 		cpu at 0 {
 			enable-method = "psci";
-- 
2.11.1
