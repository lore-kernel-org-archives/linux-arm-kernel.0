From: erin.lo@mediatek.com (Erin Lo)
Date: Tue, 1 Aug 2017 15:03:31 +0800
Subject: [PATCH 3/5] arm: dts: mt2701: Add display bls related nodes for MT2701
In-Reply-To: <1501571013-22327-1-git-send-email-erin.lo@mediatek.com>
References: <1501571013-22327-1-git-send-email-erin.lo@mediatek.com>
Message-ID: <1501571013-22327-4-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Weiqing Kong <weiqing.kong@mediatek.com>

This patch adds board related config for backlight

Signed-off-by: Weiqing Kong <weiqing.kong@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 arch/arm/boot/dts/mt2701-evb.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701-evb.dts b/arch/arm/boot/dts/mt2701-evb.dts
index f484973..b96e34d 100644
--- a/arch/arm/boot/dts/mt2701-evb.dts
+++ b/arch/arm/boot/dts/mt2701-evb.dts
@@ -23,6 +23,19 @@
 		reg = <0 0x80000000 0 0x40000000>;
 	};
 
+	backlight_lcd: backlight_lcd {
+		compatible = "pwm-backlight";
+		pwms = <&bls 0 100000>;
+		brightness-levels = <
+			  0  16  32  48  64  80  96 112
+			128 144 160 176 192 208 224 240
+			255
+		>;
+		default-brightness-level = <9>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm_bls_gpio>;
+	};
+
 	sound:sound {
 		compatible = "mediatek,mt2701-cs42448-machine";
 		mediatek,platform = <&afe>;
@@ -62,6 +75,10 @@
 	status = "okay";
 };
 
+&bls {
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins_a>;
@@ -86,6 +103,10 @@
 	};
 };
 
+&mmsys {
+	status = "okay";
+};
+
 &pio {
 	i2c0_pins_a: i2c0 at 0 {
 		pins1 {
@@ -111,6 +132,12 @@
 		};
 	};
 
+	pwm_bls_gpio: pwm_bls_gpio {
+		pins_cmd_dat {
+			pinmux = <MT2701_PIN_208_AUD_EXT_CK1__FUNC_DISP_PWM>;
+		};
+	};
+
 	spi_pins_a: spi0 at 0 {
 		pins_spi {
 			pinmux = <MT2701_PIN_53_SPI0_CSN__FUNC_SPI0_CS>,
-- 
1.9.1
