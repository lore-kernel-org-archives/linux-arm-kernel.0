From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 23 Nov 2018 13:04:03 +0100
Subject: [PATCH] ARM: tegra: Add VIC on Tegra124
Message-ID: <20181123120403.16244-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The Video Image Compositor can be used to perform a variety of image
operations. Add a device tree node for it, so that it can be exposed
as a host1x channel to userspace.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 183c5acafb22..b113e47b2b2a 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -140,6 +140,18 @@
 			status = "disabled";
 		};
 
+		vic at 54340000 {
+			compatible = "nvidia,tegra124-vic";
+			reg = <0x0 0x54340000 0x0 0x00040000>;
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_VIC03>;
+			clock-names = "vic";
+			resets = <&tegra_car 178>;
+			reset-names = "vic";
+
+			iommus = <&mc TEGRA_SWGROUP_VIC>;
+		};
+
 		sor at 54540000 {
 			compatible = "nvidia,tegra124-sor";
 			reg = <0x0 0x54540000 0x0 0x00040000>;
-- 
2.19.1
