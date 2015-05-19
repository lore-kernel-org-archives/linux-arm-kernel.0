From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 19 May 2015 15:20:42 +0200
Subject: [PATCH v7 22/25] ARM: dts: exynos5250: add sysmmu nodes
In-Reply-To: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1432041645-11172-23-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds System MMU nodes to all defined devices that are specific
to Exynos5250 series.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi | 250 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 250 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 257e2f10525d..96471eabeb24 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -230,6 +230,7 @@
 		interrupts = <0 91 0>;
 		clocks = <&clock CLK_G2D>;
 		clock-names = "fimg2d";
+		iommus = <&sysmmu_g2d>;
 	};
 
 	mfc: codec at 11000000 {
@@ -239,6 +240,8 @@
 		power-domains = <&pd_mfc>;
 		clocks = <&clock CLK_MFC>;
 		clock-names = "mfc";
+		iommus = <&sysmmu_mfc_l>, <&sysmmu_mfc_r>;
+		iommu-names = "left", "right";
 	};
 
 	rtc: rtc at 101E0000 {
@@ -720,6 +723,7 @@
 		power-domains = <&pd_gsc>;
 		clocks = <&clock CLK_GSCL0>;
 		clock-names = "gscl";
+		iommu = <&sysmmu_gsc1>;
 	};
 
 	gsc_1:  gsc at 13e10000 {
@@ -729,6 +733,7 @@
 		power-domains = <&pd_gsc>;
 		clocks = <&clock CLK_GSCL1>;
 		clock-names = "gscl";
+		iommu = <&sysmmu_gsc1>;
 	};
 
 	gsc_2:  gsc at 13e20000 {
@@ -738,6 +743,7 @@
 		power-domains = <&pd_gsc>;
 		clocks = <&clock CLK_GSCL2>;
 		clock-names = "gscl";
+		iommu = <&sysmmu_gsc2>;
 	};
 
 	gsc_3:  gsc at 13e30000 {
@@ -747,6 +753,7 @@
 		power-domains = <&pd_gsc>;
 		clocks = <&clock CLK_GSCL3>;
 		clock-names = "gscl";
+		iommu = <&sysmmu_gsc3>;
 	};
 
 	hdmi: hdmi {
@@ -770,6 +777,7 @@
 		clocks = <&clock CLK_MIXER>, <&clock CLK_HDMI>,
 			 <&clock CLK_SCLK_HDMI>;
 		clock-names = "mixer", "hdmi", "sclk_hdmi";
+		iommus = <&sysmmu_tv>;
 	};
 
 	dp_phy: video-phy at 10040720 {
@@ -790,6 +798,7 @@
 		power-domains = <&pd_disp1>;
 		clocks = <&clock CLK_SCLK_FIMD1>, <&clock CLK_FIMD1>;
 		clock-names = "sclk_fimd", "fimd";
+		iommus = <&sysmmu_fimd1>;
 	};
 
 	adc: adc at 12D10000 {
@@ -811,4 +820,245 @@
 		clocks = <&clock CLK_SSS>;
 		clock-names = "secss";
 	};
+
+	sysmmu_gsc0: sysmmu at 13E80000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x13E80000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <2 0>;
+		power-domains = <&pd_gsc>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_GSCL0>, <&clock CLK_GSCL0>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_gsc1: sysmmu at 13E90000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x13E90000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <2 2>;
+		power-domains = <&pd_gsc>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_GSCL1>, <&clock CLK_GSCL1>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_gsc2: sysmmu at 13EA0000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x13EA0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <2 4>;
+		power-domains = <&pd_gsc>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_GSCL2>, <&clock CLK_GSCL2>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_gsc3: sysmmu at 13EB0000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x13EB0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <2 6>;
+		power-domains = <&pd_gsc>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_GSCL3>, <&clock CLK_GSCL3>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_mfc_r: sysmmu at 11200000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x11200000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <6 2>;
+		power-domains = <&pd_mfc>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_MFCR>, <&clock CLK_MFC>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_mfc_l: sysmmu at 11210000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x11210000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <8 5>;
+		power-domains = <&pd_mfc>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_MFCL>, <&clock CLK_MFC>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_tv: sysmmu at 14650000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x14650000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <7 4>;
+		power-domains = <&pd_disp1>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_TV>, <&clock CLK_MIXER>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimd1: sysmmu at 14640000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x14640000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <3 2>;
+		power-domains = <&pd_disp1>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_FIMD1>, <&clock CLK_FIMD1>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_g2d: sysmmu at 10A60000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x10A60000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <24 5>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_2D>, <&clock CLK_G2D>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_rotator: sysmmu at 11D40000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x11D40000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 0>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_ROTATOR>, <&clock CLK_ROTATOR>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_jpeg: sysmmu at 11F20000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x11F20000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 2>;
+		power-domains = <&pd_gsc>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_JPEG>, <&clock CLK_JPEG>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc_isp: sysmmu at 13260000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x13260000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <10 6>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_ISP>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc_drc: sysmmu at 13270000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x13270000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <11 6>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_DRC>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc_fd: sysmmu at 132A0000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x132A0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 0>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_FD>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc_scc: sysmmu at 13280000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x13280000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 2>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_SCC>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc_scp: sysmmu at 13290000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x13290000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <3 6>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_SCP>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc_mcuctl: sysmmu at 132B0000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x132B0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 4>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_MCU>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc_odc: sysmmu at 132C0000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x132C0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <11 0>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_ODC>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc_dis0: sysmmu at 132D0000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x132D0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <10 4>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_DIS0>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc_dis1: sysmmu at 132E0000{
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x132E0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <9 4>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_DIS1>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc_3dnr: sysmmu at 132F0000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x132F0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 6>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_3DNR>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc_lite0: sysmmu at 13C40000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x13C40000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <3 4>;
+		power-domains = <&pd_gsc>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_FIMC_LITE0>, <&clock CLK_CAMIF_TOP>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc_lite1: sysmmu at 13C50000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x13C50000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <24 1>;
+		power-domains = <&pd_gsc>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_FIMC_LITE1>, <&clock CLK_CAMIF_TOP>;
+		#iommu-cells = <0>;
+	};
 };
-- 
1.9.2
