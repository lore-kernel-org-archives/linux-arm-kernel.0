From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 31 Mar 2016 11:48:02 +0900
Subject: [PATCH v4 6/9] ARM: dts: Add initial gpio setting of MMC2 device for
 exynos3250-monk
In-Reply-To: <1459392485-11327-1-git-send-email-cw00.choi@samsung.com>
References: <1459392485-11327-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1459392485-11327-7-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds initial pin configuration of MMC2 device on exynos3250-monk
board because the MMC2 gpio pin (gpk2[0-6]) are NC (not connected) state.

Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos3250-monk.dts | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index 9e2840b59ae8..267f81adb42f 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -558,7 +558,17 @@
 
 &pinctrl_1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&sleep1>;
+	pinctrl-0 = <&initial1 &sleep1>;
+
+	initial1: initial-state {
+		PIN_IN(gpk2-0, DOWN, LV1);
+		PIN_IN(gpk2-1, DOWN, LV1);
+		PIN_IN(gpk2-2, DOWN, LV1);
+		PIN_IN(gpk2-3, DOWN, LV1);
+		PIN_IN(gpk2-4, DOWN, LV1);
+		PIN_IN(gpk2-5, DOWN, LV1);
+		PIN_IN(gpk2-6, DOWN, LV1);
+	};
 
 	sleep1: sleep-state {
 		PIN_SLP(gpe0-0, PREV, NONE);
-- 
1.9.1
