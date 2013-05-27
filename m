From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 May 2013 12:00:42 +0200
Subject: [PATCHv3 5/6] ARM: sun5i: olinuxino: Enable the i2c controllers
In-Reply-To: <1369648843-1640-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1369648843-1640-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1369648843-1640-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A13-Olinuxino makes use of the 3 i2c controllers found on the Allwinner
A13. Enable them in the device tree.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 3ca5506..80497e3 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -37,6 +37,24 @@
 			pinctrl-0 = <&uart1_pins_b>;
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
+
+		i2c2: i2c at 01c2b400 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_pins_a>;
+			status = "okay";
+		};
 	};
 
 	leds {
-- 
1.8.2.3
