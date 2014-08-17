From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 17 Aug 2014 11:52:13 +0800
Subject: [PATCH 07/12] ARM: dts: sun8i: Add pin-muxing info for the mmc
 controllers
In-Reply-To: <1408247538-16950-1-git-send-email-wens@csie.org>
References: <1408247538-16950-1-git-send-email-wens@csie.org>
Message-ID: <1408247538-16950-8-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds pin-muxing info for the mmc controller / port combinations
which are known to be used on actual boards.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 2d4c1b4..348fb07 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -230,6 +230,20 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
+			mmc0_pins_a: mmc0 at 0 {
+				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
+				allwinner,function = "mmc0";
+				allwinner,drive = <2>;
+				allwinner,pull = <0>;
+			};
+
+			mmc1_pins_a: mmc1 at 0 {
+				allwinner,pins = "PG0","PG1","PG2","PG3","PG4","PG5";
+				allwinner,function = "mmc1";
+				allwinner,drive = <2>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		ahb1_rst: reset at 01c202c0 {
-- 
2.1.0
