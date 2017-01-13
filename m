From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Fri, 13 Jan 2017 13:38:02 +0100
Subject: [PATCH 08/10] ARM: dts: da850: add pinmux settings for the SATA
 controller
In-Reply-To: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
References: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1484311084-31547-9-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinmux sub-nodes for all muxed SATA pins.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 104155d..1f6a47d 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -78,6 +78,30 @@
 					0x10 0x00220000 0x00ff0000
 				>;
 			};
+			sata_cp_det_pin: pinmux_sata_cp_det_pin {
+				pinctrl-single,bits = <
+					/* SATA_CP_DET */
+					0x0c 0x00000000 0xf0000000
+				>;
+			};
+			sata_mp_switch_pin: pinmux_sata_mp_switch_pin {
+				pinctrl-single,bits = <
+					/* SATA_MP_SWITCH */
+					0x0c 0x00000000 0x0f000000
+				>;
+			};
+			sata_cp_pod_pin: pinmux_sata_cp_pod_pin {
+				pinctrl-single,bits = <
+					/* SATA_CP_POD */
+					0x10 0x40000000 0xf0000000
+				>;
+			};
+			sata_led_pin: pinmux_sata_led_pin {
+				pinctrl-single,bits = <
+					/* SATA_LED */
+					0x10 0x04000000 0x0f000000
+				>;
+			};
 			i2c0_pins: pinmux_i2c0_pins {
 				pinctrl-single,bits = <
 					/* I2C0_SDA,I2C0_SCL */
-- 
2.9.3
