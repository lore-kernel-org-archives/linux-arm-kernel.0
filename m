From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Jun 2013 10:07:15 +0200
Subject: [PATCHv4 6/9] ARM: sun4i: dt: Add i2c muxing options
In-Reply-To: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1371024438-16631-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2c controller found on the Allwinner A10 has only one muxing option
available for each controller. Add them to the dtsi

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index f7e4a96..c2adc74 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -227,6 +227,26 @@
 				allwinner,function = "emac";
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
+
+			i2c0_pins_a: i2c0 at 0 {
+				allwinner,pins = "PB0", "PB1";
+				allwinner,function = "i2c0";
+				allwinner,drive = <0>;
+				allwinner,pull = <1>;
+			};
+
+			i2c1_pins_a: i2c1 at 0 {
+				allwinner,pins = "PB18", "PB19";
+				allwinner,function = "i2c1";
+				allwinner,drive = <0>;
+				allwinner,pull = <1>;
+			};
+
+			i2c2_pins_a: i2c2 at 0 {
+				allwinner,pins = "PB20", "PB21";
+				allwinner,function = "i2c2";
+				allwinner,drive = <0>;
+				allwinner,pull = <1>;
 			};
 		};
 
-- 
1.8.3
