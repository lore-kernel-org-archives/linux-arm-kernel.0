From: hdegoede@redhat.com (Hans de Goede)
Date: Sun,  5 Jun 2016 14:22:47 +0200
Subject: [PATCH 1/2] ARM: dts: sun4i: HDMI and the tv-encoder use tcon ch1 not
 ch0
Message-ID: <1465129368-22335-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the simplefb nodes for hdmi / tv-encoder out to point to
tcon0_ch1 instead of tcon0_ch0 as tcon clock.

While at it fix the clocks lines being longer then 80 chars.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index a9c3190..616b0f9 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -65,8 +65,9 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-hdmi";
-			clocks = <&ahb_gates 36>, <&ahb_gates 43>, <&ahb_gates 44>,
-				 <&de_be0_clk>, <&tcon0_ch0_clk>, <&dram_gates 26>;
+			clocks = <&ahb_gates 36>, <&ahb_gates 43>,
+				 <&ahb_gates 44>, <&de_be0_clk>,
+				 <&tcon0_ch1_clk>, <&dram_gates 26>;
 			status = "disabled";
 		};
 
@@ -76,7 +77,7 @@
 			allwinner,pipeline = "de_fe0-de_be0-lcd0-hdmi";
 			clocks = <&ahb_gates 36>, <&ahb_gates 43>,
 				 <&ahb_gates 44>, <&ahb_gates 46>,
-				 <&de_be0_clk>, <&de_fe0_clk>, <&tcon0_ch0_clk>,
+				 <&de_be0_clk>, <&de_fe0_clk>, <&tcon0_ch1_clk>,
 				 <&dram_gates 25>, <&dram_gates 26>;
 			status = "disabled";
 		};
@@ -97,8 +98,9 @@
 			allwinner,pipeline = "de_fe0-de_be0-lcd0-tve0";
 			clocks = <&ahb_gates 34>, <&ahb_gates 36>,
 				 <&ahb_gates 44>, <&ahb_gates 46>,
-				 <&de_be0_clk>, <&de_fe0_clk>, <&tcon0_ch0_clk>,
-				 <&dram_gates 5>, <&dram_gates 25>, <&dram_gates 26>;
+				 <&de_be0_clk>, <&de_fe0_clk>,
+				 <&tcon0_ch1_clk>, <&dram_gates 5>,
+				 <&dram_gates 25>, <&dram_gates 26>;
 			status = "disabled";
 		};
 	};
-- 
2.7.4
