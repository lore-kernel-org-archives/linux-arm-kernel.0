From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 01 Jun 2016 10:02:20 +0200
Subject: [PATCH v3 11/12] ARM: dts: exynos: Switch the buck8 to GPIO mode on
 Odroid U3
In-Reply-To: <1464768141-25420-1-git-send-email-k.kozlowski@samsung.com>
References: <1464768141-25420-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1464768141-25420-12-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch the control of buck8 to GPIO mode. It is faster than I2C/register
mode and it is the easiest way to disable it (regulator state is a
logical OR state of GPIO and register value).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroidu3.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index d73aa6c58fe3..31cdc036fda4 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -74,6 +74,7 @@
 	regulator-name = "BUCK8_P3V3";
 	regulator-min-microvolt = <3300000>;
 	regulator-max-microvolt = <3300000>;
+	maxim,ena-gpios = <&gpa1 1 GPIO_ACTIVE_HIGH>;
 };
 
 /* VDDQ for MSHC (eMMC card) */
-- 
1.9.1
