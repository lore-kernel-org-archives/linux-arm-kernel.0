From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 26 Jul 2015 23:14:24 +0200
Subject: [PATCH 1/7] ARM: sun4i: Add clock indices
In-Reply-To: <1437945270-32014-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1437945270-32014-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1437945270-32014-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A10 gates have a non continuous set of clock IDs that are valid. Add
the clock-indices property to the DT to express this.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 69 ++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 61c03d1fe530..ab0e131587bb 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -241,6 +241,7 @@
 			compatible = "allwinner,sun4i-a10-axi-gates-clk";
 			reg = <0x01c2005c 0x4>;
 			clocks = <&axi>;
+			clock-indices = <0>;
 			clock-output-names = "axi_dram";
 		};
 
@@ -257,17 +258,36 @@
 			compatible = "allwinner,sun4i-a10-ahb-gates-clk";
 			reg = <0x01c20060 0x8>;
 			clocks = <&ahb>;
+			clock-indices = <0>, <1>,
+					<2>, <3>,
+					<4>, <5>, <6>,
+					<7>, <8>, <9>,
+					<10>, <11>, <12>,
+					<13>, <14>, <16>,
+					<17>, <18>, <20>,
+					<21>, <22>, <23>,
+					<24>, <25>, <26>,
+					<32>, <33>, <34>,
+					<35>, <36>, <37>,
+					<40>, <41>, <43>,
+					<44>, <45>,
+					<46>, <47>,
+					<50>, <52>;
 			clock-output-names = "ahb_usb0", "ahb_ehci0",
-				"ahb_ohci0", "ahb_ehci1", "ahb_ohci1", "ahb_ss",
-				"ahb_dma", "ahb_bist", "ahb_mmc0", "ahb_mmc1",
-				"ahb_mmc2", "ahb_mmc3", "ahb_ms", "ahb_nand",
-				"ahb_sdram", "ahb_ace",	"ahb_emac", "ahb_ts",
-				"ahb_spi0", "ahb_spi1", "ahb_spi2", "ahb_spi3",
-				"ahb_pata", "ahb_sata", "ahb_gps", "ahb_ve",
-				"ahb_tvd", "ahb_tve0", "ahb_tve1", "ahb_lcd0",
-				"ahb_lcd1", "ahb_csi0", "ahb_csi1", "ahb_hdmi",
-				"ahb_de_be0", "ahb_de_be1", "ahb_de_fe0",
-				"ahb_de_fe1", "ahb_mp", "ahb_mali400";
+					     "ahb_ohci0", "ahb_ehci1",
+					     "ahb_ohci1", "ahb_ss", "ahb_dma",
+					     "ahb_bist", "ahb_mmc0", "ahb_mmc1",
+					     "ahb_mmc2", "ahb_mmc3", "ahb_ms",
+					     "ahb_nand", "ahb_sdram", "ahb_ace",
+					     "ahb_emac", "ahb_ts", "ahb_spi0",
+					     "ahb_spi1", "ahb_spi2", "ahb_spi3",
+					     "ahb_pata", "ahb_sata", "ahb_gps",
+					     "ahb_ve", "ahb_tvd", "ahb_tve0",
+					     "ahb_tve1", "ahb_lcd0", "ahb_lcd1",
+					     "ahb_csi0", "ahb_csi1", "ahb_hdmi",
+					     "ahb_de_be0", "ahb_de_be1",
+					     "ahb_de_fe0", "ahb_de_fe1",
+					     "ahb_mp", "ahb_mali400";
 		};
 
 		apb0: apb0 at 01c20054 {
@@ -283,9 +303,14 @@
 			compatible = "allwinner,sun4i-a10-apb0-gates-clk";
 			reg = <0x01c20068 0x4>;
 			clocks = <&apb0>;
+			clock-indices = <0>, <1>,
+					<2>, <3>,
+					<5>, <6>,
+					<7>, <10>;
 			clock-output-names = "apb0_codec", "apb0_spdif",
-				"apb0_ac97", "apb0_iis", "apb0_pio", "apb0_ir0",
-				"apb0_ir1", "apb0_keypad";
+					     "apb0_ac97", "apb0_iis",
+					     "apb0_pio", "apb0_ir0",
+					     "apb0_ir1", "apb0_keypad";
 		};
 
 		apb1: clk at 01c20058 {
@@ -301,12 +326,22 @@
 			compatible = "allwinner,sun4i-a10-apb1-gates-clk";
 			reg = <0x01c2006c 0x4>;
 			clocks = <&apb1>;
+			clock-indices = <0>, <1>,
+					<2>, <4>,
+					<5>, <6>,
+					<7>, <16>,
+					<17>, <18>,
+					<19>, <20>,
+					<21>, <22>,
+					<23>;
 			clock-output-names = "apb1_i2c0", "apb1_i2c1",
-				"apb1_i2c2", "apb1_can", "apb1_scr",
-				"apb1_ps20", "apb1_ps21", "apb1_uart0",
-				"apb1_uart1", "apb1_uart2", "apb1_uart3",
-				"apb1_uart4", "apb1_uart5", "apb1_uart6",
-				"apb1_uart7";
+					     "apb1_i2c2", "apb1_can",
+					     "apb1_scr", "apb1_ps20",
+					     "apb1_ps21", "apb1_uart0",
+					     "apb1_uart1", "apb1_uart2",
+					     "apb1_uart3", "apb1_uart4",
+					     "apb1_uart5", "apb1_uart6",
+					     "apb1_uart7";
 		};
 
 		nand_clk: clk at 01c20080 {
-- 
2.4.6
