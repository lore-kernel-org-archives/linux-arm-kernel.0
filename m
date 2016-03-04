From: jonathanh@nvidia.com (Jon Hunter)
Date: Fri, 4 Mar 2016 14:26:43 +0000
Subject: [PATCH] ARM64: tegra: Remove unused #power-domain-cells property
Message-ID: <1457101603-8426-1-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the "#power-domain-cells" property which was incorrectly
included by commit e53095857166 ("arm64: tegra: Add Tegra210
support").

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---

ARM-SOC maintainers, could we get this into to the v4.5-rc cycle?
This only appeared since Tegra210 was added for v4.5 and so it
would be good to correct this before the final v4.5.

 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index cd4f45ccd6a7..6cd2048defe2 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -580,8 +580,6 @@
 		reg = <0x0 0x7000e400 0x0 0x400>;
 		clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
 		clock-names = "pclk", "clk32k_in";
-
-		#power-domain-cells = <1>;
 	};
 
 	fuse at 0,7000f800 {
-- 
2.1.4
