From: ideal.song@samsung.com (Inha Song)
Date: Tue, 24 Feb 2015 18:31:55 +0900
Subject: [PATCH] ARM: dts: Add the source clock for CLKOUT register as xusbxti
Message-ID: <1424770315-4725-1-git-send-email-ideal.song@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the CLKOUT register source clock as xusbxti in
PMU (Power Management Unit) dt node on Exynos3250.

Cc: Kukjin Kim <kgene@kernel.org>
Signed-off-by: Inha Song <ideal.song@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 277b48b..aa1eb8c 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -130,6 +130,9 @@
 		pmu_system_controller: system-controller at 10020000 {
 			compatible = "samsung,exynos3250-pmu", "syscon";
 			reg = <0x10020000 0x4000>;
+			#clock-cells = <1>;
+			clock-names = "clkout9";
+			clocks = <&xusbxti>;
 		};
 
 		mipi_phy: video-phy at 10020710 {
-- 
2.0.0.390.gcb682f8
