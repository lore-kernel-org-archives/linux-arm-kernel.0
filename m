From: plaes@plaes.org (Priit Laes)
Date: Fri, 11 Dec 2015 23:23:00 +0200
Subject: [PATCH] ARM: dts: sun4i: gemei-g9: Enable PA GPIO pin configuration
In-Reply-To: <1449868980-28237-1-git-send-email-plaes@plaes.org>
References: <1449868980-28237-1-git-send-email-plaes@plaes.org>
Message-ID: <1449868980-28237-2-git-send-email-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PA GPIO pin (PH15) controls power to external amplifier (FT2012Q).

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
index 1d73a98..ac64781 100644
--- a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
@@ -65,13 +65,16 @@
 /*
  * TODO:
  *   2x cameras via CSI
- *   audio input
  *   AXP battery management
  *   NAND
  *   OTG
  *   Touchscreen - gt801_2plus1 @ i2c adapter 2 @ 0x48
  */
 &codec {
+	/* PH15 controls power to external amplifier (ft2012q) */
+	pinctrl-names = "default";
+	pinctrl-0 = <&codec_pa_pin>;
+	allwinner,pa-gpios = <&pio 7 15 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
 
@@ -151,6 +154,15 @@
 	status = "okay";
 };
 
+&pio {
+	codec_pa_pin: codec_pa_pin at 0 {
+		allwinner,pins = "PH15";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
 &reg_dcdc2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1000000>;
-- 
2.6.4
