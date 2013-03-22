From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Fri, 22 Mar 2013 11:20:38 -0300
Subject: [PATCH 2/6] arm: sunxi: Add clock definitions for AXI, AHB, APB0,
 APB1 gates
In-Reply-To: <1363962042-29536-1-git-send-email-emilio@elopez.com.ar>
References: <1363962042-29536-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1363962042-29536-3-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the corresponding DT bindings for all the AXI,
AHB, APB0 and APB1 gates.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sunxi.dtsi | 49 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi.dtsi b/arch/arm/boot/dts/sunxi.dtsi
index cafd393..22f0d9d 100644
--- a/arch/arm/boot/dts/sunxi.dtsi
+++ b/arch/arm/boot/dts/sunxi.dtsi
@@ -80,6 +80,14 @@
 			clocks = <&cpu>;
 		};
 
+		axi_gates: axi_gates at 01c2005c {
+			#clock-cells = <1>;
+			compatible = "allwinner,sunxi-axi-gates-clk";
+			reg = <0x01c2005c 0x4>;
+			clocks = <&axi>;
+			clock-output-names = "axi_dram";
+		};
+
 		ahb: ahb at 01c20054 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sunxi-ahb-clk";
@@ -87,6 +95,24 @@
 			clocks = <&axi>;
 		};
 
+		ahb_gates: ahb_gates at 01c20060 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sunxi-ahb-gates-clk";
+			reg = <0x01c20060 0x8>;
+			clocks = <&ahb>;
+			clock-output-names = "ahb_usb0", "ahb_ehci0",
+				"ahb_ohci0", "ahb_ehci1", "ahb_ohci1", "ahb_ss",
+				"ahb_dma", "ahb_bist", "ahb_mmc0", "ahb_mmc1",
+				"ahb_mmc2", "ahb_mmc3", "ahb_ms", "ahb_nand",
+				"ahb_sdram", "ahb_ace",	"ahb_emac", "ahb_ts",
+				"ahb_spi0", "ahb_spi1", "ahb_spi2", "ahb_spi3",
+				"ahb_pata", "ahb_sata", "ahb_gps", "ahb_ve",
+				"ahb_tvd", "ahb_tve0", "ahb_tve1", "ahb_lcd0",
+				"ahb_lcd1", "ahb_csi0", "ahb_csi1", "ahb_hdmi",
+				"ahb_de_be0", "ahb_de_be1", "ahb_de_fe0",
+				"ahb_de_fe1", "ahb_mp", "ahb_mali400";
+		};
+
 		apb0: apb0 at 01c20054 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sunxi-apb0-clk";
@@ -94,6 +120,16 @@
 			clocks = <&ahb>;
 		};
 
+		apb0_gates: apb0_gates at 01c20068 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sunxi-apb0-gates-clk";
+			reg = <0x01c20068 0x4>;
+			clocks = <&apb0>;
+			clock-output-names = "apb0_codec", "apb0_spdif",
+				"apb0_ac97", "apb0_iis", "apb0_pio", "apb0_ir0",
+				"apb0_ir1", "apb0_keypad";
+		};
+
 		/* dummy is pll62 */
 		apb1_mux: apb1_mux at 01c20058 {
 			#clock-cells = <0>;
@@ -108,6 +144,19 @@
 			reg = <0x01c20058 0x4>;
 			clocks = <&apb1_mux>;
 		};
+
+		apb1_gates: apb1_gates at 01c2006c {
+			#clock-cells = <1>;
+			compatible = "allwinner,sunxi-apb1-gates-clk";
+			reg = <0x01c2006c 0x4>;
+			clocks = <&apb1>;
+			clock-output-names = "apb1_twi0", "apb1_twi1",
+				"apb1_twi2", "apb1_can", "apb1_scr",
+				"apb1_ps20", "apb1_ps21", "apb1_uart0",
+				"apb1_uart1", "apb1_uart2", "apb1_uart3",
+				"apb1_uart4", "apb1_uart5", "apb1_uart6",
+				"apb1_uart7";
+		};
 	};
 
 	soc {
-- 
1.8.2
