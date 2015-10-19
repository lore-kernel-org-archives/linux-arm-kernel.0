From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Mon, 19 Oct 2015 11:33:49 +0530
Subject: [PATCH 1/7] arm: dts: Add syscon-{reboot,
 poweroff} nodes for exynos3250 SoCs
In-Reply-To: <1445234635-3950-1-git-send-email-alim.akhtar@samsung.com>
References: <1445234635-3950-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <1445234635-3950-2-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds syscon-{reboot, poweroff} nodes to allow the
generic syscon-{reboot, poweroff} driver to reset/poweroff exynos3250 SoC.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 033def482fc3..af5d9ad4c7b7 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -152,6 +152,20 @@
 			interrupt-parent = <&gic>;
 		};
 
+		poweroff: syscon-poweroff {
+			compatible = "syscon-poweroff";
+			regmap = <&pmu_system_controller>;
+			offset = <0x330C>;
+			mask = <0x5200>;
+		};
+
+		reboot: syscon-reboot {
+			compatible = "syscon-reboot";
+			regmap = <&pmu_system_controller>;
+			offset = <0x0400>;
+			mask = <0x1>;
+		};
+
 		mipi_phy: video-phy at 10020710 {
 			compatible = "samsung,s5pv210-mipi-video-phy";
 			#phy-cells = <1>;
-- 
1.7.10.4
