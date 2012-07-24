From: anilkumar@ti.com (AnilKumar Ch)
Date: Tue, 24 Jul 2012 21:15:19 +0530
Subject: [PATCH v3 2/2] arm/dts: Configure pinmuxs for user leds control on
 Bone
In-Reply-To: <1343144719-26352-1-git-send-email-anilkumar@ti.com>
References: <1343144719-26352-1-git-send-email-anilkumar@ti.com>
Message-ID: <1343144719-26352-3-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds GPIO pinctrl nodes to am3358_pinmux master node to control
user leds (USR0, USR1, USR2 and USR3) present on BeagleBone.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 8fdf43a..b0c98cd 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -46,3 +46,18 @@
 	regulator-boot-on;
 	regulator-always-on;
 };
+
+&am3358_pinmux {
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&userled_pins>;
+
+	userled_pins: pinmux_userled_pins {
+		pinctrl-single,pins = <
+			0x54 0x7	/* gpmc_a5.gpio1_21, OUTPUT | MODE7 */
+			0x58 0x17	/* gpmc_a6.gpio1_22, OUTPUT_PULLUP | MODE7 */
+			0x5C 0x7	/* gpmc_a7.gpio1_23, OUTPUT | MODE7 */
+			0x60 0x17	/* gpmc_a8.gpio1_24, OUTPUT_PULLUP | MODE7 */
+		>;
+	};
+};
-- 
1.7.9.5
