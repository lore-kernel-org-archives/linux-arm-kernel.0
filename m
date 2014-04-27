From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Sun, 27 Apr 2014 13:07:59 +0530
Subject: [PATCH v12 27/31] ARM: dts: add System MMU nodes of exynos4 series
In-Reply-To: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1398584283-22846-28-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cho KyongHo <pullip.cho@samsung.com>

This patch adds System MMU nodes that are common to exynos4 series.

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi |  107 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 2f8bcd0..229efee 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -536,4 +536,111 @@
 		samsung,power-domain = <&pd_lcd0>;
 		status = "disabled";
 	};
+
+	sysmmu_mfc_l: sysmmu at 13620000 {
+		compatible = "samsung,sysmmu-v2";
+		reg = <0x13620000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 5>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_MFCL>;
+		samsung,power-domain = <&pd_mfc>;
+		mmu-masters = <&mfc>;
+	};
+
+	sysmmu_mfc_r: sysmmu at 13630000 {
+		compatible = "samsung,sysmmu-v2";
+		reg = <0x13630000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 6>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_MFCR>;
+		samsung,power-domain = <&pd_mfc>;
+		mmu-masters = <&mfc>;
+	};
+
+	sysmmu_tv: sysmmu at 12E20000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x12E20000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 4>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_TV>;
+		samsung,power-domain = <&pd_tv>;
+	};
+
+	sysmmu_fimc0: sysmmu at 11A20000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x11A20000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 2>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC0>;
+		samsung,power-domain = <&pd_cam>;
+		mmu-masters = <&fimc_0>;
+	};
+
+	sysmmu_fimc1: sysmmu at 11A30000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x11A30000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 3>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC1>;
+		samsung,power-domain = <&pd_cam>;
+		mmu-masters = <&fimc_1>;
+	};
+
+	sysmmu_fimc2: sysmmu at 11A40000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x11A40000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 4>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC2>;
+		samsung,power-domain = <&pd_cam>;
+		mmu-masters = <&fimc_2>;
+	};
+
+	sysmmu_fimc3: sysmmu at 11A50000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x11A50000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 5>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC3>;
+		samsung,power-domain = <&pd_cam>;
+		mmu-masters = <&fimc_3>;
+	};
+
+	sysmmu_jpeg: sysmmu at 11A60000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x11A60000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 6>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_JPEG>;
+		samsung,power-domain = <&pd_cam>;
+	};
+
+	sysmmu_rotator: sysmmu at 12A30000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x12A30000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 0>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_ROTATOR>;
+		samsung,power-domain = <&pd_lcd0>;
+	};
+
+	sysmmu_fimd0: sysmmu at 11E20000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x11E20000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 2>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMD0>;
+		samsung,power-domain = <&pd_lcd0>;
+		mmu-masters = <&fimd>;
+	};
 };
-- 
1.7.9.5
