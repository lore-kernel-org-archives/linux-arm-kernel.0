From: anilkumar@ti.com (AnilKumar Ch)
Date: Fri, 20 Jul 2012 13:01:48 +0530
Subject: [PATCH v2 2/2] arm/dts: Configure pinmuxs for user leds control on
 Bone
In-Reply-To: <1342769508-24810-1-git-send-email-anilkumar@ti.com>
References: <1342769508-24810-1-git-send-email-anilkumar@ti.com>
Message-ID: <1342769508-24810-3-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds GPIO pinctrl nodes to am3358_pinmux master node to control
user leds (USR0, USR1, USR2 and USR3) present on BeagleBone.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index a4d4415..452ce3f 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -28,3 +28,18 @@
 };
 
 /include/ "tps65217.dtsi"
+
+&am3358_pinmux {
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&userled_pins>;
+
+	userled_pins: pinmux_userled_pins {
+		pinctrl-single,pins = <
+			0x54 0x7	/* gpmc_a5.gpio1_21, OMAP_PIN_OUTPUT | OMAP_MUX_MODE7 */
+			0x58 0x17	/* gpmc_a6.gpio1_22, OMAP_PIN_OUTPUT_PULLUP | OMAP_MUX_MODE7 */
+			0x5C 0x7	/* gpmc_a7.gpio1_23, OMAP_PIN_OUTPUT | OMAP_MUX_MODE7 */
+			0x60 0x17	/* gpmc_a8.gpio1_24, OMAP_PIN_OUTPUT_PULLUP | OMAP_MUX_MODE7 */
+		>;
+	};
+};
-- 
1.7.0.4
