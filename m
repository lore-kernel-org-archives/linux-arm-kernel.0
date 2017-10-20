From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 20 Oct 2017 14:16:21 +0900
Subject: [PATCH 2/2] arm64: dts: uniphier: add STDMAC clock to EHCI nodes
In-Reply-To: <1508476581-16483-1-git-send-email-yamada.masahiro@socionext.com>
References: <1508476581-16483-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1508476581-16483-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without the STDMAC clock enabled, the USB 2.0 hosts do not work.
This clock must be explicitly listed in the "clocks" property because
it is independent from the other clocks.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 99f14cc..2c03d96 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -324,7 +324,8 @@
 			interrupts = <0 243 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb0>;
-			clocks = <&mio_clk 7>, <&mio_clk 8>, <&mio_clk 12>;
+			clocks = <&sys_clk 8>, <&mio_clk 7>, <&mio_clk 8>,
+				 <&mio_clk 12>;
 			resets = <&sys_rst 8>, <&mio_rst 7>, <&mio_rst 8>,
 				 <&mio_rst 12>;
 		};
@@ -336,7 +337,8 @@
 			interrupts = <0 244 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb1>;
-			clocks = <&mio_clk 7>, <&mio_clk 9>, <&mio_clk 13>;
+			clocks = <&sys_clk 8>, <&mio_clk 7>, <&mio_clk 9>,
+				 <&mio_clk 13>;
 			resets = <&sys_rst 8>, <&mio_rst 7>, <&mio_rst 9>,
 				 <&mio_rst 13>;
 		};
@@ -348,7 +350,8 @@
 			interrupts = <0 245 4>;
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
