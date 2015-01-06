From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  6 Jan 2015 16:28:19 +0100
Subject: [PATCH v2 6/7] ARM: mvebu: Add a number of pinctrl functions
In-Reply-To: <1420558100-4700-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1420558100-4700-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1420558100-4700-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some pinctrl functions can be shared with all DTS out there, since they are
generic, SoC-wide muxing options. Add a number of these to the DTSI to avoid
duplication.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 40200084c6c8..98885c58be29 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -195,6 +195,45 @@
 
 			pinctrl at 18000 {
 				reg = <0x18000 0x20>;
+
+				ge0_rgmii_pins: ge-rgmii-pins-0 {
+					marvell,pins = "mpp6", "mpp7", "mpp8",
+						       "mpp9", "mpp10", "mpp11",
+						       "mpp12", "mpp13", "mpp14",
+						       "mpp15", "mpp16", "mpp17";
+					marvell,function = "ge0";
+				};
+
+				i2c0_pins: i2c-pins-0 {
+					marvell,pins = "mpp2", "mpp3";
+					marvell,function = "i2c0";
+				};
+
+				mdio_pins: mdio-pins {
+					marvell,pins = "mpp4", "mpp5";
+					marvell,function = "ge";
+				};
+
+				ref_clk0_pins: ref-clk-pins-0 {
+					marvell,pins = "mpp45";
+					marvell,function = "ref";
+				};
+
+				spi1_pins: spi-pins-1 {
+					marvell,pins = "mpp56", "mpp57", "mpp58",
+						       "mpp59";
+					marvell,function = "spi1";
+				};
+
+				uart0_pins: uart-pins-0 {
+					marvell,pins = "mpp0", "mpp1";
+					marvell,function = "ua0";
+				};
+
+				uart1_pins: uart-pins-1 {
+					marvell,pins = "mpp19", "mpp20";
+					marvell,function = "ua1";
+				};
 			};
 
 			gpio0: gpio at 18100 {
-- 
2.2.1
