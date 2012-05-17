From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 17 May 2012 22:05:34 +0530
Subject: [PATCH 3/3] ARM: dts: Add nodes for dw_mmc controllers for Samsung
 Exynos5250 platforms
In-Reply-To: <1337272534-30370-1-git-send-email-thomas.abraham@linaro.org>
References: <1337272534-30370-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1337272534-30370-4-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device nodes for the four instances of dw_mmc controllers in Exynos5250
and enable instance 0 and 2 for the smdk5250 board.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/boot/dts/exynos5250-smdk5250.dts |   59 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi         |   32 +++++++++++++++
 2 files changed, 91 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index dbc4bdb..ac408c8 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -16,6 +16,13 @@
 	model = "SAMSUNG SMDK5250 board based on EXYNOS5250";
 	compatible = "samsung,smdk5250", "samsung,exynos5250";
 
+	aliases {
+		mshc0 = &mshc_0;
+		mshc1 = &mshc_1;
+		mshc2 = &mshc_2;
+		mshc3 = &mshc_3;
+	};
+
 	memory {
 		reg = <0x40000000 0x80000000>;
 	};
@@ -86,4 +93,56 @@
 	i2c at 12CD0000 {
 		status = "disabled";
 	};
+
+	mshc_0: dwmmc0 at 12200000 {
+		num-slots = <1>;
+		supports-highspeed;
+		card-detection-broken;
+		no-write-protect;
+		fifo-depth = <0x80>;
+		card-detect-delay = <200>;
+		samsung,dw-mshc-sdr-timing = <2 3 3>;
+		samsung,dw-mshc-ddr-timing = <1 2 3>;
+
+		slot at 0 {
+			reg = <0>;
+			bus-width = <8>;
+			cd-gpios = <&gpc0 2 2 3 3>;
+			gpios = <&gpc0 0 2 0 3>, <&gpc0 1 2 0 3>,
+				<&gpc1 0 2 3 3>, <&gpc1 1 2 3 3>,
+				<&gpc1 2 2 3 3>, <&gpc1 3 2 3 3>,
+				<&gpc0 3 2 3 3>, <&gpc0 4 2 3 3>,
+				<&gpc0 5 2 3 3>, <&gpc0 6 2 3 3>;
+		};
+	};
+
+	mshc_1: dwmmc1 at 12210000 {
+		status = "disabled";
+	};
+
+	mshc_2: dwmmc2 at 12220000 {
+		num-slots = <1>;
+		supports-highspeed;
+		card-detection-broken;
+		no-write-protect;
+		fifo-depth = <0x80>;
+		card-detect-delay = <200>;
+		samsung,dw-mshc-sdr-timing = <2 3 3>;
+		samsung,dw-mshc-ddr-timing = <1 2 3>;
+
+		slot at 0 {
+			reg = <0>;
+			bus-width = <4>;
+			cd-gpios = <&gpc3 2 2 3 3>;
+			gpios = <&gpc3 0 2 0 3>, <&gpc3 1 2 0 3>,
+				<&gpc3 3 2 3 3>, <&gpc3 4 2 3 3>,
+				<&gpc3 5 2 3 3>, <&gpc3 6 2 3 3>,
+				<&gpc4 3 3 3 3>, <&gpc4 3 3 3 3>,
+				<&gpc4 5 3 3 3>, <&gpc4 6 3 3 3>;
+		};
+	};
+
+	mshc_3: dwmmc3 at 12230000 {
+		status = "disabled";
+	};
 };
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index af12491..a6a497f 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -169,6 +169,38 @@
 		interrupts = <0 63 0>;
 	};
 
+	dwmmc0 at 12200000 {
+		compatible = "samsung,exynos5250-dw-mshc";
+		reg = <0x12200000 0x1000>;
+		interrupts = <0 75 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	dwmmc1 at 12210000 {
+		compatible = "samsung,exynos5250-dw-mshc";
+		reg = <0x12210000 0x1000>;
+		interrupts = <0 76 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	dwmmc2 at 12220000 {
+		compatible = "samsung,exynos5250-dw-mshc";
+		reg = <0x12220000 0x1000>;
+		interrupts = <0 77 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	dwmmc3 at 12230000 {
+		compatible = "samsung,exynos5250-dw-mshc";
+		reg = <0x12230000 0x1000>;
+		interrupts = <0 78 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
 	amba {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.6.6.rc2
