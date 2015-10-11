From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 11 Oct 2015 11:55:06 +0200
Subject: [PATCH v3 2/4] ARM: dts: sun5i: Add PWM channel 0 pinmux setting for
 A13/A10s
In-Reply-To: <1444557308-10892-1-git-send-email-hdegoede@redhat.com>
References: <1444557308-10892-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1444557308-10892-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a pinmux setting for the first pwm channel. This is often used for
backlight dimming on tablets.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 78b993a..8f54256 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -529,6 +529,13 @@
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 			};
+
+			pwm0_pins: pwm0 {
+				allwinner,pins = "PB2";
+				allwinner,function = "pwm";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
2.5.0
