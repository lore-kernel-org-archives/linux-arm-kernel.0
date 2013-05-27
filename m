From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 May 2013 12:00:41 +0200
Subject: [PATCHv3 4/6] ARM: sun5i: dt: Add i2c muxing options
In-Reply-To: <1369648843-1640-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1369648843-1640-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1369648843-1640-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2c controller found on the Allwinner A13 has only one muxing option
available for each controller. Add them to the dtsi

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a13.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 16df784..450b410 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -182,6 +182,27 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
+			i2c0_pins_a: i2c0 at 0 {
+				allwinner,pins = "PB0", "PB1";
+				allwinner,function = "i2c0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			i2c1_pins_a: i2c1 at 0 {
+				allwinner,pins = "PB15", "PB16";
+				allwinner,function = "i2c1";
+				allwinner,drive = <0>;
+				allwinner,pull = <1>;
+			};
+
+			i2c2_pins_a: i2c2 at 0 {
+				allwinner,pins = "PB17", "PB18";
+				allwinner,function = "i2c2";
+				allwinner,drive = <0>;
+				allwinner,pull = <1>;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
1.8.2.3
