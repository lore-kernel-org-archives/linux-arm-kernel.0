From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 23 Jan 2015 15:29:55 +0100
Subject: [PATCH] ARM: dts: exynos4412-trats2: Add max77693 charger node
Message-ID: <1422023395-8407-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add to Trats2 DTS new node for configuring the max77693 charger driver.
Only the maxim,constant-microvolt differs from default value but set all
of the optional properties anyway.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 29231b452643..496a05faca37 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -549,6 +549,16 @@
 				haptic-supply = <&ldo26_reg>;
 				pwms = <&pwm 0 38022 0>;
 			};
+
+			charger {
+				compatible = "maxim,max77693-charger";
+
+				maxim,constant-microvolt = <4350000>;
+				maxim,min-system-microvolt = <3600000>;
+				maxim,thermal-regulation-celsius = <100>;
+				maxim,battery-overcurrent-microamp = <3500000>;
+				maxim,charge-input-threshold-microvolt = <4300000>;
+			};
 		};
 	};
 
-- 
1.9.1
