From: jaewon02.kim@samsung.com (Jaewon Kim)
Date: Thu, 12 Jun 2014 17:23:12 +0900
Subject: [PATCH] ARM: dts: exynos4: fix pwm-cells in pwm node
Message-ID: <1402561392-21702-1-git-send-email-jaewon02.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pwm-cells should be 3. Third cell is optional PWM flags.
And This flag supported by this binding is PWM_POLARITY_INVERTED

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index b8ece4b..b687e53 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -548,13 +548,13 @@
 		status = "disabled";
 	};
 
-	pwm at 139D0000 {
+	pwm: pwm at 139D0000 {
 		compatible = "samsung,exynos4210-pwm";
 		reg = <0x139D0000 0x1000>;
 		interrupts = <0 37 0>, <0 38 0>, <0 39 0>, <0 40 0>, <0 41 0>;
 		clocks = <&clock CLK_PWM>;
 		clock-names = "timers";
-		#pwm-cells = <2>;
+		#pwm-cells = <3>;
 		status = "disabled";
 	};
 
-- 
1.7.9.5
