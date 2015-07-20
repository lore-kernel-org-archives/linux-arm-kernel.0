From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Mon, 20 Jul 2015 10:54:29 +0300
Subject: [PATCH v2 4/4] ARM: tegra: Add VIC for Tegra124
In-Reply-To: <1437378869-10451-1-git-send-email-mperttunen@nvidia.com>
References: <1437378869-10451-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <1437378869-10451-5-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arto Merilainen <amerilainen@nvidia.com>

This patch adds VIC device tree node for Video Image Compositor.

Signed-off-by: Arto Merilainen <amerilainen@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 87318a7..1233f4a 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -137,6 +137,18 @@
 			status = "disabled";
 		};
 
+		vic at 0,54340000 {
+			compatible = "nvidia,tegra124-vic";
+			reg = <0x0 0x54340000 0x0 0x00040000>;
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_VIC03>;
+			clock-names = "vic";
+			resets = <&tegra_car TEGRA124_CLK_VIC03>;
+			reset-names = "vic";
+
+			iommus = <&mc TEGRA_SWGROUP_VIC>;
+		};
+
 		sor at 0,54540000 {
 			compatible = "nvidia,tegra124-sor";
 			reg = <0x0 0x54540000 0x0 0x00040000>;
-- 
2.1.4
