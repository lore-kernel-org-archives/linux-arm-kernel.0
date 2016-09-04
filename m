From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  4 Sep 2016 13:04:16 +0200
Subject: [PATCH v3 13/17] ARM: dts: exynos: Fix mismatched values of SD drive
 strengh configuration on exynos4415
In-Reply-To: <1472987060-28293-1-git-send-email-krzk@kernel.org>
References: <1472987060-28293-1-git-send-email-krzk@kernel.org>
Message-ID: <1472987060-28293-14-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>

The pinctrl drive strength register on exynos4415 is 2-bit wide for each
pin.  The pins for SD2 were configured with value of 4.  The driver does
not validate the value so this overflow effectively set a bit 1 in
adjacent pins thus configuring them to drive strength 2x.

The author's intention was probably to set drive strength of 4x.
All other SD pins are configured with drive strength of 4x.  Fix these
with same pattern.

Fixes: 9246e7ff24c5 ("ARM: dts: Add dts files for exynos4415 SoC")
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos4415-pinctrl.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4415-pinctrl.dtsi b/arch/arm/boot/dts/exynos4415-pinctrl.dtsi
index f54aee53b6ec..76cfd872ead3 100644
--- a/arch/arm/boot/dts/exynos4415-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4415-pinctrl.dtsi
@@ -480,14 +480,14 @@
 		samsung,pins = "gpk2-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-		samsung,pin-drv = <4>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd2_cmd: sd2-cmd {
 		samsung,pins = "gpk2-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-		samsung,pin-drv = <4>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd2_cd: sd2-cd {
@@ -501,14 +501,14 @@
 		samsung,pins = "gpk2-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <4>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd2_bus4: sd2-bus-width4 {
 		samsung,pins = "gpk2-4", "gpk2-5", "gpk2-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <4>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	cam_port_b_io: cam-port-b-io {
-- 
2.7.4
