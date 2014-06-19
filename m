From: jaewon02.kim@samsung.com (Jaewon Kim)
Date: Thu, 19 Jun 2014 11:03:34 +0900
Subject: [PATCH v2] ARM: dts: exynos4: fix pwm-cells in pwm node
Message-ID: <1403143414-6242-1-git-send-email-jaewon02.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pwm-cells should be 3. Third cell is optional PWM flags. And This flag
supported by this binding is PWM_POLARITY_INVERTED.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---

Changes in v2:
 - Remove unnecessary handle.

 arch/arm/boot/dts/exynos4.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index b8ece4b..e118356 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -554,7 +554,7 @@
 		interrupts = <0 37 0>, <0 38 0>, <0 39 0>, <0 40 0>, <0 41 0>;
 		clocks = <&clock CLK_PWM>;
 		clock-names = "timers";
-		#pwm-cells = <2>;
+		#pwm-cells = <3>;
 		status = "disabled";
 	};
 
-- 
1.7.9.5
