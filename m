From: anilkumar@ti.com (AnilKumar Ch)
Date: Mon, 5 Nov 2012 16:15:41 +0530
Subject: [PATCH 01/10] ARM: dts: AM33XX: Add pinmux configuration for matrix
 keypad to EVM
In-Reply-To: <1352112350-13398-1-git-send-email-anilkumar@ti.com>
References: <1352112350-13398-1-git-send-email-anilkumar@ti.com>
Message-ID: <1352112350-13398-2-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinmux configurations for gpio matrix keypad. In this patch, only
single named mode/state is added and these pins are configured during
pinctrl driver initialization.

Default mode is nothing but the values required for the module during
active state. With this configurations module is functional as
expected.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 513284f..9199456 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -24,6 +24,21 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
+	am33xx_pinmux: pinmux at 44e10800 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&matrix_keypad_s0>;
+
+		matrix_keypad_s0: matrix_keypad_s0 {
+			pinctrl-single,pins = <
+				0x54 0x7	/* gpmc_a5.gpio1_21, OUTPUT | MODE7 */
+				0x58 0x7	/* gpmc_a6.gpio1_22, OUTPUT | MODE7 */
+				0x64 0x27	/* gpmc_a9.gpio1_25, INPUT | MODE7 */
+				0x68 0x27	/* gpmc_a10.gpio1_26, INPUT | MODE7 */
+				0x6c 0x27	/* gpmc_a11.gpio1_27, INPUT | MODE7 */
+			>;
+		};
+	};
+
 	ocp {
 		uart1: serial at 44e09000 {
 			status = "okay";
-- 
1.7.9.5
