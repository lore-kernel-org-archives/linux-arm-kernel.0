From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 29 Aug 2013 10:58:28 +0530
Subject: [PATCH 4/6] ARM: dts: add dt nodes for hdmi subsystem for exynos5420
In-Reply-To: <1377754110-31084-1-git-send-email-rahul.sharma@samsung.com>
References: <1377754110-31084-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1377754110-31084-4-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add hdmi, mixer, ddc device tree nodes for Exynos 5420 SoC.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5420-smdk5420.dts |   15 +++++++++++++++
 arch/arm/boot/dts/exynos5420.dtsi         |   19 +++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index bafba25..140565f 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -61,4 +61,19 @@
 		};
 	};
 
+	hdmi at 14530000 {
+		status = "okay";
+		hpd-gpio = <&gpx3 7 0>;
+	};
+
+	i2c_2: i2c at 12C80000 {
+		samsung,i2c-sda-delay = <100>;
+		samsung,i2c-max-bus-freq = <66000>;
+		status = "okay";
+
+		hdmiddc at 50 {
+			compatible = "samsung,exynos4210-hdmiddc";
+			reg = <0x50>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 05dee86..aff1679 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -274,4 +274,23 @@
 		pinctrl-0 = <&i2c3_bus>;
 		status = "disabled";
 	};
+
+	hdmi at 14530000 {
+		compatible = "samsung,exynos4212-hdmi";
+		reg = <0x14530000 0x70000>;
+		interrupts = <0 95 0>;
+		clocks = <&clock 413>, <&clock 143>, <&clock 2048>,
+			<&clock 158>, <&clock 1024>;
+		clock-names = "hdmi", "sclk_hdmi", "sclk_pixel",
+			"sclk_hdmiphy", "mout_hdmi";
+		status = "disabled";
+	};
+
+	mixer at 14450000 {
+		compatible = "samsung,exynos5420-mixer";
+		reg = <0x14450000 0x10000>;
+		interrupts = <0 94 0>;
+		clocks = <&clock 431>, <&clock 143>;
+		clock-names = "mixer", "sclk_hdmi";
+	};
 };
-- 
1.7.10.4
