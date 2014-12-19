From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 19 Dec 2014 18:40:59 +0530
Subject: [PATCH 2/2] arm64: dts: Add pinctrl support for audio IPs on exynos7
In-Reply-To: <1418994659-5222-1-git-send-email-padma.v@samsung.com>
References: <1418994659-5222-1-git-send-email-padma.v@samsung.com>
Message-ID: <1418994659-5222-3-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl support for I2S,PCM,SPDIF

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi |   56 +++++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos7.dtsi         |    7 +++
 2 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
index c367f0a..a5aeb07 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
@@ -333,6 +333,29 @@
 		samsung,pin-pud = <3>;
 		samsung,pin-drv = <0>;
 	};
+
+	i2s1_bus: i2s1-bus {
+		samsung,pins = "gpd4-0", "gpd4-1", "gpd4-2",
+				"gpd4-3", "gpd4-4";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <1>;
+		samsung,pin-drv = <0>;
+	};
+
+	pcm1_bus: pcm1-bus {
+		samsung,pins = "gpd4-0", "gpd4-2",
+				"gpd4-3", "gpd4-4";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <1>;
+		samsung,pin-drv = <0>;
+	};
+
+	spdif_bus: spdif-bus {
+		samsung,pins = "gpd4-3", "gpd4-4";
+		samsung,pin-function = <4>;
+		samsung,pin-pud = <1>;
+		samsung,pin-drv = <0>;
+	};
 };
 
 &pinctrl_bus1 {
@@ -668,3 +691,36 @@
 		samsung,pin-drv = <2>;
 	};
 };
+
+&pinctrl_aud {
+	gpz0: gpz0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpz1: gpz1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	i2s0_bus: i2s0-bus {
+		samsung,pins = "gpz0-0", "gpz0-1", "gpz0-2", "gpz0-3",
+				"gpz0-4";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <1>;
+		samsung,pin-drv = <0>;
+	};
+
+	pcm0_bus: pcm0-bus {
+		samsung,pins = "gpz1-0", "gpz1-1", "gpz1-2", "gpz1-3";
+		samsung,pin-function = <5>;
+		samsung,pin-pud = <1>;
+		samsung,pin-drv = <0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index e633b02..eeaa9b8d 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -27,6 +27,7 @@
 		pinctrl6 = &pinctrl_fsys0;
 		pinctrl7 = &pinctrl_fsys1;
 		pinctrl8 = &pinctrl_bus1;
+		pinctrl9 = &pinctrl_aud;
 	};
 
 	cpus {
@@ -285,6 +286,12 @@
 			interrupts = <0 203 0>;
 		};
 
+		pinctrl_aud: pinctrl at 114b0000 {
+			compatible = "samsung,exynos7-pinctrl";
+			reg = <0x114b0000 0x1000>;
+			interrupts = <0 92 0>;
+		};
+
 		hsi2c_0: hsi2c at 13640000 {
 			compatible = "samsung,exynos7-hsi2c";
 			reg = <0x13640000 0x1000>;
-- 
1.7.4.4
