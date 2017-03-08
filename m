From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Wed, 08 Mar 2017 10:42:37 +0900
Subject: [PATCH v11 3/3] arm64: dts: exynos: Add support for S6E3HA2 panel
 device on TM2 board
In-Reply-To: <1488937357-5623-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1488937357-5623-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170308014258epcas5p3eb57787aee92913e79bd467d5b285c0e@epcas5p3.samsung.com>
Message-ID: <1488937357-5623-4-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hyungwon Hwang <human.hwang@samsung.com>

This patch add the panel device tree node for S6E3HA2 display
controller to TM2 dts.

Signed-off-by: Hyungwon Hwang <human.hwang@samsung.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
index dea0a6f..db3fed2 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
@@ -52,6 +52,18 @@
 	assigned-clock-rates = <250000000>, <400000000>;
 };
 
+&dsi {
+	panel at 0 {
+		compatible = "samsung,s6e3ha2";
+		reg = <0>;
+		vdd3-supply = <&ldo27_reg>;
+		vci-supply = <&ldo28_reg>;
+		reset-gpios = <&gpg0 0 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&gpf1 5 GPIO_ACTIVE_HIGH>;
+		te-gpios = <&gpf1 3 GPIO_ACTIVE_HIGH>;
+	};
+};
+
 &hsi2c_9 {
 	status = "okay";
 
-- 
1.9.1
