From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Jul 2015 19:46:19 +0200
Subject: [PATCH v2 4/7] ARM: sun7i: Add clock indices
In-Reply-To: <1438364782-3968-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1438364782-3968-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1438364782-3968-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A20 gates have a non continuous set of clock IDs that are valid. Add
the clock-indices property to the DT to express this.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 6a63f30c9a69..ca0b01a96c52 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -267,6 +267,19 @@
 			compatible = "allwinner,sun7i-a20-ahb-gates-clk";
 			reg = <0x01c20060 0x8>;
 			clocks = <&ahb>;
+			clock-indices = <0>, <1>,
+					<2>, <3>, <4>,
+					<5>, <6>, <7>, <8>,
+					<9>, <10>, <11>, <12>,
+					<13>, <14>, <16>,
+					<17>, <18>, <20>, <21>,
+					<22>, <23>, <25>,
+					<28>, <32>, <33>, <34>,
+					<35>, <36>, <37>, <40>,
+					<41>, <42>, <43>,
+					<44>, <45>, <46>,
+					<47>, <49>, <50>,
+					<52>;
 			clock-output-names = "ahb_usb0", "ahb_ehci0",
 				"ahb_ohci0", "ahb_ehci1", "ahb_ohci1",
 				"ahb_ss", "ahb_dma", "ahb_bist", "ahb_mmc0",
@@ -295,6 +308,10 @@
 			compatible = "allwinner,sun7i-a20-apb0-gates-clk";
 			reg = <0x01c20068 0x4>;
 			clocks = <&apb0>;
+			clock-indices = <0>, <1>,
+					<2>, <3>, <4>,
+					<5>, <6>, <7>,
+					<8>, <10>;
 			clock-output-names = "apb0_codec", "apb0_spdif",
 				"apb0_ac97", "apb0_iis0", "apb0_iis1",
 				"apb0_pio", "apb0_ir0", "apb0_ir1",
@@ -314,6 +331,12 @@
 			compatible = "allwinner,sun7i-a20-apb1-gates-clk";
 			reg = <0x01c2006c 0x4>;
 			clocks = <&apb1>;
+			clock-indices = <0>, <1>,
+					<2>, <3>, <4>,
+					<5>, <6>, <7>,
+					<15>, <16>, <17>,
+					<18>, <19>, <20>,
+					<21>, <22>, <23>;
 			clock-output-names = "apb1_i2c0", "apb1_i2c1",
 				"apb1_i2c2", "apb1_i2c3", "apb1_can",
 				"apb1_scr", "apb1_ps20", "apb1_ps21",
-- 
2.4.6
