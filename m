From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 22 Jan 2017 22:05:26 +0100
Subject: [PATCH 1/3] ARM64: dts: meson-gx: add the missing pwm_AO_ab node
In-Reply-To: <20170122210528.892-1-martin.blumenstingl@googlemail.com>
References: <20170122210528.892-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170122210528.892-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All Meson GX SoCs (GXBB, GXL and GXM) have a PWM controller within the
AO domain. When one of the board's LEDs is connected to one of the AO
PWM pins then this can be used to dim that LED (when the leds-pwm driver
is used).
Add the pwm_AO_ab to allow such devices to use the leds-pwm driver.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index c76a690967f8..3e3fb6972567 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -340,6 +340,13 @@
 				status = "disabled";
 			};
 
+			pwm_AO_ab: pwm at 550 {
+				compatible = "amlogic,meson-gx-pwm", "amlogic,meson-gxbb-pwm";
+				reg = <0x0 0x00550 0x0 0x10>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
 			ir: ir at 580 {
 				compatible = "amlogic,meson-gxbb-ir";
 				reg = <0x0 0x00580 0x0 0x40>;
-- 
2.11.0
