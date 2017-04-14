From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Fri, 14 Apr 2017 14:19:39 +0900
Subject: [PATCH 3/3] arm64: dts: exynos: Add support for S6E3HA2 edge panel
 device on TM2e board
In-Reply-To: <1492147179-7824-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1492147179-7824-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170414051959epcas1p3a246070b065129c4ffbf94736cde321a@epcas1p3.samsung.com>
Message-ID: <1492147179-7824-4-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the panel device tree node for S6E3HA2 edge display
controller to TM2e dts.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
index 694717a..79f22f7 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
@@ -52,6 +52,18 @@
 	assigned-clock-rates = <278000000>, <400000000>;
 };
 
+&dsi {
+	panel at 0 {
+		compatible = "samsung,s6e3ha2-e";
+		reg = <0>;
+		vdd3-supply = <&ldo27_reg>;
+		vci-supply = <&ldo28_reg>;
+		reset-gpios = <&gpg0 0 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&gpf1 5 GPIO_ACTIVE_HIGH>;
+		te-gpios = <&gpf1 3 GPIO_ACTIVE_HIGH>;
+	};
+};
+
 &ldo31_reg {
 	regulator-name = "TSP_VDD_1.8V_AP";
 	regulator-min-microvolt = <1800000>;
-- 
1.9.1
