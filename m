From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Tue, 20 Oct 2015 14:54:42 +0530
Subject: [PATCH v2 3/6] arm: dts: Add syscon-{reboot,
 poweroff} nodes for exynos5
In-Reply-To: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
References: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <1445333085-22837-4-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds syscon-{reboot, poweroff} nodes to allow the
generic syscon-{reboot, poweroff} driver to reset/poweroff exynos5 SoCs.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Acked-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 arch/arm/boot/dts/exynos5.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index 110dbd4fb884..e2439e87ee4a 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -88,6 +88,20 @@
 		status = "disabled";
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
 	fimd: fimd at 14400000 {
 		compatible = "samsung,exynos5250-fimd";
 		interrupt-parent = <&combiner>;
-- 
1.7.10.4
