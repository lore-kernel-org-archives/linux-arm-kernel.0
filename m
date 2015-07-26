From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 26 Jul 2015 23:14:25 +0200
Subject: [PATCH 2/7] ARM: sun5i: Add clock indices
In-Reply-To: <1437945270-32014-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1437945270-32014-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1437945270-32014-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A10s and A13 gates have a non continuous set of clock IDs that are
valid. Add the clock-indices property to the DT to express this.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 23 +++++++++++++++++++++--
 arch/arm/boot/dts/sun5i-a13.dtsi  | 18 +++++++++++++++++-
 arch/arm/boot/dts/sun5i.dtsi      |  1 +
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index f11efb722bbb..a513b416a807 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -85,6 +85,17 @@
 			compatible = "allwinner,sun5i-a10s-ahb-gates-clk";
 			reg = <0x01c20060 0x8>;
 			clocks = <&ahb>;
+			clock-indices = <0>, <1>,
+					<2>, <5>, <6>,
+					<7>, <8>, <9>,
+					<10>, <13>,
+					<14>, <17>, <18>,
+					<20>, <21>, <22>,
+					<26>, <28>, <32>,
+					<34>, <36>, <40>,
+					<43>, <44>,
+					<46>, <51>,
+					<52>;
 			clock-output-names = "ahb_usbotg", "ahb_ehci",
 					     "ahb_ohci", "ahb_ss", "ahb_dma",
 					     "ahb_bist", "ahb_mmc0", "ahb_mmc1",
@@ -103,6 +114,9 @@
 			compatible = "allwinner,sun5i-a10s-apb0-gates-clk";
 			reg = <0x01c20068 0x4>;
 			clocks = <&apb0>;
+			clock-indices = <0>, <3>,
+					<5>, <6>,
+					<10>;
 			clock-output-names = "apb0_codec", "apb0_iis",
 					     "apb0_pio", "apb0_ir",
 					     "apb0_keypad";
@@ -113,9 +127,14 @@
 			compatible = "allwinner,sun5i-a10s-apb1-gates-clk";
 			reg = <0x01c2006c 0x4>;
 			clocks = <&apb1>;
+			clock-indices = <0>, <1>,
+					<2>, <16>,
+					<17>, <18>,
+					<19>;
 			clock-output-names = "apb1_i2c0", "apb1_i2c1",
-				"apb1_i2c2", "apb1_uart0", "apb1_uart1",
-				"apb1_uart2", "apb1_uart3";
+					     "apb1_i2c2", "apb1_uart0",
+					     "apb1_uart1", "apb1_uart2",
+					     "apb1_uart3";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 976d4faa2179..f3631c9c6fa2 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -104,6 +104,16 @@
 			compatible = "allwinner,sun5i-a13-ahb-gates-clk";
 			reg = <0x01c20060 0x8>;
 			clocks = <&ahb>;
+			clock-indices = <0>, <1>,
+					<2>, <5>, <6>,
+					<7>, <8>, <9>,
+					<10>, <13>,
+					<14>, <20>,
+					<21>, <22>,
+				        <28>, <32>, <36>,
+				        <40>, <44>,
+					<46>, <51>,
+					<52>;
 			clock-output-names = "ahb_usbotg", "ahb_ehci",
 					     "ahb_ohci", "ahb_ss", "ahb_dma",
 					     "ahb_bist", "ahb_mmc0", "ahb_mmc1",
@@ -121,6 +131,8 @@
 			compatible = "allwinner,sun5i-a13-apb0-gates-clk";
 			reg = <0x01c20068 0x4>;
 			clocks = <&apb0>;
+			clock-indices = <0>, <5>,
+					<6>;
 			clock-output-names = "apb0_codec", "apb0_pio",
 					     "apb0_ir";
 		};
@@ -130,8 +142,12 @@
 			compatible = "allwinner,sun5i-a13-apb1-gates-clk";
 			reg = <0x01c2006c 0x4>;
 			clocks = <&apb1>;
+			clock-indices = <0>, <1>,
+					<2>, <17>,
+					<19>;
 			clock-output-names = "apb1_i2c0", "apb1_i2c1",
-				"apb1_i2c2", "apb1_uart1", "apb1_uart3";
+					     "apb1_i2c2", "apb1_uart1",
+					     "apb1_uart3";
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 54b097830434..427c0e7289fa 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -178,6 +178,7 @@
 			compatible = "allwinner,sun4i-a10-axi-gates-clk";
 			reg = <0x01c2005c 0x4>;
 			clocks = <&axi>;
+			clock-indices = <0>;
 			clock-output-names = "axi_dram";
 		};
 
-- 
2.4.6
