From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  3 May 2015 12:13:39 +0200
Subject: [PATCH 2/3] ARM: sunxi: DT: Fix lines over 80 characters
In-Reply-To: <1430648020-8328-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1430648020-8328-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1430648020-8328-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few lines in our DTSIs are over the 80 characters limit, making
checkpatch complain about that.

If possible (and relevant), wrap these lines to 80 characters.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 12 ++++++++----
 arch/arm/boot/dts/sun5i-a10s.dtsi | 29 ++++++++++++++++-----------
 arch/arm/boot/dts/sun5i-a13.dtsi  | 19 +++++++++++-------
 arch/arm/boot/dts/sun5i.dtsi      |  3 ++-
 arch/arm/boot/dts/sun6i-a31.dtsi  | 30 +++++++++++++++++-----------
 arch/arm/boot/dts/sun7i-a20.dtsi  | 41 ++++++++++++++++++++++++++-------------
 arch/arm/boot/dts/sun8i-a23.dtsi  |  6 ++++--
 arch/arm/boot/dts/sun9i-a80.dtsi  |  2 +-
 8 files changed, 91 insertions(+), 51 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index a230b3c84867..c4fdb3b51e58 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -61,7 +61,8 @@
 		ranges;
 
 		framebuffer at 0 {
-			compatible = "allwinner,simple-framebuffer", "simple-framebuffer";
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-hdmi";
 			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
 				 <&ahb_gates 44>;
@@ -69,7 +70,8 @@
 		};
 
 		framebuffer at 1 {
-			compatible = "allwinner,simple-framebuffer", "simple-framebuffer";
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
 			allwinner,pipeline = "de_fe0-de_be0-lcd0-hdmi";
 			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
 				 <&ahb_gates 44>, <&ahb_gates 46>;
@@ -433,7 +435,8 @@
 			compatible = "allwinner,sun4i-a10-usb-clk";
 			reg = <0x01c200cc 0x4>;
 			clocks = <&pll6 1>;
-			clock-output-names = "usb_ohci0", "usb_ohci1", "usb_phy";
+			clock-output-names = "usb_ohci0", "usb_ohci1",
+					     "usb_phy";
 		};
 
 		spi3_clk: clk at 01c200d4 {
@@ -779,7 +782,8 @@
 			};
 
 			mmc0_pins_a: mmc0 at 0 {
-				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
+				allwinner,pins = "PF0", "PF1", "PF2",
+						 "PF3", "PF4", "PF5";
 				allwinner,function = "mmc0";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 2e6819f1e989..934ecfd145c4 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -62,7 +62,8 @@
 		ranges;
 
 		framebuffer at 0 {
-			compatible = "allwinner,simple-framebuffer", "simple-framebuffer";
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-hdmi";
 			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
 				 <&ahb_gates 44>;
@@ -84,13 +85,17 @@
 			compatible = "allwinner,sun5i-a10s-ahb-gates-clk";
 			reg = <0x01c20060 0x8>;
 			clocks = <&ahb>;
-			clock-output-names = "ahb_usbotg", "ahb_ehci", "ahb_ohci",
-				"ahb_ss", "ahb_dma", "ahb_bist", "ahb_mmc0",
-				"ahb_mmc1", "ahb_mmc2", "ahb_nand", "ahb_sdram",
-				"ahb_emac", "ahb_ts", "ahb_spi0", "ahb_spi1",
-				"ahb_spi2", "ahb_gps", "ahb_stimer", "ahb_ve",
-				"ahb_tve", "ahb_lcd", "ahb_csi", "ahb_hdmi",
-				"ahb_de_be", "ahb_de_fe", "ahb_iep", "ahb_mali400";
+			clock-output-names = "ahb_usbotg", "ahb_ehci",
+					     "ahb_ohci", "ahb_ss", "ahb_dma",
+					     "ahb_bist", "ahb_mmc0", "ahb_mmc1",
+					     "ahb_mmc2", "ahb_nand",
+					     "ahb_sdram", "ahb_emac", "ahb_ts",
+					     "ahb_spi0", "ahb_spi1", "ahb_spi2",
+					     "ahb_gps", "ahb_stimer", "ahb_ve",
+					     "ahb_tve", "ahb_lcd", "ahb_csi",
+					     "ahb_hdmi", "ahb_de_be",
+					     "ahb_de_fe", "ahb_iep",
+					     "ahb_mali400";
 		};
 
 		apb0_gates: clk at 01c20068 {
@@ -98,8 +103,9 @@
 			compatible = "allwinner,sun5i-a10s-apb0-gates-clk";
 			reg = <0x01c20068 0x4>;
 			clocks = <&apb0>;
-			clock-output-names = "apb0_codec", "apb0_iis", "apb0_pio",
-				"apb0_ir", "apb0_keypad";
+			clock-output-names = "apb0_codec", "apb0_iis",
+					     "apb0_pio", "apb0_ir",
+					     "apb0_keypad";
 		};
 
 		apb1_gates: clk at 01c2006c {
@@ -188,7 +194,8 @@
 	};
 
 	mmc1_pins_a: mmc1 at 0 {
-		allwinner,pins = "PG3","PG4","PG5","PG6","PG7","PG8";
+		allwinner,pins = "PG3", "PG4", "PG5",
+				 "PG6", "PG7", "PG8";
 		allwinner,function = "mmc1";
 		allwinner,drive = <SUN4I_PINCTRL_30_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index d2820f50b7eb..1eeadea3ce2f 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -104,12 +104,16 @@
 			compatible = "allwinner,sun5i-a13-ahb-gates-clk";
 			reg = <0x01c20060 0x8>;
 			clocks = <&ahb>;
-			clock-output-names = "ahb_usbotg", "ahb_ehci", "ahb_ohci",
-				"ahb_ss", "ahb_dma", "ahb_bist", "ahb_mmc0",
-				"ahb_mmc1", "ahb_mmc2", "ahb_nand", "ahb_sdram",
-				"ahb_spi0", "ahb_spi1", "ahb_spi2", "ahb_stimer",
-				"ahb_ve", "ahb_lcd", "ahb_csi", "ahb_de_be",
-				"ahb_de_fe", "ahb_iep", "ahb_mali400";
+			clock-output-names = "ahb_usbotg", "ahb_ehci",
+					     "ahb_ohci", "ahb_ss", "ahb_dma",
+					     "ahb_bist", "ahb_mmc0", "ahb_mmc1",
+					     "ahb_mmc2", "ahb_nand",
+					     "ahb_sdram", "ahb_spi0",
+					     "ahb_spi1", "ahb_spi2",
+					     "ahb_stimer", "ahb_ve", "ahb_lcd",
+					     "ahb_csi", "ahb_de_be",
+					     "ahb_de_fe", "ahb_iep",
+					     "ahb_mali400";
 		};
 
 		apb0_gates: clk at 01c20068 {
@@ -117,7 +121,8 @@
 			compatible = "allwinner,sun5i-a13-apb0-gates-clk";
 			reg = <0x01c20068 0x4>;
 			clocks = <&apb0>;
-			clock-output-names = "apb0_codec", "apb0_pio", "apb0_ir";
+			clock-output-names = "apb0_codec", "apb0_pio",
+					     "apb0_ir";
 		};
 
 		apb1_gates: clk at 01c2006c {
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index b8a2e249ca3b..fb20ace0a03a 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -505,7 +505,8 @@
 			};
 
 			mmc0_pins_a: mmc0 at 0 {
-				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
+				allwinner,pins = "PF0", "PF1", "PF2", "PF3",
+						 "PF4", "PF5";
 				allwinner,function = "mmc0";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 27d60e9a4bb8..9ec3f7a5b6e0 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -62,7 +62,8 @@
 		ranges;
 
 		framebuffer at 0 {
-			compatible = "allwinner,simple-framebuffer", "simple-framebuffer";
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-hdmi";
 			clocks = <&pll6 0>;
 			status = "disabled";
@@ -299,9 +300,10 @@
 			reg = <0x01c2006c 0x4>;
 			clocks = <&apb2>;
 			clock-output-names = "apb2_i2c0", "apb2_i2c1",
-					"apb2_i2c2", "apb2_i2c3", "apb2_uart0",
-					"apb2_uart1", "apb2_uart2", "apb2_uart3",
-					"apb2_uart4", "apb2_uart5";
+					     "apb2_i2c2", "apb2_i2c3",
+					     "apb2_uart0", "apb2_uart1",
+					     "apb2_uart2", "apb2_uart3",
+					     "apb2_uart4", "apb2_uart5";
 		};
 
 		mmc0_clk: clk at 01c20088 {
@@ -388,10 +390,13 @@
 		};
 
 		/*
-		 * The following two are dummy clocks, placeholders used in the gmac_tx
-		 * clock. The gmac driver will choose one parent depending on the PHY
-		 * interface mode, using clk_set_rate auto-reparenting.
-		 * The actual TX clock rate is not controlled by the gmac_tx clock.
+		 * The following two are dummy clocks, placeholders
+		 * used in the gmac_tx clock. The gmac driver will
+		 * choose one parent depending on the PHY interface
+		 * mode, using clk_set_rate auto-reparenting.
+		 *
+		 * The actual TX clock rate is not controlled by the
+		 * gmac_tx clock.
 		 */
 		mii_phy_tx_clk: clk at 1 {
 			#clock-cells = <0>;
@@ -627,7 +632,8 @@
 			};
 
 			mmc0_pins_a: mmc0 at 0 {
-				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
+				allwinner,pins = "PF0", "PF1", "PF2",
+						 "PF3", "PF4", "PF5";
 				allwinner,function = "mmc0";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
@@ -865,7 +871,8 @@
 		};
 
 		timer at 01c60000 {
-			compatible = "allwinner,sun6i-a31-hstimer", "allwinner,sun7i-a20-hstimer";
+			compatible = "allwinner,sun6i-a31-hstimer",
+				     "allwinner,sun7i-a20-hstimer";
 			reg = <0x01c60000 0x1000>;
 			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
@@ -956,7 +963,8 @@
 			ar100: ar100_clk {
 				compatible = "allwinner,sun6i-a31-ar100-clk";
 				#clock-cells = <0>;
-				clocks = <&osc32k>, <&osc24M>, <&pll6 0>, <&pll6 0>;
+				clocks = <&osc32k>, <&osc24M>, <&pll6 0>,
+					 <&pll6 0>;
 				clock-output-names = "ar100";
 			};
 
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 48ea71ab85a4..19a95a8dd355 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -63,7 +63,8 @@
 		ranges;
 
 		framebuffer at 0 {
-			compatible = "allwinner,simple-framebuffer", "simple-framebuffer";
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-hdmi";
 			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
 				 <&ahb_gates 44>;
@@ -447,7 +448,8 @@
 			compatible = "allwinner,sun4i-a10-usb-clk";
 			reg = <0x01c200cc 0x4>;
 			clocks = <&pll6 1>;
-			clock-output-names = "usb_ohci0", "usb_ohci1", "usb_phy";
+			clock-output-names = "usb_ohci0", "usb_ohci1",
+					     "usb_phy";
 		};
 
 		spi3_clk: clk at 01c200d4 {
@@ -467,10 +469,13 @@
 		};
 
 		/*
-		 * The following two are dummy clocks, placeholders used in the gmac_tx
-		 * clock. The gmac driver will choose one parent depending on the PHY
-		 * interface mode, using clk_set_rate auto-reparenting.
-		 * The actual TX clock rate is not controlled by the gmac_tx clock.
+		 * The following two are dummy clocks, placeholders
+		 * used in the gmac_tx clock. The gmac driver will
+		 * choose one parent depending on the PHY interface
+		 * mode, using clk_set_rate auto-reparenting.
+		 *
+		 * The actual TX clock rate is not controlled by the
+		 * gmac_tx clock.
 		 */
 		mii_phy_tx_clk: clk at 2 {
 			#clock-cells = <0>;
@@ -968,7 +973,8 @@
 			};
 
 			mmc0_pins_a: mmc0 at 0 {
-				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
+				allwinner,pins = "PF0", "PF1", "PF2",
+						 "PF3", "PF4", "PF5";
 				allwinner,function = "mmc0";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
@@ -982,14 +988,16 @@
 			};
 
 			mmc2_pins_a: mmc2 at 0 {
-				allwinner,pins = "PC6","PC7","PC8","PC9","PC10","PC11";
+				allwinner,pins = "PC6", "PC7", "PC8",
+						 "PC9", "PC10", "PC11";
 				allwinner,function = "mmc2";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 			};
 
 			mmc3_pins_a: mmc3 at 0 {
-				allwinner,pins = "PI4","PI5","PI6","PI7","PI8","PI9";
+				allwinner,pins = "PI4", "PI5", "PI6",
+						 "PI7", "PI8", "PI9";
 				allwinner,function = "mmc3";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
@@ -1173,7 +1181,8 @@
 		};
 
 		i2c0: i2c at 01c2ac00 {
-			compatible = "allwinner,sun7i-a20-i2c", "allwinner,sun4i-a10-i2c";
+			compatible = "allwinner,sun7i-a20-i2c",
+				     "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb1_gates 0>;
@@ -1183,7 +1192,8 @@
 		};
 
 		i2c1: i2c at 01c2b000 {
-			compatible = "allwinner,sun7i-a20-i2c", "allwinner,sun4i-a10-i2c";
+			compatible = "allwinner,sun7i-a20-i2c",
+				     "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb1_gates 1>;
@@ -1193,7 +1203,8 @@
 		};
 
 		i2c2: i2c at 01c2b400 {
-			compatible = "allwinner,sun7i-a20-i2c", "allwinner,sun4i-a10-i2c";
+			compatible = "allwinner,sun7i-a20-i2c",
+				     "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb1_gates 2>;
@@ -1203,7 +1214,8 @@
 		};
 
 		i2c3: i2c at 01c2b800 {
-			compatible = "allwinner,sun7i-a20-i2c", "allwinner,sun4i-a10-i2c";
+			compatible = "allwinner,sun7i-a20-i2c",
+				     "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b800 0x400>;
 			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb1_gates 3>;
@@ -1213,7 +1225,8 @@
 		};
 
 		i2c4: i2c at 01c2c000 {
-			compatible = "allwinner,sun7i-a20-i2c", "allwinner,sun4i-a10-i2c";
+			compatible = "allwinner,sun7i-a20-i2c",
+				     "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2c000 0x400>;
 			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb1_gates 15>;
diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 1cc75c119e89..7297f9629ef4 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -355,14 +355,16 @@
 			};
 
 			mmc0_pins_a: mmc0 at 0 {
-				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
+				allwinner,pins = "PF0", "PF1", "PF2",
+						 "PF3", "PF4", "PF5";
 				allwinner,function = "mmc0";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			mmc1_pins_a: mmc1 at 0 {
-				allwinner,pins = "PG0","PG1","PG2","PG3","PG4","PG5";
+				allwinner,pins = "PG0", "PG1", "PG2",
+						 "PG3", "PG4", "PG5";
 				allwinner,function = "mmc1";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index d5598ea9393f..ca272e92b85d 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -284,7 +284,7 @@
 					"ahb0_ss", "ahb0_sd", "ahb0_nand1",
 					"ahb0_nand0", "ahb0_sdram",
 					"ahb0_mipi_hsi", "ahb0_sata", "ahb0_ts",
-					"ahb0_spi0","ahb0_spi1", "ahb0_spi2",
+					"ahb0_spi0", "ahb0_spi1", "ahb0_spi2",
 					"ahb0_spi3";
 		};
 
-- 
2.3.6
