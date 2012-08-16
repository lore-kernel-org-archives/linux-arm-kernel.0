From: anilkumar@ti.com (AnilKumar Ch)
Date: Thu, 16 Aug 2012 17:50:08 +0530
Subject: [PATCH v4 2/4] arm/dts: AM33XX: Configure pinmuxs for user leds
 control on Bone
In-Reply-To: <1345119610-5247-1-git-send-email-anilkumar@ti.com>
References: <1345119610-5247-1-git-send-email-anilkumar@ti.com>
Message-ID: <1345119610-5247-3-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds GPIO pinctrl nodes to am3358_pinmux master node to control
user leds (USR0, USR1, USR2 and USR3) present on BeagleBone.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index a7906cb..58f5042 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -18,6 +18,20 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
+	am3358_pinmux: pinmux at 44E10800 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&userled_pins>;
+
+		userled_pins: pinmux_userled_pins {
+			pinctrl-single,pins = <
+				0x54 0x7	/* gpmc_a5.gpio1_21, OUTPUT | MODE7 */
+				0x58 0x17	/* gpmc_a6.gpio1_22, OUTPUT_PULLUP | MODE7 */
+				0x5C 0x7	/* gpmc_a7.gpio1_23, OUTPUT | MODE7 */
+				0x60 0x17	/* gpmc_a8.gpio1_24, OUTPUT_PULLUP | MODE7 */
+			>;
+		};
+	};
+
 	ocp {
 		uart1: serial at 44E09000 {
 			status = "okay";
-- 
1.7.9.5
