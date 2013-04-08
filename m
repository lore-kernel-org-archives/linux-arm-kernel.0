From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Mon,  8 Apr 2013 13:47:38 +0530
Subject: [PATCH V6 4/4] arm: dts: Add cpufreq controller node for Exynos5440
 SoC
In-Reply-To: <1365409058-32643-1-git-send-email-amit.daniel@samsung.com>
References: <1365409058-32643-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <1365409058-32643-5-git-send-email-amit.daniel@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add cpufreq controller device node for Exynos5440 SoC for passing
parameters like controller base address, interrupt and cpufreq
table. This node is added outside cpu0 as this driver is now a platform
driver and a new device structure is needed.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm/boot/dts/exynos5440.dtsi |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 9a99755..94074ea 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -63,6 +63,18 @@
 
 	};
 
+	cpufreq at 160000 {
+		compatible = "samsung,exynos5440-cpufreq";
+		reg = <0x160000 0x1000>;
+		interrupts = <0 57 0>;
+		operating-points = <
+				/* KHz	  uV */
+				1200000 1025000
+				1000000 975000
+				800000  925000
+		>;
+	};
+
 	serial at B0000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0xB0000 0x1000>;
-- 
1.7.1
