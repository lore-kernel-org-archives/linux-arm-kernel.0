From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Sun, 27 Apr 2014 13:08:01 +0530
Subject: [PATCH v12 29/31] ARM: dts: add System MMU nodes of exynos4x12
In-Reply-To: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1398584283-22846-30-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cho KyongHo <pullip.cho@samsung.com>

This patch adds System MMU nodes that are specifict to exynos4x12
series.

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 arch/arm/boot/dts/exynos4x12.dtsi |   78 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index c4a9306..21cb164 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -119,7 +119,7 @@
 		interrupts = <0 72 0>;
 	};
 
-	g2d at 10800000 {
+	g2d: g2d at 10800000 {
 		compatible = "samsung,exynos4212-g2d";
 		reg = <0x10800000 0x1000>;
 		interrupts = <0 89 0>;
@@ -243,4 +243,80 @@
 		clock-names = "biu", "ciu";
 		status = "disabled";
 	};
+
+	sysmmu_g2d: sysmmu at 10A40000{
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x10A40000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 7>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_G2D>;
+		mmu-masters = <&g2d>;
+	};
+
+	sysmmu_fimc_isp: sysmmu at 12260000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x12260000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 2>;
+		samsung,power-domain = <&pd_isp>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_ISP>;
+		mmu-masters = <&fimc_is>;
+	};
+
+	sysmmu_fimc_drc: sysmmu at 12270000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x12270000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 3>;
+		samsung,power-domain = <&pd_isp>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_DRC>;
+		mmu-masters = <&fimc_is>;
+	};
+
+	sysmmu_fimc_fd: sysmmu at 122A0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x122A0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 4>;
+		samsung,power-domain = <&pd_isp>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FD>;
+		mmu-masters = <&fimc_is>;
+	};
+
+	sysmmu_fimc_mcuctl: sysmmu at 122B0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x122B0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 5>;
+		samsung,power-domain = <&pd_isp>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_ISPCX>;
+		mmu-masters = <&fimc_is>;
+	};
+
+	sysmmu_fimc_lite0: sysmmu at 123B0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x123B0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 0>;
+		samsung,power-domain = <&pd_isp>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_LITE0>;
+		mmu-masters = <&fimc_lite_0>;
+	};
+
+	sysmmu_fimc_lite1: sysmmu at 123C0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x123C0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 1>;
+		samsung,power-domain = <&pd_isp>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_LITE1>;
+		mmu-masters = <&fimc_lite_1>;
+	};
 };
-- 
1.7.9.5
