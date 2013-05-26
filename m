From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 26 May 2013 12:20:42 +0200
Subject: [PATCHv2 6/6] ARM: sun4i: cubieboard: Enable the i2c controllers
In-Reply-To: <1369563642-4390-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1369563642-4390-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1369563642-4390-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emilio L?pez <emilio@elopez.com.ar>

The Cubieboard makes use of the first two i2c controllers found on the
Allwinner A10; i2c-0 is used internally for the PMIC, while i2c-1
is exposed on the board headers. This patch enables them in the device
tree.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index b70fe0d..0e22a28 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -41,6 +41,18 @@
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
1.8.2.3
