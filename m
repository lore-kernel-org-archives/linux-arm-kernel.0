From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 15 Nov 2012 03:37:27 +0530
Subject: [PATCH v3 05/11] ARM: dts: add exynos4 clock controller nodes
In-Reply-To: <1352930853-12268-1-git-send-email-thomas.abraham@linaro.org>
References: <1352930853-12268-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1352930853-12268-6-git-send-email-thomas.abraham@linaro.org>
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
index d6fc306..f7daa09 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -50,6 +50,12 @@
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
index 7cbbd19..bcfdaac 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -35,6 +35,12 @@
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
