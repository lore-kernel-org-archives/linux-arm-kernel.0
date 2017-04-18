From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Tue, 18 Apr 2017 17:40:36 +0900
Subject: [PATCH v3 3/3] arm64: dts: exynos: Add support for s6e3hf2 panel
 device on TM2e board
In-Reply-To: <1492504836-19225-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1492504836-19225-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170418084047epcas5p42535837ac327ec48730ca766176bf86d@epcas5p4.samsung.com>
Message-ID: <1492504836-19225-4-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the panel device tree node for s6e3hf2 display
controller to TM2e dts.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
index 694717a..b73e123 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
@@ -52,6 +52,17 @@
 	assigned-clock-rates = <278000000>, <400000000>;
 };
 
+&dsi {
+	panel at 0 {
+		compatible = "samsung,s6e3hf2";
+		reg = <0>;
+		vdd3-supply = <&ldo27_reg>;
+		vci-supply = <&ldo28_reg>;
+		reset-gpios = <&gpg0 0 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&gpf1 5 GPIO_ACTIVE_HIGH>;
+	};
+};
+
 &ldo31_reg {
 	regulator-name = "TSP_VDD_1.8V_AP";
 	regulator-min-microvolt = <1800000>;
-- 
1.9.1
