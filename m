From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 20 Oct 2014 21:08:42 +0900
Subject: [PATCHv4 4/4] ARM: dts: Add CPU OPP and regulator supply property for
 Exynos3250
In-Reply-To: <1413806922-22722-1-git-send-email-cw00.choi@samsung.com>
References: <1413806922-22722-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1413806922-22722-5-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add CPU operating points which include CPU frequency and regulator
voltage to use generic cpufreq drivers.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Reviewed-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 693a327..0b5bea8 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -52,6 +52,21 @@
 			compatible = "arm,cortex-a7";
 			reg = <0>;
 			clock-frequency = <1000000000>;
+			clocks = <&cmu CLK_DIV_CORE2>;
+			clock-names = "cpu";
+
+			operating-points = <
+				1000000 1150000
+				900000  1112500
+				800000  1075000
+				700000  1037500
+				600000  1000000
+				500000  962500
+				400000  925000
+				300000  887500
+				200000  850000
+				100000  850000
+			>;
 		};
 
 		cpu1: cpu at 1 {
-- 
1.8.0
