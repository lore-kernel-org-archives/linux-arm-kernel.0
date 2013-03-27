From: avinashphilip@ti.com (Philip Avinash)
Date: Wed, 27 Mar 2013 13:13:57 +0530
Subject: [PATCH 1/3] ARM: davinci: da850: Add LCDC DT entries
In-Reply-To: <1364370239-18390-1-git-send-email-avinashphilip@ti.com>
References: <1364370239-18390-1-git-send-email-avinashphilip@ti.com>
Message-ID: <1364370239-18390-2-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add LCDC DT entries in da850 dts file.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
---
 arch/arm/boot/dts/da850.dtsi |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index a6cbf89..087b4ea 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -62,6 +62,21 @@
 					0x10 0x00002200 0x0000ff00
 				>;
 			};
+			lcdc_pins:pinmux_lcdc_pins {
+				pinctrl-single,bits = <
+					/* LCD_D[2], LCD_D[3], LCD_D[4],
+					   LCD_D[5], LCD_D[6], LCD_D[7] */
+					0x40 0x22222200 0xffffff00
+					/* LCD_D[10], LCD_D[11], LCD_D[12],
+					   LCD_D[13], LCD_D[14], LCD_D[15],
+					   LCD_D[0], LCD_D[1] */
+					0x44 0x22222222 0xffffffff
+					/* LCD_PCLK, LCD_D[8], LCD_D[9] */
+					0x48 0x02000022 0x0f0000ff
+					/* LCD_AC_ENB_CS, LCD_VSYNC, LCD_HSYNC*/
+					0x4c 0x02000022 0x0f0000ff
+				>;
+			};
 		};
 		serial0: serial at 1c42000 {
 			compatible = "ns16550a";
@@ -137,6 +152,12 @@
 			reg = <0x308000 0x80>;
 			status = "disabled";
 		};
+		lcdc: lcdc at 01e13000 {
+			compatible = "ti,da830-lcdc";
+			reg = <0x213000 0x1000>;
+			interrupts = <52>;
+			status = "disabled";
+		};
 	};
 	nand_cs3 at 62000000 {
 		compatible = "ti,davinci-nand";
-- 
1.7.9.5
