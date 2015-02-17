From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 17 Feb 2015 19:52:07 +0100
Subject: [PATCH 6/8] ARM: dts: dove: Add some more common pinctrl settings
In-Reply-To: <1424199129-22099-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1424199129-22099-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1424199129-22099-7-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This add common pinctrl settings for pcie[01]_clkreq, spi1, i2c[23],
and internal i2c mux. These settings have either one or two options
only, so put them into the SoC dtsi instead of repeating them on
board level.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Gabriel Dobato <dobatog@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/dove.dtsi | 52 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 81209bd9525a..9ad829523a13 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -451,6 +451,11 @@
 					marvell,function = "gpio";
 				};
 
+				pmx_pcie1_clkreq: pmx-pcie1-clkreq {
+					marvell,pins = "mpp9";
+					marvell,function = "pex1";
+				};
+
 				pmx_gpio_10: pmx-gpio-10 {
 					marvell,pins = "mpp10";
 					marvell,function = "gpio";
@@ -461,6 +466,11 @@
 					marvell,function = "gpio";
 				};
 
+				pmx_pcie0_clkreq: pmx-pcie0-clkreq {
+					marvell,pins = "mpp11";
+					marvell,function = "pex0";
+				};
+
 				pmx_gpio_12: pmx-gpio-12 {
 					marvell,pins = "mpp12";
 					marvell,function = "gpio";
@@ -566,6 +576,18 @@
 					marvell,function = "gpio";
 				};
 
+				pmx_spi1_4_7: pmx-spi1-4-7 {
+					marvell,pins = "mpp4", "mpp5",
+						"mpp6", "mpp7";
+					marvell,function = "spi1";
+				};
+
+				pmx_spi1_20_23: pmx-spi1-20-23 {
+					marvell,pins = "mpp20", "mpp21",
+						"mpp22", "mpp23";
+					marvell,function = "spi1";
+				};
+
 				pmx_uart1: pmx-uart1 {
 					marvell,pins = "mpp_uart1";
 					marvell,function = "uart1";
@@ -585,6 +607,36 @@
 					marvell,pins = "mpp_nand";
 					marvell,function = "gpo";
 				};
+
+				pmx_i2c1: pmx-i2c1 {
+					marvell,pins = "mpp17", "mpp19";
+					marvell,function = "twsi";
+				};
+
+				pmx_i2c2: pmx-i2c2 {
+					marvell,pins = "mpp_audio1";
+					marvell,function = "twsi";
+				};
+
+				pmx_ssp_i2c2: pmx-ssp-i2c2 {
+					marvell,pins = "mpp_audio1";
+					marvell,function = "ssp/twsi";
+				};
+
+				pmx_i2cmux_0: pmx-i2cmux-0 {
+					marvell,pins = "twsi";
+					marvell,function = "twsi-opt1";
+				};
+
+				pmx_i2cmux_1: pmx-i2cmux-1 {
+					marvell,pins = "twsi";
+					marvell,function = "twsi-opt2";
+				};
+
+				pmx_i2cmux_2: pmx-i2cmux-2 {
+					marvell,pins = "twsi";
+					marvell,function = "twsi-opt3";
+				};
 			};
 
 			core_clk: core-clocks at d0214 {
-- 
2.1.0
