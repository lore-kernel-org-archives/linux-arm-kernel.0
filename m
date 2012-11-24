From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sun, 25 Nov 2012 02:47:59 +0530
Subject: [PATCH v4 06/12] ARM: dts: add exynos4 clock controller nodes
In-Reply-To: <1353791885-2566-1-git-send-email-thomas.abraham@linaro.org>
References: <1353791885-2566-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1353791885-2566-7-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock controller nodes for Exynos4210 and Exynos4x12 SoC's.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/boot/dts/exynos4210.dtsi |    6 ++++++
 arch/arm/boot/dts/exynos4x12.dtsi |    6 ++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index cca1546..74e656e 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -55,6 +55,12 @@
 		samsung,mct-nr-local-irqs = <4>;
 	};
 
+	clock: clock-controller at 0x10030000 {
+		compatible = "samsung,exynos4210-clock";
+		reg = <0x10030000 0x20000>;
+		#clock-cells = <1>;
+	};
+
 	pinctrl_0: pinctrl at 11400000 {
 		compatible = "samsung,pinctrl-exynos4210";
 		reg = <0x11400000 0x1000>;
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 179a62e..3b8da68 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -36,6 +36,12 @@
 			     <0 16 0>, <0 17 0>, <0 18 0>, <0 19 0>;
 	};
 
+	clock: clock-controller at 0x10030000 {
+		compatible = "samsung,exynos4412-clock";
+		reg = <0x10030000 0x20000>;
+		#clock-cells = <1>;
+	};
+
 	pinctrl_0: pinctrl at 11400000 {
 		compatible = "samsung,pinctrl-exynos4x12";
 		reg = <0x11400000 0x1000>;
-- 
1.7.4.4
