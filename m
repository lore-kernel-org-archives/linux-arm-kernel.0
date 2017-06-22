From: erin.lo@mediatek.com (Erin Lo)
Date: Thu, 22 Jun 2017 16:43:38 +0800
Subject: [PATCH v2 3/4] arm: dts: mt2701: Add display bls related nodes for
 MT2701
In-Reply-To: <1498121019-21984-1-git-send-email-erin.lo@mediatek.com>
References: <1498121019-21984-1-git-send-email-erin.lo@mediatek.com>
Message-ID: <1498121019-21984-4-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Weiqing Kong <weiqing.kong@mediatek.com>

This patch adds board related config for backlight

Signed-off-by: Weiqing Kong <weiqing.kong@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 arch/arm/boot/dts/mt2701-evb.dts | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701-evb.dts b/arch/arm/boot/dts/mt2701-evb.dts
index a483798..e49c2b7 100644
--- a/arch/arm/boot/dts/mt2701-evb.dts
+++ b/arch/arm/boot/dts/mt2701-evb.dts
@@ -22,6 +22,35 @@
 	memory {
 		reg = <0 0x80000000 0 0x40000000>;
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
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm_bls_gpio>;
+	};
+};
+
+&bls {
+	status = "okay";
+};
+
+&mmsys {
+	status = "okay";
+};
+
+&pio {
+	pwm_bls_gpio: pwm_bls_gpio {
+		pins_cmd_dat {
+			pinmux = <MT2701_PIN_208_AUD_EXT_CK1__FUNC_DISP_PWM>;
+		};
+	};
 };
 
 &auxadc {
-- 
1.9.1
