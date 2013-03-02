From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Sat,  2 Mar 2013 15:04:14 +0530
Subject: [PATCH V2 4/4] dts: Add cpufreq controller node for Exynos5440 SoC
In-Reply-To: <1362216854-6633-1-git-send-email-amit.daniel@samsung.com>
References: <1362216854-6633-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <1362216854-6633-4-git-send-email-amit.daniel@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add cpufreq controller device node for Exynos5440 SoC for passing
parameters like controller base address, interrupt and cpufreq
table. This node is added inside cpu0 node as done in other cpufreq
drivers.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm/boot/dts/exynos5440.dtsi |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 5f3562a..fd0c811 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -31,6 +31,19 @@
 				interrupts = <1 13 0xf08>;
 				clock-frequency = <1000000>;
 			};
+
+			cpufreq at 160000 {
+				compatible = "samsung,exynos5440-cpufreq";
+				reg = <0x160000 0x1000>;
+				interrupts = <0 57 0>;
+				operating-points = <
+					/* KHZ	  uV */
+					1200000 1025000
+					1000000 975000
+					800000  925000
+					>;
+				clocks = <&clock 2>;
+			};
 		};
 		cpu at 1 {
 			compatible = "arm,cortex-a15";
-- 
1.7.1
