From: ryder.lee@mediatek.com (Ryder Lee)
Date: Mon, 2 Oct 2017 09:54:52 +0800
Subject: [PATCH v3 02/10] arm: dts: mt2701: enable display pwm backlight
In-Reply-To: <cover.1506908511.git.ryder.lee@mediatek.com>
References: <cover.1506908511.git.ryder.lee@mediatek.com>
Message-ID: <0f9441e9fc40e47e94927a3a4c96dd3f7f287d94.1506908511.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Weiqing Kong <weiqing.kong@mediatek.com>

This patch adds board related config for MT2701 pwm backlight.

Signed-off-by: Weiqing Kong <weiqing.kong@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 arch/arm/boot/dts/mt2701-evb.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701-evb.dts b/arch/arm/boot/dts/mt2701-evb.dts
index f484973..63af4b1 100644
--- a/arch/arm/boot/dts/mt2701-evb.dts
+++ b/arch/arm/boot/dts/mt2701-evb.dts
@@ -56,12 +56,29 @@
 	bt_sco_codec:bt_sco_codec {
 		compatible = "linux,bt-sco";
 	};
+
+	backlight_lcd: backlight_lcd {
+		compatible = "pwm-backlight";
+		pwms = <&bls 0 100000>;
+		brightness-levels = <
+			  0  16  32  48  64  80  96 112
+			128 144 160 176 192 208 224 240
+			255
+		>;
+		default-brightness-level = <9>;
+	};
 };
 
 &auxadc {
 	status = "okay";
 };
 
+&bls {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_bls_gpio>;
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins_a>;
@@ -111,6 +128,12 @@
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
