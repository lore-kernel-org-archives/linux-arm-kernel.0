From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Mon, 19 May 2014 10:45:40 +0530
Subject: [PATCH V2 2/2] ARM: dts: enable pwm backlight for snow
In-Reply-To: <1400476540-14828-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1400476540-14828-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1400476540-14828-3-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PWM backlight node for exynos5250 based snow board.

Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 arch/arm/boot/dts/exynos5250-snow.dts |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 9d1ca09..09c79db 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -365,4 +365,14 @@
 		vdd_osc-supply = <&ldo10_reg>;
 		vdd_pll-supply = <&ldo8_reg>;
 	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 0 1000000 0>;
+		brightness-levels = <0 100 500 1000 1500 2000 2500 2800>;
+		default-brightness-level = <7>;
+		pinctrl-0 = <&pwm0_out>;
+		pinctrl-names = "default";
+	};
+
 };
-- 
1.7.9.5
