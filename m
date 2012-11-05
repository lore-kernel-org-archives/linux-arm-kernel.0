From: anilkumar@ti.com (AnilKumar Ch)
Date: Mon, 5 Nov 2012 16:15:47 +0530
Subject: [PATCH 07/10] ARM: dts: AM33XX: Add pinmux configuration for
 gpio-leds to EVMSK
In-Reply-To: <1352112350-13398-1-git-send-email-anilkumar@ti.com>
References: <1352112350-13398-1-git-send-email-anilkumar@ti.com>
Message-ID: <1352112350-13398-8-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinmux configurations for gpio based volume keys to am335x-evmsk.
In this patch, only single named mode/state is added and these pins
are configured during pinctrl driver initialization.

Default mode is nothing but the values required for the module during
active state. With this configurations module is functional as
expected.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 6f53879..659ec5b 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -30,6 +30,20 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
+	am33xx_pinmux: pinmux at 44e10800 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&user_leds_s0>;
+
+		user_leds_s0: user_leds_s0 {
+			pinctrl-single,pins = <
+				0x10 0x7	/* gpmc_ad4.gpio1_4, OUTPUT | MODE7 */
+				0x14 0x7	/* gpmc_ad5.gpio1_5, OUTPUT | MODE7 */
+				0x18 0x7	/* gpmc_ad6.gpio1_6, OUTPUT | MODE7 */
+				0x1c 0x7	/* gpmc_ad7.gpio1_7, OUTPUT | MODE7 */
+			>;
+		};
+	};
+
 	ocp {
 		uart1: serial at 44e09000 {
 			status = "okay";
-- 
1.7.9.5
