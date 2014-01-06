From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  6 Jan 2014 16:20:42 +0100
Subject: [PATCH] ARM: tegra: Properly sort clocks property
Message-ID: <1389021642-5516-1-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Other files and nodes list the resets property after the clocks property
so do the same here for consistency.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index ed8e7700b46d..18d52a7704cc 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -144,9 +144,9 @@
 			compatible = "nvidia,tegra30-gr2d";
 			reg = <0x54140000 0x00040000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA30_CLK_GR2D>;
 			resets = <&tegra_car 21>;
 			reset-names = "2d";
-			clocks = <&tegra_car TEGRA30_CLK_GR2D>;
 		};
 
 		gr3d at 54180000 {
-- 
1.8.4.2
