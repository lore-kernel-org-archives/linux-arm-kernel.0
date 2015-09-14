From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Mon, 14 Sep 2015 11:01:33 +0530
Subject: [PATCH v2] arm64: dts: Add BUS1 instance pinctrl support
Message-ID: <1442208693-23644-1-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds BUS1 instance pinctrl for exynos7 soc.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
Changes since v1:
- Removed etc1 gpio as per Krzysztof review comments.

 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi |  103 +++++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos7.dtsi         |    7 ++
 2 files changed, 110 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
index 2eef4a2..f77ddaf 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
@@ -586,3 +586,106 @@
 		samsung,pin-drv = <2>;
 	};
 };
+
+&pinctrl_bus1 {
+	gpf0: gpf0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf1: gpf1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf2: gpf2 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf3: gpf3 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf4: gpf4 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf5: gpf5 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg1: gpg1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg2: gpg2 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gph1: gph1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpv6: gpv6 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	spi5_bus: spi5-bus {
+		samsung,pins = "gpf2-0", "gpf2-1", "gpf2-2", "gpf2-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	ufs_refclk_out: ufs-refclk-out {
+		samsung,pins = "gpg2-4";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <2>;
+	};
+
+	ufs_rst_n: ufs-rst-n {
+		samsung,pins = "gph1-5";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index d7a37c3..f9c5a54 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -26,6 +26,7 @@
 		pinctrl5 = &pinctrl_ese;
 		pinctrl6 = &pinctrl_fsys0;
 		pinctrl7 = &pinctrl_fsys1;
+		pinctrl8 = &pinctrl_bus1;
 	};
 
 	cpus {
@@ -278,6 +279,12 @@
 			interrupts = <0 203 0>;
 		};
 
+		pinctrl_bus1: pinctrl at 14870000 {
+			compatible = "samsung,exynos7-pinctrl";
+			reg = <0x14870000 0x1000>;
+			interrupts = <0 384 0>;
+		};
+
 		hsi2c_0: hsi2c at 13640000 {
 			compatible = "samsung,exynos7-hsi2c";
 			reg = <0x13640000 0x1000>;
-- 
1.7.10.4
