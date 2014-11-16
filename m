From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 16 Nov 2014 11:22:27 +0100
Subject: [PATCH] ARM: dts: sunxi: Add de_be0 clk parent pll to simplefb node
Message-ID: <1416133347-10459-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid the parent pll for the mod-clk for de_be0 getting disabled when non of
the other users are enabled (which can happens on boards when non of i2c, spi
and mmc are in use).

Note for now we point directly to the parent rather then to the de_be0 mod-clk
as that is not modelled in our devicetree yet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 3 ++-
 arch/arm/boot/dts/sun5i-a10s.dtsi | 3 ++-
 arch/arm/boot/dts/sun6i-a31.dtsi  | 1 +
 arch/arm/boot/dts/sun7i-a20.dtsi  | 3 ++-
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index cdb4708..92d8aa6 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -34,7 +34,8 @@
 
 		framebuffer0-hdmi {
 			compatible = "simple-framebuffer";
-			clocks = <&ahb_gates 36>, <&ahb_gates 43>, <&ahb_gates 44>;
+			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
+				 <&ahb_gates 44>;
 			status = "disabled";
 		};
 	};
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index aee7f25..c678e56 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -31,7 +31,8 @@
 
 		framebuffer0-hdmi {
 			compatible = "simple-framebuffer";
-			clocks = <&ahb_gates 36>, <&ahb_gates 43>, <&ahb_gates 44>;
+			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
+				 <&ahb_gates 44>;
 			status = "disabled";
 		};
 	};
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 04a5cb3..ccc03f3 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -69,6 +69,7 @@
 
 		framebuffer0-hdmi {
 			compatible = "simple-framebuffer";
+			clocks = <&pll6>;
 			status = "disabled";
 		};
 	};
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 58c1573..89766cb 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -71,7 +71,8 @@
 
 		framebuffer0-hdmi {
 			compatible = "simple-framebuffer";
-			clocks = <&ahb_gates 36>, <&ahb_gates 43>, <&ahb_gates 44>;
+			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
+				 <&ahb_gates 44>;
 			status = "disabled";
 		};
 	};
-- 
2.1.0
