From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 21 Jun 2013 14:50:21 +0200
Subject: [PATCH 5/8] ARM: dts: Add camera nodes for Exynos4 SoCs
In-Reply-To: <1371819024-12596-1-git-send-email-s.nawrocki@samsung.com>
References: <1371819024-12596-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1371819024-12596-6-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds common FIMC and MIPI CSIS device nodes for Exynos4 SoCs.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park at samsung.com
---
 arch/arm/boot/dts/exynos4.dtsi |   68 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index bce2254..4d61120 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -36,6 +36,12 @@
 		i2c5 = &i2c_5;
 		i2c6 = &i2c_6;
 		i2c7 = &i2c_7;
+		csis0 = &csis_0;
+		csis1 = &csis_1;
+		fimc0 = &fimc_0;
+		fimc1 = &fimc_1;
+		fimc2 = &fimc_2;
+		fimc3 = &fimc_3;
 	};
 
 	chipid@10000000 {
@@ -92,6 +98,68 @@
 		reg = <0x10010000 0x400>;
 	};
 
+	camera {
+		compatible = "samsung,fimc", "simple-bus";
+		status = "disabled";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		fimc_0: fimc at 11800000 {
+			compatible = "samsung,exynos4210-fimc";
+			reg = <0x11800000 0x1000>;
+			interrupts = <0 84 0>;
+			samsung,power-domain = <&pd_cam>;
+			samsung,sysreg = <&sys_reg>;
+			status = "disabled";
+		};
+
+		fimc_1: fimc at 11810000 {
+			compatible = "samsung,exynos4210-fimc";
+			reg = <0x11810000 0x1000>;
+			interrupts = <0 85 0>;
+			samsung,power-domain = <&pd_cam>;
+			samsung,sysreg = <&sys_reg>;
+			status = "disabled";
+		};
+
+		fimc_2: fimc at 11820000 {
+			compatible = "samsung,exynos4210-fimc";
+			reg = <0x11820000 0x1000>;
+			interrupts = <0 86 0>;
+			samsung,power-domain = <&pd_cam>;
+			samsung,sysreg = <&sys_reg>;
+			status = "disabled";
+		};
+
+		fimc_3: fimc at 11830000 {
+			compatible = "samsung,exynos4210-fimc";
+			reg = <0x11830000 0x1000>;
+			interrupts = <0 87 0>;
+			samsung,power-domain = <&pd_cam>;
+			samsung,sysreg = <&sys_reg>;
+			status = "disabled";
+		};
+
+		csis_0: csis at 11880000 {
+			compatible = "samsung,exynos4210-csis";
+			reg = <0x11880000 0x4000>;
+			interrupts = <0 78 0>;
+			bus-width = <4>;
+			samsung,power-domain = <&pd_cam>;
+			status = "disabled";
+		};
+
+		csis_1: csis at 11890000 {
+			compatible = "samsung,exynos4210-csis";
+			reg = <0x11890000 0x4000>;
+			interrupts = <0 80 0>;
+			bus-width = <2>;
+			samsung,power-domain = <&pd_cam>;
+			status = "disabled";
+		};
+	};
+
 	watchdog at 10060000 {
 		compatible = "samsung,s3c2410-wdt";
 		reg = <0x10060000 0x100>;
-- 
1.7.9.5
