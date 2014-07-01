From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 01 Jul 2014 09:40:10 +0900
Subject: [PATCH] ARM: dts: Add TMU dt node to monitor the temperature for
 Exynos3250
Message-ID: <1404175210-9278-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add TMU (Thermal Management Unit) dt node to monitor the high
temperature for Exynos3250.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
This patch has a dependency on following patch [1]:
 [1] https://lkml.org/lkml/2014/6/30/805

 arch/arm/boot/dts/exynos3250.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 3660cab..1e566af 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -192,6 +192,16 @@
 			status = "disabled";
 		};
 
+		tmu: tmu at 100C0000 {
+			compatible = "samsung,exynos3250-tmu";
+			interrupt-parent = <&gic>;
+			reg = <0x100C0000 0x100>;
+			interrupts = <0 216 0>;
+			clocks = <&cmu CLK_TMU_APBIF>;
+			clock-names = "tmu_apbif";
+			status = "disabled";
+		};
+
 		gic: interrupt-controller at 10481000 {
 			compatible = "arm,cortex-a15-gic";
 			#interrupt-cells = <3>;
-- 
1.8.0
