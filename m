From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 11 Sep 2013 11:30:05 +0200
Subject: [PATCH 4/4] ARM: sun7i: olinuxino-micro: Enable the I2C controllers
In-Reply-To: <1378891805-28957-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1378891805-28957-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1378891805-28957-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A20-olinuxino-micro uses the first three I2C controllers found on
the A20. Enable them in the DT.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 9e77855..ead3013 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -60,6 +60,24 @@
 			pinctrl-0 = <&uart7_pins_a>;
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
1.8.4
