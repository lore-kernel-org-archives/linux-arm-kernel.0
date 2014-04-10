From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 10 Apr 2014 19:06:14 +0900
Subject: [PATCH 24/27] ARM: dts: exynos3250: Add pwm dt node to support PWM
 Timer
In-Reply-To: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
References: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1397124377-16969-16-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Figa <t.figa@samsung.com>

This patch add pwm dt node to support PWM (Pulse Width Modulation) timer.
Exynos uses same IP of Exynos4210 and has five 32-bit PWM timers.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 03e7931..c8bd33cf 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -345,6 +345,15 @@
 		status = "disabled";
 	};
 
+	pwm: pwm at 139D0000 {
+		compatible = "samsung,exynos4210-pwm";
+		reg = <0x139D0000 0x1000>;
+		interrupts = <0 104 0>, <0 105 0>, <0 106 0>,
+			     <0 107 0>, <0 108 0>;
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
 	pmu {
 		compatible = "arm,cortex-a7-pmu";
 		interrupts = <0 18 0>, <0 19 0>, <0 20 0>, <0 21 0>;
-- 
1.8.0
