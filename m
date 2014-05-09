From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri,  9 May 2014 18:30:10 +0530
Subject: [PATCH 4/4] ARM: dts: Add pmu-syscon handle for Exynos5420/Exynos5250
 clock
In-Reply-To: <1399640410-30957-1-git-send-email-tushar.behera@linaro.org>
References: <1399640410-30957-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1399640410-30957-5-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

XCLKOUT in Exynos5420/Exynos5250 is controlled through a register in
PMU domain. Pass pmu-syscon handle to the clock driver so that XCLKOUT
can be properly configured.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
CC: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi |    1 +
 arch/arm/boot/dts/exynos5420.dtsi |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 3742331..214db94 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -86,6 +86,7 @@
 		compatible = "samsung,exynos5250-clock";
 		reg = <0x10010000 0x30000>;
 		#clock-cells = <1>;
+		samsung,pmu-syscon = <&pmu_system_controller>;
 	};
 
 	clock_audss: audss-clock-controller at 3810000 {
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index c3a9a66..489bd08 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -114,6 +114,7 @@
 		compatible = "samsung,exynos5420-clock";
 		reg = <0x10010000 0x30000>;
 		#clock-cells = <1>;
+		samsung,pmu-syscon = <&pmu_system_controller>;
 	};
 
 	clock_audss: audss-clock-controller at 3810000 {
-- 
1.7.9.5
