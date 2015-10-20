From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Tue, 20 Oct 2015 14:54:40 +0530
Subject: [PATCH v2 1/6] arm: dts: Add syscon-{reboot,
 poweroff} nodes for exynos3250 SoCs
In-Reply-To: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
References: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <1445333085-22837-2-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds syscon-{reboot, poweroff} nodes to allow the
generic syscon-{reboot, poweroff} driver to reset/poweroff exynos3250 SoC.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Acked-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 arch/arm/boot/dts/exynos3250.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 033def482fc3..46d469aa75a7 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -152,6 +152,20 @@
 			interrupt-parent = <&gic>;
 		};
 
+		poweroff: syscon-poweroff {
+			compatible = "syscon-poweroff";
+			regmap = <&pmu_system_controller>;
+			offset = <0x330C>; /* PS_HOLD_CONTROL */
+			mask = <0x5200>; /* Reset value */
+		};
+
+		reboot: syscon-reboot {
+			compatible = "syscon-reboot";
+			regmap = <&pmu_system_controller>;
+			offset = <0x0400>; /* SWRESET */
+			mask = <0x1>;
+		};
+
 		mipi_phy: video-phy at 10020710 {
 			compatible = "samsung,s5pv210-mipi-video-phy";
 			#phy-cells = <1>;
-- 
1.7.10.4
