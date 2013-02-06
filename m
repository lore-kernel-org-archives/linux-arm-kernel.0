From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Wed,  6 Feb 2013 11:39:22 -0800
Subject: [PATCH 3/3] dts: Add cpufreq controller node for Exynos5440 SoC
In-Reply-To: <1360179562-19950-1-git-send-email-amit.daniel@samsung.com>
References: <1360179562-19950-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <1360179562-19950-3-git-send-email-amit.daniel@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add cpufreq controller device node for Exynos5440 SoC for passing
parameters like controller base address, interrupt and cpufreq
table.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm/boot/dts/exynos5440.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 024269d..b20b517 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -63,6 +63,15 @@
 
 	};
 
+	cpufreq at 160000 {
+		compatible = "samsung,exynos5440-cpufreq";
+		reg = <0x160000 0x1000>;
+		interrupts = <0 57 0>;
+		cpufreq_tbl = <	1200000 1025000
+				1000000 975000
+				800000  925000 >;
+	};
+
 	serial at B0000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0xB0000 0x1000>;
-- 
1.7.10.4
