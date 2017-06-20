From: faiz_abbas@ti.com (Faiz Abbas)
Date: Tue, 20 Jun 2017 10:39:21 +0530
Subject: [PATCH] ARM: dts: am437x-gp-evm: Add support for buzzer
Message-ID: <1497935361-11019-1-git-send-email-faiz_abbas@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for onboard gpio buzzer. It works using
the gpio-beeper driver. Pinmux entries for GPIO
controlling the buzzer are also added.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 397e98b..24cdf6d 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -149,6 +149,13 @@
 			system-clock-frequency = <12000000>;
 		};
 	};
+
+	beeper: beeper {
+		compatible = "gpio-beeper";
+		pinctrl-names = "default";
+		pinctrl-0 = <&beeper_pins>;
+		gpios = <&gpio4 12 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &am43xx_pinmux {
@@ -510,6 +517,13 @@
 			AM4372_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
 		>;
 	};
+
+	beeper_pins: beeper_pins {
+		pinctrl-single,pins = <
+			AM4372_IOPAD(0x9e0, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* cam1_field.gpio4_12 */
+		>;
+	};
+
 };
 
 &uart0 {
-- 
2.7.4
