From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sun, 17 May 2015 17:09:53 +0900
Subject: [PATCH v6 07/13] ARM: dts: Use labels for overriding nodes in
 exynos4x12
In-Reply-To: <1431850195-9558-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1431850195-9558-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1431850195-9558-12-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usage of labels instead of full paths reduces possible mistakes when
overriding nodes.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/boot/dts/exynos4x12.dtsi | 216 +++++++++++++++++++-------------------
 1 file changed, 108 insertions(+), 108 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 8cd27641cfb7..802116eed11b 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -96,32 +96,6 @@
 		};
 	};
 
-	combiner: interrupt-controller at 10440000 {
-		interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
-			     <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
-			     <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
-			     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>,
-			     <0 107 0>, <0 108 0>, <0 48 0>, <0 42 0>;
-	};
-
-	pinctrl_0: pinctrl at 11400000 {
-		compatible = "samsung,exynos4x12-pinctrl";
-		reg = <0x11400000 0x1000>;
-		interrupts = <0 47 0>;
-	};
-
-	pinctrl_1: pinctrl at 11000000 {
-		compatible = "samsung,exynos4x12-pinctrl";
-		reg = <0x11000000 0x1000>;
-		interrupts = <0 46 0>;
-
-		wakup_eint: wakeup-interrupt-controller {
-			compatible = "samsung,exynos4210-wakeup-eint";
-			interrupt-parent = <&gic>;
-			interrupts = <0 32 0>;
-		};
-	};
-
 	adc: adc at 126C0000 {
 		compatible = "samsung,exynos-adc-v1";
 		reg = <0x126C0000 0x100>;
@@ -135,30 +109,6 @@
 		status = "disabled";
 	};
 
-	pinctrl_2: pinctrl at 03860000 {
-		compatible = "samsung,exynos4x12-pinctrl";
-		reg = <0x03860000 0x1000>;
-		interrupt-parent = <&combiner>;
-		interrupts = <10 0>;
-	};
-
-	pinctrl_3: pinctrl at 106E0000 {
-		compatible = "samsung,exynos4x12-pinctrl";
-		reg = <0x106E0000 0x1000>;
-		interrupts = <0 72 0>;
-	};
-
-	pmu_system_controller: system-controller at 10020000 {
-		compatible = "samsung,exynos4212-pmu", "syscon";
-		clock-names = "clkout0", "clkout1", "clkout2", "clkout3",
-				"clkout4", "clkout8", "clkout9";
-		clocks = <&clock CLK_OUT_DMC>, <&clock CLK_OUT_TOP>,
-			<&clock CLK_OUT_LEFTBUS>, <&clock CLK_OUT_RIGHTBUS>,
-			<&clock CLK_OUT_CPU>, <&clock CLK_XXTI>,
-			<&clock CLK_XUSBXTI>;
-		#clock-cells = <1>;
-	};
-
 	g2d: g2d at 10800000 {
 		compatible = "samsung,exynos4212-g2d";
 		reg = <0x10800000 0x1000>;
@@ -173,40 +123,7 @@
 			 <&clock CLK_PIXELASYNCM0>, <&clock CLK_PIXELASYNCM1>;
 		clock-names = "sclk_cam0", "sclk_cam1", "pxl_async0", "pxl_async1";
 
-		fimc_0: fimc at 11800000 {
-			compatible = "samsung,exynos4212-fimc";
-			samsung,pix-limits = <4224 8192 1920 4224>;
-			samsung,mainscaler-ext;
-			samsung,isp-wb;
-			samsung,cam-if;
-		};
-
-		fimc_1: fimc at 11810000 {
-			compatible = "samsung,exynos4212-fimc";
-			samsung,pix-limits = <4224 8192 1920 4224>;
-			samsung,mainscaler-ext;
-			samsung,isp-wb;
-			samsung,cam-if;
-		};
-
-		fimc_2: fimc at 11820000 {
-			compatible = "samsung,exynos4212-fimc";
-			samsung,pix-limits = <4224 8192 1920 4224>;
-			samsung,mainscaler-ext;
-			samsung,isp-wb;
-			samsung,lcd-wb;
-			samsung,cam-if;
-		};
-
-		fimc_3: fimc at 11830000 {
-			compatible = "samsung,exynos4212-fimc";
-			samsung,pix-limits = <1920 8192 1366 1920>;
-			samsung,rotators = <0>;
-			samsung,mainscaler-ext;
-			samsung,isp-wb;
-			samsung,lcd-wb;
-		};
-
+		/* fimc_[0-3] are configured outside, under phandles */
 		fimc_lite_0: fimc-lite at 12390000 {
 			compatible = "samsung,exynos4212-fimc-lite";
 			reg = <0x12390000 0x1000>;
@@ -283,34 +200,117 @@
 		clock-names = "biu", "ciu";
 		status = "disabled";
 	};
+};
 
-	exynos-usbphy at 125B0000 {
-		compatible = "samsung,exynos4x12-usb2-phy";
-		samsung,sysreg-phandle = <&sys_reg>;
-	};
+&combiner {
+	interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
+		     <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
+		     <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
+		     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>,
+		     <0 107 0>, <0 108 0>, <0 48 0>, <0 42 0>;
+};
 
-	tmu at 100C0000 {
-		compatible = "samsung,exynos4412-tmu";
-		interrupt-parent = <&combiner>;
-		interrupts = <2 4>;
-		reg = <0x100C0000 0x100>;
-		clocks = <&clock 383>;
-		clock-names = "tmu_apbif";
-		status = "disabled";
-	};
+&exynos_usbphy {
+	compatible = "samsung,exynos4x12-usb2-phy";
+	samsung,sysreg-phandle = <&sys_reg>;
+};
 
-	jpeg-codec at 11840000 {
-		compatible = "samsung,exynos4212-jpeg";
-	};
+&fimc_0 {
+	compatible = "samsung,exynos4212-fimc";
+	samsung,pix-limits = <4224 8192 1920 4224>;
+	samsung,mainscaler-ext;
+	samsung,isp-wb;
+	samsung,cam-if;
+};
 
-	hdmi: hdmi at 12D00000 {
-		compatible = "samsung,exynos4212-hdmi";
-	};
+&fimc_1 {
+	compatible = "samsung,exynos4212-fimc";
+	samsung,pix-limits = <4224 8192 1920 4224>;
+	samsung,mainscaler-ext;
+	samsung,isp-wb;
+	samsung,cam-if;
+};
+
+&fimc_2 {
+	compatible = "samsung,exynos4212-fimc";
+	samsung,pix-limits = <4224 8192 1920 4224>;
+	samsung,mainscaler-ext;
+	samsung,isp-wb;
+	samsung,lcd-wb;
+	samsung,cam-if;
+};
+
+&fimc_3 {
+	compatible = "samsung,exynos4212-fimc";
+	samsung,pix-limits = <1920 8192 1366 1920>;
+	samsung,rotators = <0>;
+	samsung,mainscaler-ext;
+	samsung,isp-wb;
+	samsung,lcd-wb;
+};
+
+&hdmi {
+	compatible = "samsung,exynos4212-hdmi";
+};
+
+&jpeg_codec {
+	compatible = "samsung,exynos4212-jpeg";
+};
+
+&mixer {
+	compatible = "samsung,exynos4212-mixer";
+	clock-names = "mixer", "hdmi", "sclk_hdmi", "vp";
+	clocks = <&clock CLK_MIXER>, <&clock CLK_HDMI>,
+		 <&clock CLK_SCLK_HDMI>, <&clock CLK_VP>;
+};
 
-	mixer: mixer at 12C10000 {
-		compatible = "samsung,exynos4212-mixer";
-		clock-names = "mixer", "hdmi", "sclk_hdmi", "vp";
-		clocks = <&clock CLK_MIXER>, <&clock CLK_HDMI>,
-			 <&clock CLK_SCLK_HDMI>, <&clock CLK_VP>;
+&pinctrl_0 {
+	compatible = "samsung,exynos4x12-pinctrl";
+	reg = <0x11400000 0x1000>;
+	interrupts = <0 47 0>;
+};
+
+&pinctrl_1 {
+	compatible = "samsung,exynos4x12-pinctrl";
+	reg = <0x11000000 0x1000>;
+	interrupts = <0 46 0>;
+
+	wakup_eint: wakeup-interrupt-controller {
+		compatible = "samsung,exynos4210-wakeup-eint";
+		interrupt-parent = <&gic>;
+		interrupts = <0 32 0>;
 	};
 };
+
+&pinctrl_2 {
+	compatible = "samsung,exynos4x12-pinctrl";
+	reg = <0x03860000 0x1000>;
+	interrupt-parent = <&combiner>;
+	interrupts = <10 0>;
+};
+
+&pinctrl_3 {
+	compatible = "samsung,exynos4x12-pinctrl";
+	reg = <0x106E0000 0x1000>;
+	interrupts = <0 72 0>;
+};
+
+&pmu_system_controller {
+	compatible = "samsung,exynos4212-pmu", "syscon";
+	clock-names = "clkout0", "clkout1", "clkout2", "clkout3",
+			"clkout4", "clkout8", "clkout9";
+	clocks = <&clock CLK_OUT_DMC>, <&clock CLK_OUT_TOP>,
+		<&clock CLK_OUT_LEFTBUS>, <&clock CLK_OUT_RIGHTBUS>,
+		<&clock CLK_OUT_CPU>, <&clock CLK_XXTI>, <&clock CLK_XUSBXTI>;
+	#clock-cells = <1>;
+};
+
+&tmu {
+	compatible = "samsung,exynos4412-tmu";
+	interrupt-parent = <&combiner>;
+	interrupts = <2 4>;
+	reg = <0x100C0000 0x100>;
+	clocks = <&clock 383>;
+	clock-names = "tmu_apbif";
+	status = "disabled";
+};
-- 
2.1.4
