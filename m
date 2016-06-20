From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 20 Jun 2016 22:57:22 +0200
Subject: [PATCH 4.7 fix] ARM: dts: sunxi: Add pll3 to simplefb nodes clocks
 lists
Message-ID: <1466456242-22841-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we've a clock node describing pll3 we must add it to the
simplefb nodes clocks lists to avoid it getting turned off when
simplefb is used.

This fixes the screen going black when using simplefb.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 21 ++++++++++++---------
 arch/arm/boot/dts/sun5i-a10s.dtsi | 11 ++++++-----
 arch/arm/boot/dts/sun7i-a20.dtsi  | 11 ++++++-----
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index a03e56f..ca58eb2 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -65,8 +65,9 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-hdmi";
-			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
-				 <&ahb_gates 44>, <&dram_gates 26>;
+			clocks = <&pll3>, <&pll5 1>, <&ahb_gates 36>,
+				 <&ahb_gates 43>, <&ahb_gates 44>,
+				 <&dram_gates 26>;
 			status = "disabled";
 		};
 
@@ -74,8 +75,9 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_fe0-de_be0-lcd0-hdmi";
-			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
-				 <&ahb_gates 44>, <&ahb_gates 46>,
+			clocks = <&pll3>, <&pll5 1>, <&ahb_gates 36>,
+				 <&ahb_gates 43>, <&ahb_gates 44>,
+				 <&ahb_gates 46>,
 				 <&dram_gates 25>, <&dram_gates 26>;
 			status = "disabled";
 		};
@@ -84,9 +86,9 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_fe0-de_be0-lcd0";
-			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 44>,
-				 <&ahb_gates 46>, <&dram_gates 25>,
-				 <&dram_gates 26>;
+			clocks = <&pll3>, <&pll5 1>, <&ahb_gates 36>,
+				 <&ahb_gates 44>, <&ahb_gates 46>,
+				 <&dram_gates 25>, <&dram_gates 26>;
 			status = "disabled";
 		};
 
@@ -94,8 +96,9 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_fe0-de_be0-lcd0-tve0";
-			clocks = <&pll5 1>, <&ahb_gates 34>, <&ahb_gates 36>,
-				 <&ahb_gates 44>, <&ahb_gates 46>,
+			clocks = <&pll3>, <&pll5 1>, <&ahb_gates 34>,
+				 <&ahb_gates 36>, <&ahb_gates 44>,
+				 <&ahb_gates 46>,
 				 <&dram_gates 5>, <&dram_gates 25>, <&dram_gates 26>;
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index bddd0de..367f330 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -65,8 +65,8 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-hdmi";
-			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
-				 <&ahb_gates 44>;
+			clocks = <&pll3>, <&pll5 1>, <&ahb_gates 36>,
+				 <&ahb_gates 43>, <&ahb_gates 44>;
 			status = "disabled";
 		};
 
@@ -74,7 +74,8 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0";
-			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 44>;
+			clocks = <&pll3>, <&pll5 1>, <&ahb_gates 36>,
+				 <&ahb_gates 44>;
 			status = "disabled";
 		};
 
@@ -82,8 +83,8 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-tve0";
-			clocks = <&pll5 1>, <&ahb_gates 34>, <&ahb_gates 36>,
-				 <&ahb_gates 44>;
+			clocks = <&pll3>, <&pll5 1>, <&ahb_gates 34>,
+				 <&ahb_gates 36>, <&ahb_gates 44>;
 			status = "disabled";
 		};
 	};
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index febdf4c..f480051 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -67,8 +67,9 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-hdmi";
-			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
-				 <&ahb_gates 44>, <&dram_gates 26>;
+			clocks = <&pll3>, <&pll5 1>, <&ahb_gates 36>,
+				 <&ahb_gates 43>, <&ahb_gates 44>,
+				 <&dram_gates 26>;
 			status = "disabled";
 		};
 
@@ -76,8 +77,8 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0";
-			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 44>,
-				 <&dram_gates 26>;
+			clocks = <&pll3>, <&pll5 1>, <&ahb_gates 36>,
+				 <&ahb_gates 44>, <&dram_gates 26>;
 			status = "disabled";
 		};
 
@@ -85,7 +86,7 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-tve0";
-			clocks = <&pll5 1>,
+			clocks = <&pll3>, <&pll5 1>,
 				 <&ahb_gates 34>, <&ahb_gates 36>, <&ahb_gates 44>,
 				 <&dram_gates 5>, <&dram_gates 26>;
 			status = "disabled";
-- 
2.7.4
