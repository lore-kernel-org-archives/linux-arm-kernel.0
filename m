From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Wed, 25 Nov 2015 08:39:34 +0200
Subject: [PATCH 02/18] ARM: am57xx: cl-som-am57x: dts: add RTC support
In-Reply-To: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1448433590-1399-3-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add EM3027 RTC chip support (over I2C4 bus).

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index b11d7da..773e5389 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -52,6 +52,13 @@
 		>;
 	};
 
+	i2c4_pins_default: i2c4_pins_default {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x36ac, PIN_INPUT| MUX_MODE10)	/* mcasp1_acl.i2c4_sda */
+			DRA7XX_CORE_IOPAD(0x36b0, PIN_INPUT| MUX_MODE10)	/* mcasp1_fsr.i2c4_scl */
+		>;
+	};
+
 	tps659038_pins_default: tps659038_pins_default {
 		pinctrl-single,pins = <
 			DRA7XX_CORE_IOPAD(0x3818, PIN_INPUT_PULLUP | MUX_MODE14) /* wakeup0.gpio1_0 */
@@ -257,3 +264,17 @@
 		status = "okay";
 	};
 };
+
+&i2c4 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_pins_default>;
+	clock-frequency = <100000>;
+
+	rtc0: rtc at 56 {
+		compatible = "emmicro,em3027";
+		reg = <0x56>;
+	};
+};
+
+
-- 
1.9.1
