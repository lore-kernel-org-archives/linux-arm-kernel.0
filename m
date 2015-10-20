From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Tue, 20 Oct 2015 14:54:41 +0530
Subject: [PATCH v2 2/6] arm: dts: Add syscon-{reboot,
 poweroff} nodes for exynos4
In-Reply-To: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
References: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <1445333085-22837-3-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds syscon-{reboot, poweroff} nodes to allow the
generic syscon-{reboot, poweroff} driver to reset/poweroff exynos4 SoC.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Acked-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 arch/arm/boot/dts/exynos4.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 98c0a368b777..1622f487e269 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -158,6 +158,20 @@
 		interrupt-parent = <&gic>;
 	};
 
+	poweroff: syscon-poweroff {
+		compatible = "syscon-poweroff";
+		regmap = <&pmu_system_controller>;
+		offset = <0x330C>; /* PS_HOLD_CONTROL */
+		mask = <0x5200>; /* reset value */
+	};
+
+	reboot: syscon-reboot {
+		compatible = "syscon-reboot";
+		regmap = <&pmu_system_controller>;
+		offset = <0x0400>; /* SWRESET */
+		mask = <0x1>;
+	};
+
 	dsi_0: dsi at 11C80000 {
 		compatible = "samsung,exynos4210-mipi-dsi";
 		reg = <0x11C80000 0x10000>;
-- 
1.7.10.4
