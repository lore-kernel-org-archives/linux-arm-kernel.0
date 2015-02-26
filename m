From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:21:20 +0900
Subject: [PATCH 23/32] ARM: shmobile: emev2 dtsi: Add PFC information
In-Reply-To: <cover.1424849129.git.horms+renesas@verge.net.au>
References: <cover.1424849129.git.horms+renesas@verge.net.au>
Message-ID: <e7cdf791dbc456329703424822e85eeb31fc1a54.1424849129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Niklas S?derlund <niso@kth.se>

With this information all GPIOs can make use of the PFC functionality.

Signed-off-by: Niklas S?derlund <niso@kth.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index cc7bfe0..bb45694 100644
--- a/arch/arm/boot/dts/emev2.dtsi
+++ b/arch/arm/boot/dts/emev2.dtsi
@@ -169,12 +169,18 @@
 		clock-names = "sclk";
 	};
 
+	pfc: pfc at e0140200 {
+		compatible = "renesas,pfc-emev2";
+		reg = <0xe0140200 0x100>;
+	};
+
 	gpio0: gpio at e0050000 {
 		compatible = "renesas,em-gio";
 		reg = <0xe0050000 0x2c>, <0xe0050040 0x20>;
 		interrupts = <0 67 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 68 IRQ_TYPE_LEVEL_HIGH>;
 		gpio-controller;
+		gpio-ranges = <&pfc 0 0 32>;
 		#gpio-cells = <2>;
 		ngpios = <32>;
 		interrupt-controller;
@@ -186,6 +192,7 @@
 		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 70 IRQ_TYPE_LEVEL_HIGH>;
 		gpio-controller;
+		gpio-ranges = <&pfc 0 32 32>;
 		#gpio-cells = <2>;
 		ngpios = <32>;
 		interrupt-controller;
@@ -197,6 +204,7 @@
 		interrupts = <0 71 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 72 IRQ_TYPE_LEVEL_HIGH>;
 		gpio-controller;
+		gpio-ranges = <&pfc 0 64 32>;
 		#gpio-cells = <2>;
 		ngpios = <32>;
 		interrupt-controller;
@@ -208,6 +216,7 @@
 		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 74 IRQ_TYPE_LEVEL_HIGH>;
 		gpio-controller;
+		gpio-ranges = <&pfc 0 96 32>;
 		#gpio-cells = <2>;
 		ngpios = <32>;
 		interrupt-controller;
@@ -219,6 +228,7 @@
 		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 76 IRQ_TYPE_LEVEL_HIGH>;
 		gpio-controller;
+		gpio-ranges = <&pfc 0 128 31>;
 		#gpio-cells = <2>;
 		ngpios = <31>;
 		interrupt-controller;
-- 
2.1.4
