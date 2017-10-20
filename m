From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 20 Oct 2017 14:16:20 +0900
Subject: [PATCH 1/2] ARM: dts: uniphier: add STDMAC clock to EHCI nodes
Message-ID: <1508476581-16483-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without the STDMAC clock enabled, the USB 2.0 hosts do not work.
This clock must be explicitly listed in the "clocks" property because
it is independent from the other clocks.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ld4.dtsi  | 9 ++++++---
 arch/arm/boot/dts/uniphier-pro4.dtsi | 6 ++++--
 arch/arm/boot/dts/uniphier-sld8.dtsi | 9 ++++++---
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index 18f7e73..ecab5f3 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -258,7 +258,8 @@
 			interrupts = <0 80 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb0>;
-			clocks = <&mio_clk 7>, <&mio_clk 8>, <&mio_clk 12>;
+			clocks = <&sys_clk 8>, <&mio_clk 7>, <&mio_clk 8>,
+				 <&mio_clk 12>;
 			resets = <&sys_rst 8>, <&mio_rst 7>, <&mio_rst 8>,
 				 <&mio_rst 12>;
 		};
@@ -270,7 +271,8 @@
 			interrupts = <0 81 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb1>;
-			clocks = <&mio_clk 7>, <&mio_clk 9>, <&mio_clk 13>;
+			clocks = <&sys_clk 8>, <&mio_clk 7>, <&mio_clk 9>,
+				 <&mio_clk 13>;
 			resets = <&sys_rst 8>, <&mio_rst 7>, <&mio_rst 9>,
 				 <&mio_rst 13>;
 		};
@@ -282,7 +284,8 @@
 			interrupts = <0 82 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb2>;
-			clocks = <&mio_clk 7>, <&mio_clk 10>, <&mio_clk 14>;
+			clocks = <&sys_clk 8>, <&mio_clk 7>, <&mio_clk 10>,
+				 <&mio_clk 14>;
 			resets = <&sys_rst 8>, <&mio_rst 7>, <&mio_rst 10>,
 				 <&mio_rst 14>;
 		};
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index 6bbca27..688e356 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -308,7 +308,8 @@
 			interrupts = <0 80 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb2>;
-			clocks = <&mio_clk 7>, <&mio_clk 8>, <&mio_clk 12>;
+			clocks = <&sys_clk 8>, <&mio_clk 7>, <&mio_clk 8>,
+				 <&mio_clk 12>;
 			resets = <&sys_rst 8>, <&mio_rst 7>, <&mio_rst 8>,
 				 <&mio_rst 12>;
 		};
@@ -320,7 +321,8 @@
 			interrupts = <0 81 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb3>;
-			clocks = <&mio_clk 7>, <&mio_clk 9>, <&mio_clk 13>;
+			clocks = <&sys_clk 8>, <&mio_clk 7>, <&mio_clk 9>,
+				 <&mio_clk 13>;
 			resets = <&sys_rst 8>, <&mio_rst 7>, <&mio_rst 9>,
 				 <&mio_rst 13>;
 		};
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index 39cc0e0..782ca99 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -262,7 +262,8 @@
 			interrupts = <0 80 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb0>;
-			clocks = <&mio_clk 7>, <&mio_clk 8>, <&mio_clk 12>;
+			clocks = <&sys_clk 8>, <&mio_clk 7>, <&mio_clk 8>,
+				 <&mio_clk 12>;
 			resets = <&sys_rst 8>, <&mio_rst 7>, <&mio_rst 8>,
 				 <&mio_rst 12>;
 		};
@@ -274,7 +275,8 @@
 			interrupts = <0 81 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb1>;
-			clocks = <&mio_clk 7>, <&mio_clk 9>, <&mio_clk 13>;
+			clocks = <&sys_clk 8>, <&mio_clk 7>, <&mio_clk 9>,
+				 <&mio_clk 13>;
 			resets = <&sys_rst 8>, <&mio_rst 7>, <&mio_rst 9>,
 				 <&mio_rst 13>;
 		};
@@ -286,7 +288,8 @@
 			interrupts = <0 82 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb2>;
-			clocks = <&mio_clk 7>, <&mio_clk 10>, <&mio_clk 14>;
+			clocks = <&sys_clk 8>, <&mio_clk 7>, <&mio_clk 10>,
+				 <&mio_clk 14>;
 			resets = <&sys_rst 8>, <&mio_rst 7>, <&mio_rst 10>,
 				 <&mio_rst 14>;
 		};
-- 
2.7.4
