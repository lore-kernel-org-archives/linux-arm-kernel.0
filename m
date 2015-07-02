From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 02 Jul 2015 09:42:40 +0900
Subject: [PATCH v6 2/3] ARM: dts: Add CPU OPP and regulator supply property for
 Exynos3250
In-Reply-To: <1435797761-3339-1-git-send-email-cw00.choi@samsung.com>
References: <1435797761-3339-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1435797761-3339-3-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add CPU operating points which include CPU frequency and regulator
voltage to use generic cpufreq drivers.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos3250-monk.dts   |  4 ++++
 arch/arm/boot/dts/exynos3250-rinato.dts |  4 ++++
 arch/arm/boot/dts/exynos3250.dtsi       | 15 +++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index a5863acc5fff..7863265d4868 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -141,6 +141,10 @@
 	};
 };
 
+&cpu0 {
+	cpu0-supply = <&buck2_reg>;
+};
+
 &exynos_usbphy {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 031853b75528..ddd7ac283045 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -132,6 +132,10 @@
 	};
 };
 
+&cpu0 {
+	cpu0-supply = <&buck2_reg>;
+};
+
 &exynos_usbphy {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index d7201333e3bc..e0f3b2ed41a3 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -53,6 +53,21 @@
 			compatible = "arm,cortex-a7";
 			reg = <0>;
 			clock-frequency = <1000000000>;
+			clocks = <&cmu CLK_ARM_CLK>;
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
1.8.5.5
