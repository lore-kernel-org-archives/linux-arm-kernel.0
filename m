From: andrzej.p@samsung.com (Andrzej Pietrasiewicz)
Date: Fri, 18 Sep 2015 16:21:00 +0200
Subject: [PATCH 4/4] ARM64: dts: exynos5433: add jpeg node
In-Reply-To: <1442586060-23657-1-git-send-email-andrzej.p@samsung.com>
References: <1442586060-23657-1-git-send-email-andrzej.p@samsung.com>
Message-ID: <1442586060-23657-5-git-send-email-andrzej.p@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

Add Exynos 5433 jpeg h/w codec node.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 59e21b6..5cb489f 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -916,6 +916,27 @@
 			io-channel-ranges;
 			status = "disabled";
 		};
+		jpeg: jpeg at 15020000 {
+			compatible = "samsung,exynos5433-jpeg";
+			reg = <0x15020000 0x10000>;
+			interrupts = <0 411 0>;
+			clock-names = "pclk",
+				      "aclk",
+				      "aclk_xiu",
+				      "sclk";
+			clocks = <&cmu_mscl CLK_PCLK_JPEG>,
+				 <&cmu_mscl CLK_ACLK_JPEG>,
+				 <&cmu_mscl CLK_ACLK_XIU_MSCLX>,
+				 <&cmu_mscl CLK_SCLK_JPEG>;
+			assigned-clocks = <&cmu_mscl CLK_MOUT_ACLK_MSCL_400_USER>,
+					  <&cmu_mscl CLK_MOUT_SCLK_JPEG_USER>,
+					  <&cmu_mscl CLK_MOUT_SCLK_JPEG>,
+					  <&cmu_top CLK_MOUT_SCLK_JPEG_A>;
+			assigned-clock-parents = <&cmu_top CLK_ACLK_MSCL_400>,
+						 <&cmu_top CLK_SCLK_JPEG_MSCL>,
+						 <&cmu_mscl CLK_MOUT_SCLK_JPEG_USER>,
+						 <&cmu_top CLK_MOUT_BUS_PLL_USER>;
+		};
 	};
 
 	timer {
-- 
1.9.1
