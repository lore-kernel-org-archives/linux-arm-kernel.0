From: anilkumar@ti.com (AnilKumar Ch)
Date: Tue, 6 Nov 2012 19:18:37 +0530
Subject: [PATCH RESEND 09/10] ARM: dts: AM33XX: Add pinmux configuration for
 gpio-keys to EVMSK
In-Reply-To: <1352209718-5586-1-git-send-email-anilkumar@ti.com>
References: <1352209718-5586-1-git-send-email-anilkumar@ti.com>
Message-ID: <1352209718-5586-10-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinmux configurations for gpio based keys to am335x-evmsk. In
this patch, only single named mode/state is added and these pins
are configured during pinctrl driver initialization.

Default mode is nothing but the values required for the module during
active state. With this configurations module is functional as
expected.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 7262fa8..0f825dd 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -32,7 +32,7 @@
 
 	am33xx_pinmux: pinmux at 44e10800 {
 		pinctrl-names = "default";
-		pinctrl-0 = <&user_leds_s0>;
+		pinctrl-0 = <&user_leds_s0 &gpio_keys_s0>;
 
 		user_leds_s0: user_leds_s0 {
 			pinctrl-single,pins = <
@@ -42,6 +42,15 @@
 				0x1c 0x7	/* gpmc_ad7.gpio1_7, OUTPUT | MODE7 */
 			>;
 		};
+
+		gpio_keys_s0: gpio_keys_s0 {
+			pinctrl-single,pins = <
+				0x94 0x27	/* gpmc_oen_ren.gpio2_3, INPUT | MODE7 */
+				0x90 0x27	/* gpmc_advn_ale.gpio2_2, INPUT | MODE7 */
+				0x70 0x27	/* gpmc_wait0.gpio0_30, INPUT | MODE7 */
+				0x9c 0x27	/* gpmc_ben0_cle.gpio2_5, INPUT | MODE7 */
+			>;
+		};
 	};
 
 	ocp {
-- 
1.7.9.5
