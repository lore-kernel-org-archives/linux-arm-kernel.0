From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 10 Apr 2014 19:06:09 +0900
Subject: [PATCH 19/27] ARM: dts: exynos3250: Add Mobile Storage Host Card
In-Reply-To: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
References: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1397124377-16969-11-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

This patch add MSHC (Mobile Storage Host Controller) dt node which is an
interface between the system and SD/MMC card. mshc dt node is used for dw_mmc
device driver to operate SD/MMC card.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
[Modify the sdr/ddr timing for eMMC by Jaehoon Chung]
Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index a16c3ea..587a124 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -28,6 +28,8 @@
 	aliases {
 		pinctrl0 = &pinctrl_0;
 		pinctrl1 = &pinctrl_1;
+		mshc0 = &mshc_0;
+		mshc1 = &mshc_1;
 		i2c0 = &i2c_0;
 		i2c1 = &i2c_1;
 		i2c2 = &i2c_2;
@@ -92,6 +94,30 @@
 		interrupts = <0 240 0>;
 	};
 
+	mshc_0: mshc at 12510000 {
+		compatible = "samsung,exynos5250-dw-mshc";
+		reg = <0x12510000 0x1000>;
+		interrupts = <0 142 0>;
+		clocks = <&cmu CLK_SDMMC0>, <&cmu CLK_SCLK_MMC0>;
+		clock-names = "biu", "ciu";
+		fifo-depth = <0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	mshc_1: mshc at 12520000 {
+		compatible = "samsung,exynos5250-dw-mshc";
+		reg = <0x12520000 0x1000>;
+		interrupts = <0 143 0>;
+		clocks = <&cmu CLK_SDMMC1>, <&cmu CLK_SCLK_MMC1>;
+		clock-names = "biu", "ciu";
+		fifo-depth = <0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	adc: adc at 126C0000 {
 		compatible = "samsung,exynos-adc-v2";
 		reg = <0x126C0000 0x100>, <0x10020718 0x4>;
-- 
1.8.0
