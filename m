From: briannorris@chromium.org (Brian Norris)
Date: Fri,  5 Jan 2018 16:47:55 -0800
Subject: [PATCH 1/3] ARM: dts: rockchip: drop veyron's nonstandard
 'backlight-boot-off'
Message-ID: <20180106004757.8239-1-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was used out-of-tree as a hack for resolving issues where some
systems expect the backlight to turn on automatically at boot, while
others expect to manage the backlight status via a DRM/panel driver.
Those issues have since been fixed upstream in pwm_bl.c without device
tree hacks, and so this un-documented property should no longer be
useful.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
index d752a315f884..be487111d025 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
@@ -92,7 +92,6 @@
 			248 249 250 251 252 253 254 255>;
 		default-brightness-level = <128>;
 		enable-gpios = <&gpio7 RK_PA2 GPIO_ACTIVE_HIGH>;
-		backlight-boot-off;
 		pinctrl-names = "default";
 		pinctrl-0 = <&bl_en>;
 		pwms = <&pwm0 0 1000000 0>;
-- 
2.16.0.rc0.223.g4a4ac83678-goog
