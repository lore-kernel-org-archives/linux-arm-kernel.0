From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 25 Jan 2017 12:50:28 +0100
Subject: [PATCH 4/7] arm64: dts: exynos: Add clocks to Exynos5433 LPASS module
In-Reply-To: <1485345031-2948-1-git-send-email-m.szyprowski@samsung.com>
References: <1485345031-2948-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170125115103eucas1p1d0e446fa6e998da257e3c17922a00d7f@eucas1p1.samsung.com>
Message-ID: <1485345031-2948-5-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos5433 LPASS module requires some clocks for proper operation with
power domain.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 57c7bbeb65a7..16072c1c3ed3 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1494,6 +1494,8 @@
 		audio-subsystem at 11400000 {
 			compatible = "samsung,exynos5433-lpass";
 			reg = <0x11400000 0x100>, <0x11500000 0x08>;
+			clocks = <&cmu_aud CLK_PCLK_SFR0_CTRL>;
+			clock-names = "sfr0_ctrl";
 			samsung,pmu-syscon = <&pmu_system_controller>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
1.9.1
