From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 11 Sep 2013 11:30:03 +0200
Subject: [PATCH 2/4] ARM: sun7i: Add the pin muxing options for the I2C
 controllers
In-Reply-To: <1378891805-28957-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1378891805-28957-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1378891805-28957-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A20 boards we currently have share the same pins for the i2c
controllers they share. Add them to the DTSI.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 82b1af3..b939d30 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -215,6 +215,27 @@
 				allwinner,pull = <0>;
 			};
 
+			i2c0_pins_a: i2c0 at 0 {
+				allwinner,pins = "PB0", "PB1";
+				allwinner,function = "i2c0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			i2c1_pins_a: i2c1 at 0 {
+				allwinner,pins = "PB18", "PB19";
+				allwinner,function = "i2c1";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			i2c2_pins_a: i2c2 at 0 {
+				allwinner,pins = "PB20", "PB21";
+				allwinner,function = "i2c2";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			emac_pins_a: emac0 at 0 {
 				allwinner,pins = "PA0", "PA1", "PA2",
 						"PA3", "PA4", "PA5", "PA6",
-- 
1.8.4
