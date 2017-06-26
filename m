From: net147@gmail.com (Jonathan Liu)
Date: Mon, 26 Jun 2017 22:55:06 +1000
Subject: [PATCH v2] ARM: dts: sun7i: Add A20 LCD0 RGB888 pins
Message-ID: <20170626125506.21063-1-net147@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LCD0 controller on the A20 can do RGB output up to 8 bits per
channel. Add the pins for RGB888 output.

Signed-off-by: Jonathan Liu <net147@gmail.com>
---
Changes for v2:
 - Remove "allwinner," prefix from pins and function

 arch/arm/boot/dts/sun7i-a20.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 96bee776e145..ac025d1fb348 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1183,6 +1183,17 @@
 				function = "ir1";
 			};
 
+			lcd0_rgb888_pins: lcd0_rgb888 at 0 {
+				pins = "PD0", "PD1", "PD2", "PD3",
+				       "PD4", "PD5", "PD6", "PD7",
+				       "PD8", "PD9", "PD10", "PD11",
+				       "PD12", "PD13", "PD14", "PD15",
+				       "PD16", "PD17", "PD18", "PD19",
+				       "PD20", "PD21", "PD22", "PD23",
+				       "PD24", "PD25", "PD26", "PD27";
+				function = "lcd0";
+			};
+
 			mmc0_pins_a: mmc0 at 0 {
 				pins = "PF0", "PF1", "PF2",
 				       "PF3", "PF4", "PF5";
-- 
2.13.1
