From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 11 Sep 2013 11:30:04 +0200
Subject: [PATCH 3/4] ARM: sun7i: cubieboard2: Enable the I2C controllers
In-Reply-To: <1378891805-28957-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1378891805-28957-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1378891805-28957-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cubieboard2 uses both the i2c0 and i2c1 controllers. Enable them in
the DT.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 15e625e..5c51cb8 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -48,6 +48,18 @@
 			pinctrl-0 = <&uart0_pins_a>;
 			status = "okay";
 		};
+
+		i2c0: i2c at 01c2ac00 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins_a>;
+			status = "okay";
+		};
+
+		i2c1: i2c at 01c2b000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pins_a>;
+			status = "okay";
+		};
 	};
 
 	leds {
-- 
1.8.4
