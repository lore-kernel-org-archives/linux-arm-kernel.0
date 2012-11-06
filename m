From: anilkumar@ti.com (AnilKumar Ch)
Date: Tue, 6 Nov 2012 19:18:31 +0530
Subject: [PATCH RESEND 03/10] ARM: dts: AM33XX: Add pinmux configuration for
 volume-keys to EVM
In-Reply-To: <1352209718-5586-1-git-send-email-anilkumar@ti.com>
References: <1352209718-5586-1-git-send-email-anilkumar@ti.com>
Message-ID: <1352209718-5586-4-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinmux configurations for gpio volume keys. In this patch, only
single named mode/state is added and these pins are configured during
pinctrl driver initialization.

Default mode is nothing but the values required for the module during
active state. With this configurations module is functional as
expected.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 8076e66..e087b87 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -26,7 +26,7 @@
 
 	am33xx_pinmux: pinmux at 44e10800 {
 		pinctrl-names = "default";
-		pinctrl-0 = <&matrix_keypad_s0>;
+		pinctrl-0 = <&matrix_keypad_s0 &volume_keys_s0>;
 
 		matrix_keypad_s0: matrix_keypad_s0 {
 			pinctrl-single,pins = <
@@ -37,6 +37,13 @@
 				0x6c 0x27	/* gpmc_a11.gpio1_27, INPUT | MODE7 */
 			>;
 		};
+
+		volume_keys_s0: volume_keys_s0 {
+			pinctrl-single,pins = <
+				0x150 0x27	/* spi0_sclk.gpio0_2, INPUT | MODE7 */
+				0x154 0x27	/* spi0_d0.gpio0_3, INPUT | MODE7 */
+			>;
+		};
 	};
 
 	ocp {
-- 
1.7.9.5
