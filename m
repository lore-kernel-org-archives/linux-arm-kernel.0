From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 20 Sep 2015 08:30:48 -0400
Subject: [PATCH 2/5] ARM: dts: sun5i: Add PWM channel 0 pinmux setting for
 A13/A10s
In-Reply-To: <1442752251-20744-1-git-send-email-hdegoede@redhat.com>
References: <1442752251-20744-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1442752251-20744-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a pinmux setting for the first pwm channel. This is often used for
backlight dimming on tablets.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 5e036a4..f0714d3 100644
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
2.4.3
