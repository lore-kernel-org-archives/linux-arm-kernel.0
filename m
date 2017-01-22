From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 22 Jan 2017 22:05:28 +0100
Subject: [PATCH 3/3] ARM64: dts: meson-gxl: add the pwm_ao_b pin
In-Reply-To: <20170122210528.892-1-martin.blumenstingl@googlemail.com>
References: <20170122210528.892-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170122210528.892-4-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the pwm_ao_b pin to allow boards which have an LED connected
to GPIOAO_9 to use the leds-pwm driver (by activating the pwm_AO_ab node
and passing the pwm_ao_b_pin pinctrl-reference).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index b0070489e179..20e98a0bfb6e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -117,6 +117,13 @@
 				function = "remote_input_ao";
 			};
 		};
+
+		pwm_ao_b_pins: pwm_ao_b {
+			mux {
+				groups = "pwm_ao_b";
+				function = "pwm_ao_b";
+			};
+		};
 	};
 };
 
-- 
2.11.0
