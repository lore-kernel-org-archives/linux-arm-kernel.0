From: m.purski@samsung.com (Maciej Purski)
Date: Mon, 28 May 2018 11:55:11 +0200
Subject: [PATCH 11/12] ARM: dts: exynos5250-arndale: add display regulators
In-Reply-To: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
References: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
 <CGME20180528095523eucas1p1039e1b62aaef415b66d6f62e86dbef93@eucas1p1.samsung.com>
Message-ID: <1527501311-16428-1-git-send-email-m.purski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds fixed regulators used by DSI/LVDS bridge
and panel. Regulators are named according to schematics.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 arch/arm/boot/dts/exynos5250-arndale.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 7a8a5c5..80221fa 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -97,6 +97,30 @@
 			reg = <2>;
 			regulator-name = "hdmi-en";
 		};
+
+		vcc_1v2_reg: regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "VCC_1V2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		vcc_1v8_reg: regulator at 4 {
+			compatible = "regulator-fixed";
+			reg = <4>;
+			regulator-name = "VCC_1V8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vcc_3v3_reg: regulator at 5 {
+			compatible = "regulator-fixed";
+			reg = <5>;
+			regulator-name = "VCC_3V3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
 	};
 
 	fixed-rate-clocks {
-- 
2.7.4
