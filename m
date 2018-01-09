From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 09 Jan 2018 16:59:06 +0900
Subject: [PATCH 9/9] arm64: dts: exynos: Add cpu topology information for
 Exynos5433 SoC
In-Reply-To: <1515484746-10656-1-git-send-email-cw00.choi@samsung.com>
References: <1515484746-10656-1-git-send-email-cw00.choi@samsung.com>
 <CGME20180109075906epcas1p288212118a5d58bc15d62a2d828772a49@epcas1p2.samsung.com>
Message-ID: <1515484746-10656-10-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the 'cpu-map' for the cpu topology information
of Exynos5433 which has the following two clusters.
- cluster0 contains the four LITTLE cores (cpu0-3).
- cluster1 contains the four big cores (cpu4-7).

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 32 ++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 0d99ded21202..ea54022f4f44 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -27,6 +27,38 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+				core2 {
+					cpu = <&cpu2>;
+				};
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu4>;
+				};
+				core1 {
+					cpu = <&cpu5>;
+				};
+				core2 {
+					cpu = <&cpu6>;
+				};
+				core3 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
 		cpu0: cpu at 100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
-- 
1.9.1
