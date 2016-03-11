From: acourbot@nvidia.com (Alexandre Courbot)
Date: Fri, 11 Mar 2016 12:51:57 +0900
Subject: [PATCH 4/5] arm64: tegra210: Add pllg_ref clock to GM20B
In-Reply-To: <1457668318-2821-1-git-send-email-acourbot@nvidia.com>
References: <1457668318-2821-1-git-send-email-acourbot@nvidia.com>
Message-ID: <1457668318-2821-5-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This clock is required for the GPU to operate.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 362c269946ff..0c51ac3b0f56 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -309,8 +309,9 @@
 			     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "stall", "nonstall";
 		clocks = <&tegra_car TEGRA210_CLK_GPU>,
-			 <&tegra_car TEGRA210_CLK_PLL_P_OUT5>;
-		clock-names = "gpu", "pwr";
+			 <&tegra_car TEGRA210_CLK_PLL_P_OUT5>,
+			 <&tegra_car TEGRA210_CLK_PLL_G_REF>;
+		clock-names = "gpu", "pwr", "pllg_ref";
 		resets = <&tegra_car 184>;
 		reset-names = "gpu";
 		status = "disabled";
-- 
2.7.2
