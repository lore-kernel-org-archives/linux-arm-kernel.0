From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 2 Jul 2015 17:06:17 +0300
Subject: [PATCH v2 02/20] ARM: DTS: am437x-sk-evm: Add sleep pin settings for
 mcasp1
In-Reply-To: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
References: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1435845995-19085-3-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When McASP is not in use the pins can be put to sleep mode to conserve
power.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index c17097d2c167..b5de6b0d622c 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -364,6 +364,15 @@
 		>;
 	};
 
+	mcasp1_pins_sleep: mcasp1_pins_sleep {
+		pinctrl-single,pins = <
+			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x108 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+		>;
+	};
+
 	lcd_pins: lcd_pins {
 		pinctrl-single,pins = <
 			0x1c (PIN_OUTPUT_PULLDOWN | MUX_MODE7) /* gpcm_ad7.gpio1_7 */
@@ -640,8 +649,9 @@
 };
 
 &mcasp1 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&mcasp1_pins>;
+	pinctrl-1 = <&mcasp1_pins_sleep>;
 
 	status = "okay";
 
-- 
2.4.5
