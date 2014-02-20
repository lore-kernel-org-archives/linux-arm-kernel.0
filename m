From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 20 Feb 2014 20:40:37 +0100
Subject: [PATCH v4 10/10] ARM: dts: exynos4: Update clk provider part of the
 camera subsystem
In-Reply-To: <1392925237-31394-1-git-send-email-s.nawrocki@samsung.com>
References: <1392925237-31394-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1392925237-31394-12-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unused /camera/clock-controller node and required clock properties
to the camera node. This is required for a clock provider that will be
referenced by image sensor devices.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 08452e1..d1ee347 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -109,12 +109,10 @@
 		status = "disabled";
 		#address-cells = <1>;
 		#size-cells = <1>;
+		#clock-cells = <1>;
+		clock-output-names = "cam_mclk_a", "cam_mclk_b";
 		ranges;
 
-		clock_cam: clock-controller {
-			 #clock-cells = <1>;
-		};
-
 		fimc_0: fimc at 11800000 {
 			compatible = "samsung,exynos4210-fimc";
 			reg = <0x11800000 0x1000>;
-- 
1.7.9.5
