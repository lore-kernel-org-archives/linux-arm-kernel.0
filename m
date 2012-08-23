From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 23 Aug 2012 10:42:31 +0200
Subject: [PATCH 4/4] ARM: dts: mxs: add oled support for the cfa-10036
In-Reply-To: <1345711351-16367-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1345711351-16367-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1345711351-16367-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Brian Lilly <brian@crystalfontz.com>
---
 arch/arm/boot/dts/imx28-cfa10036.dts |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
index c03a577..92784a9 100644
--- a/arch/arm/boot/dts/imx28-cfa10036.dts
+++ b/arch/arm/boot/dts/imx28-cfa10036.dts
@@ -33,11 +33,31 @@
 		};
 
 		apbx at 80040000 {
+			pwm: pwm at 80064000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pwm4_pins_a>;
+				status = "okay";
+			};
+
 			duart: serial at 80074000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&duart_pins_b>;
 				status = "okay";
 			};
+
+			i2c0: i2c at 80058000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&i2c0_pins_b>;
+				status = "okay";
+
+				ssd1307: oled at 3c {
+					compatible = "solomon,ssd1307fb-i2c";
+					reg = <0x3c>;
+					pwms = <&pwm 4 3000>;
+					oled-reset-gpio = <&gpio2 7 1>;
+					oled-reset-active-low;
+				};
+			};
 		};
 	};
 
-- 
1.7.9.5
